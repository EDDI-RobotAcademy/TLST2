import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:ztz_app/components/product/product_detail/product_info_component.dart';
import 'package:ztz_app/controller/reivew/review_infos/review_info.dart';
import 'package:ztz_app/utility/colors.dart';

import '../../../controller/product/product_infos/product_info.dart';
import '../../../utility/text_styles.dart';
import '../../main_page_components/todays_recommend_component.dart';
class ProductDetailComponent extends StatefulWidget{
  const ProductDetailComponent ({Key?key, required this.productNo}) : super(key: key);

  final int productNo;
  @override
  _ProductDetailComponent createState() => _ProductDetailComponent();
}

class _ProductDetailComponent extends State<ProductDetailComponent>{

  late final String image;

  var numberFormat = NumberFormat('###,###,###,###');
  IconData? _selectedIcon;

  @override
  void initState() {
    ProductInfo().setProductDetailINfo();
    image = ProductInfo.thumbnailFileName;
    ReviewInfo().setReviewAve();
    super.initState();
  }

  @override
  void dispose(){
    ReviewInfo().resetReviewAve();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      child: Column(
        children: [
          Container(
            width: size.width,
            child: Image(image: AssetImage("assets/images/uploadImg/${image}"),fit:BoxFit.fill, width : size.width,),
          ),
          Container(
            margin: EdgeInsets.only(top:20, left: 15),
            child: SizedBox(
              width: size.width,
              child: Text('🍶'+ProductInfo.productName, textAlign: TextAlign.left, style: productDetailTitle(),),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top:3, left: 15),
            child: SizedBox(
              width: size.width,
              child: Text(ProductInfo.subTitle, textAlign: TextAlign.left, style: const TextStyle(
                color: ColorStyle.textGray,fontFamily: "NanumSquareNeo-cBd",fontSize: 10
              ),),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top:5, left: 15),
            child: SizedBox(
              width: size.width,
              child: Text(ProductInfo.taste.toString(), textAlign: TextAlign.left, style: xSmallPinkTextStyle()),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top:5, left: 15),
            width: size.width,
              child: Row(
              children: [
                ratingStar(),
                Text(ReviewInfo.reviewAverage.toString()),
                Text("/ 리뷰 "+ ReviewInfo.reviewCnt.toString() +"개")
              ],
            )
          ),
          Container(
            margin: EdgeInsets.only(top:20, left: 15 , bottom: 20),
            child: SizedBox(
              width: size.width,
              child: Text( numberFormat.format(ProductInfo.productPrice) +'원', textAlign: TextAlign.left, style: TextStyle(
              fontFamily: "NanumSquareNeo-bRg",fontSize: 20
              ),),
            ),
          ),
          const Divider(thickness : 1),
          Container(
            height: 70,
            margin: EdgeInsets.only( top: 15),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 15),
                  height: 65,
                  child: Text("🚛 배송비"),),
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 63),
                      child: SizedBox(
                          width: size.width - size.width/2,
                          child: Text(ProductInfo.deliveryFee.toString() + "원" , textAlign: TextAlign.left,)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 63),
                      child: SizedBox(
                          width: 200,
                          child: Text("ztz 모든 상품은 기본 무료배송입니다\n(일부 지역 배송이 지연될 수 있음)",style: mediumGrayTextStyle(),)),
                    ),
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 50,
            margin: EdgeInsets.only(left: 15),
            child: Row(
              children: [
                Container(
                  height: 65,
                  child: Text("⛺ 양조장"),),
                Container(
                  padding: EdgeInsets.only(left: 63),
                  height: 65,
                  child: Text(ProductInfo.productBrand),),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          const Divider(thickness : 12),
          Container(
            padding: EdgeInsets.only(bottom: 10),
            width: double.infinity,
            margin: EdgeInsets.only(top:12 , bottom: 5,left: 3),
            child: Text("💜 이런 상품은 어떠신가요?",style: productTitleTextStyle(),textAlign: TextAlign.left,),
          ),
          ToDaysRecommendComponent(),
          SizedBox(height: 20,),
          const Divider(thickness : 12),
          ProductInfoComponent()//Text(ProductInfo.productImagesName.toString()),
        ],
      ),
    );
  }

  Widget ratingStar(){
    return RatingBar.builder(
      ignoreGestures : true,
      initialRating: ReviewInfo.reviewAverage,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 15,
      itemPadding: const EdgeInsets.symmetric(horizontal: 1),
      itemBuilder: (context, _) => Icon(
        _selectedIcon ?? Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
      },
    );
  }

}