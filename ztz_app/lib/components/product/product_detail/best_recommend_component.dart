import 'package:flutter/material.dart';
import 'package:ztz_app/components/main_page_components/product_card.dart';
import 'package:ztz_app/controller/product/product_controller.dart';
import 'package:ztz_app/controller/product/product_infos/product_info.dart';
import 'package:ztz_app/controller/reivew/review_controller.dart';
import 'package:ztz_app/pages/product/product_detail_page.dart';

class BestRecommendComponent extends StatefulWidget {
  const BestRecommendComponent({Key? key}) : super(key: key);

  @override
  State<BestRecommendComponent> createState() => _BestRecommendComponentState();
}

class _BestRecommendComponentState extends State<BestRecommendComponent> {
  var bestProductList = [];

  @override
  void initState() {
    setBestProduct();
    super.initState();
  }

  void setBestProduct() async {
    await ProductController().requestBestProductFromSpring();
    setState(() {
      bestProductList = ProductInfo.bestProductList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: bestProductList.length == 0 ? showNullList() : showBestList(),
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
              bestProductList.length,
              (index) => Padding(
                    padding: EdgeInsets.zero,
                    child: ProductCard(
                      brand: bestProductList[index]['brand'],
                      price: bestProductList[index]['price'],
                      onTap: () {
                        selectProductCard(index);
                      },
                      title: bestProductList[index]['name'],
                      image: bestProductList[index]['productInfo']
                          ['thumbnailFileName'],
                      monthCheck: bestProductList[index]['monthAlcoholCheck'],
                    ),
                  ))),
    );
  }

  selectProductCard(index) async {
    await ProductController()
        .requestProductDetailToSpring(bestProductList[index]['productNo']);
    await ReviewController()
        .requestReviewAverageToSpring(bestProductList[index]['productNo']);
    await ReviewController()
        .requestProductReviewToSpring(bestProductList[index]['productNo']);

    Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => ProductDetailPage(productNo: bestProductList[index]['productNo'])));
  }
}
