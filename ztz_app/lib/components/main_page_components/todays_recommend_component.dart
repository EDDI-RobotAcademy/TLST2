import 'package:flutter/material.dart';
import 'package:ztz_app/components/main_page_components/product_card.dart';
import 'package:ztz_app/controller/product/product_infos/product_info.dart';

import '../../controller/product/product_controller.dart';
import '../../utility/text_styles.dart';

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
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top:12 , bottom: 5,left: 3),
              child: Text("👍 오늘의 추천 ZTZ",style: productTitleTextStyle(),textAlign: TextAlign.left,),
            ),
            SizedBox(
              child: productList == false? isNullProductList():isProductList()
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
                onTap: () {  },
                title: ProductInfo.productList[index]['name'],
                image: ProductInfo.productList[index]['productInfo']['thumbnailFileName'],
              ),
            )
        )
      ),
    );
  }

}