import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ztz_app/components/reivew/reivew_card.dart';

import '../../controller/account/sign_up_infos/account_state.dart';
import '../../controller/reivew/review_controller.dart';
import '../../controller/reivew/review_infos/review_info.dart';

class ProductReviewComponent extends StatefulWidget{
  const ProductReviewComponent({Key?key}) : super (key:key);

  @override
  State<ProductReviewComponent> createState() => _ProductReviewComponent();
}

class _ProductReviewComponent extends State<ProductReviewComponent>{
  var numberFormat = NumberFormat('###,###,###,###');

  @override
  void initState(){
    callAllReview();
    super.initState();
  }

  void callAllReview() async{
    ReviewInfo().setReviewAve();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 15,bottom: 10),
              width: size.width,
              child: Text("총 " + numberFormat.format(ReviewInfo.reviewCnt) +"개의 리뷰" , textAlign: TextAlign.left,),
            ),
            const Divider(thickness : 1),
            Column(
                children: List.generate(
                    ReviewInfo.productReviews.length,
                        (index) => Padding(
                      padding: EdgeInsets.zero,
                      child: ReviewCard(
                        username: ReviewInfo.productReviews[index]['member']['username'],
                        content: ReviewInfo.productReviews[index]['content'],
                        productName: ReviewInfo.productReviews[index]['product']['name'],
                        regDate: ReviewInfo.productReviews[index]['regDate'],
                        thumbnailFileName: ReviewInfo.productReviews[index]['thumbnailFileName'] ?? "NoImage",
                        rate: ReviewInfo.productReviews[index]['rate'],
                        isWrittenByBuyer:  ReviewInfo.productReviews[index]['member']['id'] == AccountState.memberInfo['id']  ? true:false,
                        deleteReview: () {
                          ReviewController().requestDeleteReview(ReviewInfo.productReviews[index]['reviewNo']);
                        },
                        productId: ReviewInfo.productReviews[index]['product']['productNo'],
                        reviewNo: ReviewInfo.productReviews[index]['reviewNo'],
                        orderId: ReviewInfo.productReviews[index]['orderInfo']['orderID'],
                      ),
                    ))
            ),
          ],
        )
    );
  }

}