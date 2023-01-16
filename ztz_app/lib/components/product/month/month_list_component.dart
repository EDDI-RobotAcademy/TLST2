import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ztz_app/components/main_page_components/product_card.dart';
import 'package:ztz_app/controller/product/product_controller.dart';
import 'package:ztz_app/controller/product/product_infos/product_info.dart';
import 'package:ztz_app/controller/reivew/review_controller.dart';
import 'package:ztz_app/pages/product/product_detail_page.dart';
import 'package:ztz_app/utility/colors.dart';
import 'package:ztz_app/utility/text_styles.dart';

class MonthListComponent extends StatefulWidget {
  const MonthListComponent({Key? key}) : super(key: key);

  @override
  State<MonthListComponent> createState() => _MonthListComponentState();
}

class _MonthListComponentState extends State<MonthListComponent> {

  List<String> _localList = ['전체지역','서울경기','강원','충청','경상','전라','제주'];
  String _selectedLocal = '전체지역';
  double _removableWidgetSize = 150;
  bool isLoading = false;
  bool _isStickyOnTop = false;

  ScrollController _mainScrollController = ScrollController();
  ScrollController _subScrollController = ScrollController();


  void initState() {
    _mainScrollController.addListener(() {
      if (_mainScrollController.offset >= _removableWidgetSize &&
          !_isStickyOnTop) {
        _isStickyOnTop = true;
        setState(() {});
      } else if (_mainScrollController.offset < _removableWidgetSize &&
          _isStickyOnTop) {
        _isStickyOnTop = false;
        setState(() {});
      }
    });
    getMonthProduct();
    super.initState();
  }

  void getMonthProduct() async{
    await ProductController().requestMonthProductFromSpring();
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isLoading) { // 로딩 판단 유무
      return const Padding( // 로딩시 나오는 동그라미 동글동글
        padding: EdgeInsets.all(100),
        child: Center(
          child: CircularProgressIndicator(
            color: ColorStyle.mainColor,
          ),
        ),
      );
    } else {
      return Container(
        child: gridList(),// 로딩 되면 나오는 위젯
      );
    }
  }

  Widget gridList() {
    return Column(
      children: [
        Flexible(
          child: Stack(
            children: [
              ListView(
                controller: _mainScrollController,
                shrinkWrap: true,
                children: [
                  Container(
                      height: _removableWidgetSize,
                      child: Image(image: AssetImage("assets/images/banner/month_banner.png"),fit: BoxFit.fill,)),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(top: 15,left: 15, right: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xffc7d6cd),
                        boxShadow: [
                        ],
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        )
                    ),
                    child: Text("ZTZ가 선정한 이달의 술을 10% 할인된 가격에 만나보세요!",
                      style: TextStyle(color: Colors.grey.shade700,)
                    ),
                  ),
                  _getStickyWidget(),
                  GridView.count(
                    controller: _subScrollController,
                    padding: EdgeInsets.only(top: 4, right: 20),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    scrollDirection: Axis.vertical,
                    childAspectRatio: MediaQuery.of(context).size.height / 1500,
                    children: List.generate(ProductInfo.productList.length, (index) =>
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: ProductCard(
                            brand: ProductInfo.productList[index]['brand'],
                            price: ProductInfo.productList[index]['price'],
                            onTap: () {
                              selectProductCard(index);
                            },
                            title: ProductInfo.productList[index]['name'],
                            image: ProductInfo.productList[index]['productInfo']['thumbnailFileName'],
                            monthCheck: ProductInfo.productList[index]['monthAlcoholCheck'],
                          ),
                        )
                    ),
                  )
                ],
              ),
              if (_isStickyOnTop) _getStickyWidget()
            ],
          ),
        ),
      ],
    );
  }
  Container _getStickyWidget() {
    Size size = MediaQuery.of(context).size;
    return Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 30 , top: 5, bottom: 5),
        child: Row(
          children: [
            Text("총" + ProductInfo.productList.length.toString() +"개",style: MediumBlackTextStyle(),),
            SizedBox(
              width: size.width - (size.width / 2.5),
            ),
            DropdownButton(
              style: MediumBlackTextStyle(),
              underline : Container(),
              value: _selectedLocal,
              items: _localList.map(
                    (String value) {
                  return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value)
                  );
                },
              ).toList(),
              onChanged: (String? value) {
                setState(() {
                  isLoading = false;
                  _selectedLocal = value!;
                  if(_selectedLocal == "전체지역"){
                    getMonthProduct();
                  }else{
                    requestMonthProductByLocal(_selectedLocal);
                  }
                });
              },
            )
          ],
        )
    );
  }

  void requestMonthProductByLocal(localName) async {
    await ProductController().requestMonthProductByLocal(localName);
    setState(() {
      isLoading = true;
    });
  }

  void selectProductCard(int index) async {
    await ProductController().requestProductDetailToSpring(
        ProductInfo.productList[index]['productNo']);
    await ReviewController().requestReviewAverageToSpring(
        ProductInfo.productList[index]['productNo']);
    await ReviewController().requestProductReviewToSpring(
        ProductInfo.productList[index]['productNo']);
    Get.to(
        ProductDetailPage(
          productNo: ProductInfo.productList[index]['productNo'],
        ),
        //next page class
        duration: Duration(milliseconds: 500),
        //duration of transitions, default 1 sec
        transition: Transition.rightToLeft,
        //transition effect
        popGesture: true // 슬라이드로 뒤로가기
    );
  }

}
