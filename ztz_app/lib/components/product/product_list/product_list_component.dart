import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controller/product/product_controller.dart';
import '../../../controller/product/product_infos/product_info.dart';
import '../../../controller/reivew/review_controller.dart';
import '../../../pages/product/product_detail_page.dart';
import '../../../utility/colors.dart';
import '../../../utility/text_styles.dart';
import '../../main_page_components/product_card.dart';

class ProductListComponent extends StatefulWidget {
  const ProductListComponent({Key? key, required this.drinkItem}) : super(key: key);

  final String drinkItem;

  @override
  State<ProductListComponent> createState() => _ProductListComponent();
}

class _ProductListComponent extends State<ProductListComponent> {

  bool isSubLoading = true;
  bool isLoading = false;
  List<String> _localList = ['전체지역','서울경기','강원','충청','경상','전라','제주'];
  var _selectedLocal = '전체지역';
  ScrollController _mainScrollController = ScrollController(initialScrollOffset: 5.0);
  ScrollController _subScrollController = ScrollController();

  double _removableWidgetSize = 150;
  bool _isStickyOnTop = false;

  void setProduct() async {
    switch (widget.drinkItem) {
      case "전체보기":
        await ProductController().requestAllProductToSpring("");
        break;
      case "소주증류주":
        await ProductController().requestProductByAlcoholType(widget.drinkItem);
        break;
      case "리큐르":
        await ProductController().requestProductByAlcoholType(widget.drinkItem);
        break;
      case "막걸리":
        await ProductController().requestProductByAlcoholType(widget.drinkItem);
        break;
      case "약주청주":
        await ProductController().requestProductByAlcoholType(widget.drinkItem);
        break;
      case "과실주":
        await ProductController().requestProductByAlcoholType(widget.drinkItem);
        break;
      case "기타주류":
        await ProductController().requestProductByAlcoholType(widget.drinkItem);
        break;
    }
    setState(() {
      isLoading = true;
    });
  }

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
    _mainScrollController.addListener(_scrollListener);
    setProduct();
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
                      child: Image(image: AssetImage("assets/images/bigSale.jpg"),fit: BoxFit.fill,)),
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
                  ),
                  !isSubLoading ? Padding( // 로딩시 나오는 동그라미 동글동글
                    padding: EdgeInsets.all(50),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: ColorStyle.mainColor,
                      ),
                    ),
                  ):SizedBox()
                ],
              ),
              if (_isStickyOnTop) _getStickyWidget()
            ],
          ),
        ),
      ],
    );
  }

  _scrollListener() async {

    if( ProductInfo.productList.length >= 8){
      if (_mainScrollController.offset >=
          _mainScrollController.position.maxScrollExtent &&
          !_mainScrollController.position.outOfRange) {

        setState(() {
          isSubLoading = false;
        });
        var productLen = ProductInfo.productList.length;
        var lastProductNo = ProductInfo.productList[productLen - 1]['productNo'];

        debugPrint("lastProductNo" + lastProductNo.toString());

        if(widget.drinkItem == "전체보기"){
          if(_selectedLocal == "전체지역"){
            // 전체 타입에 전체 지역 - 전체 추가
            debugPrint("전체 타입에 전체 지역 - 전체 추가");
            await ProductController().requestNextPageProduct("",lastProductNo);
          }else{
            // 전체 타입에 특정 지역 - 지역 필터
            debugPrint("전체 타입에 특정 지역 - 지역 필터");
            await ProductController().requestNextPageLocalProduct(_selectedLocal,lastProductNo);
          }
        }else{
          if(_selectedLocal == "전체지역"){
            // 특정 타입에 전체 지역 - 타입 필터
            debugPrint("특정 타입에 전체 지역 - 타입 필터");
            await ProductController().requestNextPageAlcoholTypeProduct(widget.drinkItem,lastProductNo);
          }else{
            // 특정 타입에 특정 지역 - 타입 지역 필터
            debugPrint("특정 타입에 특정 지역 - 타입 지역 필터");
            await ProductController().requestNextPageAlcoholTypeAndLocalProduct(widget.drinkItem,_selectedLocal,lastProductNo);
          }
        }

        debugPrint("스크롤 테스트");
        setState(() {
          isSubLoading = true;
        });
      }
    }

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
                if(widget.drinkItem == "전체보기"){
                  if(_selectedLocal == "전체지역"){
                    setProduct();
                  }else{
                    requestProductByLocal(_selectedLocal);
                  }
                }else{
                  if(_selectedLocal == "전체지역"){
                    setProduct();
                  }else{
                    requestProductByLocalAndType(widget.drinkItem , _selectedLocal);
                  }
                }
              });
            },
          )
        ],
      )
    );
  }

  void requestProductByLocal(localName) async {
    await ProductController().requestProductByLocal(localName);
    setState(() {
      isLoading = true;
    });
  }

  void requestProductByLocalAndType(alcoholType , localName) async {
    await ProductController().requestProductByLocalAndAlcoholType(alcoholType , localName);
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

  @override
  void dispose() {
    super.dispose();
  }
}
