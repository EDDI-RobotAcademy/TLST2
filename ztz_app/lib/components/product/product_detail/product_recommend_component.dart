import 'package:flutter/material.dart';
import 'package:ztz_app/components/main_page_components/product_card.dart';
import 'package:ztz_app/controller/product/product_controller.dart';
import 'package:ztz_app/controller/product/product_infos/product_info.dart';
import 'package:ztz_app/controller/reivew/review_controller.dart';
import 'package:ztz_app/pages/product/product_detail_page.dart';

class ProductRecommendComponent extends StatefulWidget {
  const ProductRecommendComponent({Key? key}) : super(key: key);

  @override
  State<ProductRecommendComponent> createState() => _ProductRecommendComponentState();
}

class _ProductRecommendComponentState extends State<ProductRecommendComponent> {
  var recommendProductList = [];

  @override
  void initState() {
    setBestProduct();
    super.initState();
  }

  void setBestProduct() async {
    await ProductController().requestRecommendProductFromSpring();
    setState(() {
      recommendProductList = ProductInfo.recommendProductList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: recommendProductList.length == 0 ? showNullList() : showBestList(),
    );
  }

  Widget showNullList() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(30),
      child: Text("등록된 싱픔이 없습니다!!"),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black),
      ),
    );
  }

  Widget showBestList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children: List.generate(
              recommendProductList.length,
              (index) => Padding(
                    padding: EdgeInsets.zero,
                    child: ProductCard(
                      brand: recommendProductList[index]['brand'],
                      price: recommendProductList[index]['price'],
                      onTap: () {
                        selectProductCard(index);
                      },
                      title: recommendProductList[index]['name'],
                      image: recommendProductList[index]['productInfo']
                          ['thumbnailFileName'],
                      monthCheck: recommendProductList[index]['monthAlcoholCheck'],
                    ),
                  ))),
    );
  }

  selectProductCard(index) async {
    await ProductController()
        .requestProductDetailToSpring(recommendProductList[index]['productNo']);
    await ReviewController()
        .requestReviewAverageToSpring(recommendProductList[index]['productNo']);
    await ReviewController()
        .requestProductReviewToSpring(recommendProductList[index]['productNo']);

    Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => ProductDetailPage(productNo: recommendProductList[index]['productNo'])));
  }
}
