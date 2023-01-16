import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ztz_app/components/main_page_components/product_card.dart';
import 'package:ztz_app/controller/product/product_controller.dart';
import 'package:ztz_app/controller/product/product_infos/product_info.dart';
import 'package:ztz_app/controller/reivew/review_controller.dart';
import 'package:ztz_app/pages/product/product_detail_page.dart';
import 'package:ztz_app/utility/colors.dart';
import 'package:ztz_app/utility/text_styles.dart';

class BestListComponent extends StatefulWidget {
  const BestListComponent({Key? key, required this.drinkItem}) : super(key: key);

  final String drinkItem;

  @override
  State<BestListComponent> createState() => _BestListComponentState();
}

class _BestListComponentState extends State<BestListComponent> {

  bool isLoading = false;
  List<String> _localList = ['전체지역','서울경기','강원','충청','경상','전라','제주'];
  var _selectedLocal = '전체지역';
  double _removableWidgetSize = 150;
  bool _isStickyOnTop = false;

  ScrollController _mainScrollController = ScrollController();
  ScrollController _subScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
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
    setProduct();
  }

  void setProduct() async {
    switch (widget.drinkItem) {
      case "전체보기":
        await ProductController().requestBestProductFromSpring();
        break;
      case "소주증류주":
        await ProductController().requestBestProductByAlcoholType(widget.drinkItem);
        break;
      case "리큐르":
        await ProductController().requestBestProductByAlcoholType(widget.drinkItem);
        break;
      case "막걸리":
        await ProductController().requestBestProductByAlcoholType(widget.drinkItem);
        break;
      case "약주청주":
        await ProductController().requestBestProductByAlcoholType(widget.drinkItem);
        break;
      case "과실주":
        await ProductController().requestBestProductByAlcoholType(widget.drinkItem);
        break;
      case "기타주류":
        await ProductController().requestBestProductByAlcoholType(widget.drinkItem);
        break;
    }
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
      return Container( // 로딩 되면 나오는 위젯
        child: gridList(),
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
                      child: Image(image: AssetImage("assets/images/banner/best_banner.jpg"),fit: BoxFit.fill,)),
                  _getStickyWidget(),
                  GridView.count(
                    controller: _subScrollController,
                    padding: EdgeInsets.only(top: 4, right: 20),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    scrollDirection: Axis.vertical,
                    childAspectRatio: MediaQuery.of(context).size.height / 1500,
                    children: List.generate(ProductInfo.bestProductList.length, (index) =>
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: ProductCard(
                            brand: ProductInfo.bestProductList[index]['brand'],
                            price: ProductInfo.bestProductList[index]['price'],
                            onTap: () {
                              selectProductCard(index);
                            },
                            title: ProductInfo.bestProductList[index]['name'],
                            image: ProductInfo.bestProductList[index]['productInfo']['thumbnailFileName'],
                            monthCheck: ProductInfo.bestProductList[index]['monthAlcoholCheck'],
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
            Text("총" + ProductInfo.bestProductList.length.toString() +"개",style: MediumBlackTextStyle(),),
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
                  if(widget.drinkItem == "전체보기"){
                    if(_selectedLocal == "전체지역"){
                      setProduct();
                    }else{
                      requestBestProductByLocal(_selectedLocal);
                    }
                  }else{
                    if(_selectedLocal == "전체지역"){
                      setProduct();
                    }else{
                      requestBestProductByLocalAndType(widget.drinkItem , _selectedLocal);
                    }
                  }
                });
              },
            )
          ],
        )
    );
  }

  void requestBestProductByLocal(localName) async {
    await ProductController().requestBestProductByLocal(localName);
    setState(() {
      isLoading = true;
    });
  }

  void requestBestProductByLocalAndType(alcoholType , localName) async {
    await ProductController().requestBestProductByLocalAndAlcoholType(alcoholType , localName);
    setState(() {
      isLoading = true;
    });
  }


  void selectProductCard(int index) async {
    await ProductController().requestProductDetailToSpring(
        ProductInfo.bestProductList[index]['productNo']);
    await ReviewController().requestReviewAverageToSpring(
        ProductInfo.bestProductList[index]['productNo']);
    await ReviewController().requestProductReviewToSpring(
        ProductInfo.bestProductList[index]['productNo']);
    Get.to(
        ProductDetailPage(
          productNo: ProductInfo.bestProductList[index]['productNo'],
        ),
        //next page class
        duration: Duration(milliseconds: 500),
        //duration of transitions, default 1 sec
        transition: Transition.rightToLeft,
        //transition effect
        popGesture: true // 슬라이드로 뒤로가기
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
