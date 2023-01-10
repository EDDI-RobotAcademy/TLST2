import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:ztz_app/controller/product/product_infos/product_info.dart';
import 'package:ztz_app/controller/reivew/review_infos/review_info.dart';
import 'package:ztz_app/utility/colors.dart';

import '../../components/product/product_detail/prdouct_buy_modal_component.dart';
import '../../components/product/product_detail/product_detail_appbar.dart';
import '../../components/product/product_detail/product_detail_component.dart';
import '../../components/reivew/product_review_component.dart';
import '../../controller/product/product_infos/product_info.dart';
import '../../utility/button_style.dart';
import '../../utility/text_styles.dart';

class ProductDetailPage extends StatefulWidget{
  const ProductDetailPage({Key?key,required this.productNo}) : super (key: key);

  final int productNo;
  _ProductDetailPage createState() => _ProductDetailPage();
}
class _ProductDetailPage extends State<ProductDetailPage>{

  @override
  void initState() {
    callProductInfo();
    super.initState();
  }
  void callProductInfo() async {
    ProductInfo().setProductDetailINfo();
    ReviewInfo().setReviewAve();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: ProductDetailAppbar(reviewCnt: ReviewInfo.reviewCnt, productName: ProductInfo.productName,),
          body: TabBarView(
            children: [
              SafeArea(
                  child: SingleChildScrollView(
                    child: ProductDetailComponent(productNo: widget.productNo),
                  )
              ),
              SafeArea(
                  child: SingleChildScrollView(
                    child: ProductReviewComponent()
                  )
              ),
            ],
          ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Container(
                    width: 50,
                    height: 50,
                    padding: EdgeInsets.only(left: 2),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: ColorStyle.textGray)
                    ),
                    child: LikeButton(
                      likeBuilder: (bool isLiked) {
                        return isLiked ?
                        Icon(
                          Icons.favorite,
                          color:Colors.red,
                        ):
                        Icon(
                          Icons.favorite_border,
                          color:ColorStyle.mainColor,
                        )
                        ;
                      },
                    ),
                  ),
                ),
                Container(
                  child: ElevatedButton(
                      style:defaultElevatedButtonStyle(size.width - 80,50),
                      onPressed: (){
                        showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context){
                              return Container(
                                  height: 370,
                                  child: ProductBuyModalComponent()
                              );
                            }
                        );
                      },
                      child: Text("구매하기",style: lageWhiteTextStyle(),)),
                )
              ],
            ),
          ),
        )
      ),
    );
  } 

}