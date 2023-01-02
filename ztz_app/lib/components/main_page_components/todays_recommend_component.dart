import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ztz_app/components/main_page_components/product_card.dart';
import 'package:ztz_app/controller/product/product_infos/product_info.dart';
import 'package:ztz_app/controller/reivew/review_controller.dart';
import 'package:ztz_app/pages/product/product_detail_page.dart';

import '../../controller/product/product_controller.dart';

class ToDaysRecommendComponent extends StatefulWidget {
  const ToDaysRecommendComponent({Key?key}) : super(key: key);

  @override
  _ToDaysRecommendComponent createState() => _ToDaysRecommendComponent();
}

class _ToDaysRecommendComponent extends State<ToDaysRecommendComponent>{
  var productList = false;
  @override
  void initState() {
    super.initState(); 
    setProduct();
  }

  void setProduct() async {
    await ProductController().requestAllProductToSpring("");
    setState(() {
      productList = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
          children: [
            SizedBox(
              child: productList == false ? isNullProductList():isProductList()
            )
          ],
        )
    );
  }

  Widget isNullProductList(){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(30),
      child: Text("등록된 싱픔이 없습니다!!"),
      decoration: BoxDecoration(
          border:Border.all(
              width:1,
              color: Colors.black
          ),
          borderRadius: BorderRadius.all(
              Radius.circular(3)
          )
      ),
    );
  }

  Widget isProductList(){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
            ProductInfo.productList.length,
            (index) => Padding(
              padding: EdgeInsets.zero,
              child: ProductCard(
                brand: ProductInfo.productList[index]['brand'],
                price: ProductInfo.productList[index]['price'],
                onTap: () {
                  selectProductCard(index);
                },
                title: ProductInfo.productList[index]['name'],
                image: ProductInfo.productList[index]['productInfo']['thumbnailFileName'],
              ),
            )
        )
      ),
    );
  }

  selectProductCard(index) async {
    await ProductController().requestProductDetailToSpring(ProductInfo.productList[index]['productNo']);
    await ReviewController().requestReviewAverageToSpring(ProductInfo.productList[index]['productNo']);
    await ReviewController().requestProductReviewToSpring(ProductInfo.productList[index]['productNo']);
    Get.to(
        ProductDetailPage(productNo: ProductInfo.productList[index]['productNo'],), //next page class
        duration: Duration(milliseconds: 500), //duration of transitions, default 1 sec
        transition: Transition.rightToLeft,//transition effect
        popGesture : true // 슬라이드로 뒤로가기
    );
  }

}