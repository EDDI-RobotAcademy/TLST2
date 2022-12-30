import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:ztz_app/controller/reivew/review_infos/review_info.dart';
import 'package:ztz_app/utility/colors.dart';

import '../../components/product/product_detail/prdouct_buy_modal_component.dart';
import '../../components/product/product_detail/product_detail_appbar.dart';
import '../../components/product/product_detail/product_detail_component.dart';
import '../../utility/button_style.dart';
import '../../utility/text_styles.dart';

class ProductDetailPage extends StatefulWidget{
  const ProductDetailPage({Key?key}) : super (key: key);

  _ProductDetailPage createState() => _ProductDetailPage();
}
class _ProductDetailPage extends State<ProductDetailPage>{

  @override
  void initState() {
    ReviewInfo().setReviewAve();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: ProductDetailAppbar(reviewCnt: ReviewInfo.reviewCnt,),
          body: const TabBarView(
            children: [
              SafeArea(
                  child: SingleChildScrollView(
                    child: ProductDetailComponent(),
                  )
              ),
              SafeArea(
                  child: SingleChildScrollView(
                    child: ProductDetailComponent(),
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
                      child: Text("바로 구매",style: lageWhiteTextStyle(),)),
                )
              ],
            ),
          ),
        )
      ),
    );
  } 

}