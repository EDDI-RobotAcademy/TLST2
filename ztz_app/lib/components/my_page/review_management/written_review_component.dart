import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../controller/account/sign_up_infos/account_state.dart';
import '../../../controller/reivew/review_controller.dart';
import '../../../controller/reivew/review_infos/review_info.dart';
import '../../../utility/colors.dart';
import '../../reivew/reivew_card.dart';

class WrittenReviewComponent extends StatefulWidget {
  const WrittenReviewComponent({Key? key}) : super(key: key);

  @override
  State<WrittenReviewComponent> createState() => _WrittenReviewComponent();
}

class _WrittenReviewComponent extends State<WrittenReviewComponent> {
  var numberFormat = NumberFormat('###,###,###,###');
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setMemberReview();
  }

  void setMemberReview() async {
    await ReviewController()
        .requestMyPageReviewToSpring(AccountState.memberInfo['id']);
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return !isLoading
        ? const Padding(
            // 로딩시 나오는 동그라미 동글동글
            padding: EdgeInsets.all(100),
            child: Center(
              child: CircularProgressIndicator(
                color: ColorStyle.mainColor,
              ),
            ),
          )
        : Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 15, bottom: 10),
                  width: size.width,
                  child: Text(
                    "총 " +
                        numberFormat.format(ReviewInfo.memberReviews.length) +
                        "개의 리뷰",
                    textAlign: TextAlign.left,
                  ),
                ),
                const Divider(thickness: 1),
                Column(
                    children: List.generate(
                        ReviewInfo.memberReviews.length,
                        (index) => Padding(
                              padding: EdgeInsets.zero,
                              child: ReviewCard(
                                username: ReviewInfo.memberReviews[index]['member']['username'],
                                content: ReviewInfo.memberReviews[index]['content'],
                                productName: ReviewInfo.memberReviews[index]['product']['name'],
                                regDate: ReviewInfo.memberReviews[index]['regDate'],
                                thumbnailFileName: ReviewInfo.memberReviews[index]['thumbnailFileName'] ??
                                    "NoImage",
                                rate: ReviewInfo.memberReviews[index]['rate'],
                                isWrittenByBuyer: true,
                                deleteReview: () {
                                  ReviewController().requestDeleteReview(
                                      ReviewInfo.memberReviews[index]
                                          ['reviewNo']);
                                },
                                productId: ReviewInfo.memberReviews[index]
                                    ['product']['productNo'],
                                reviewNo: ReviewInfo.memberReviews[index]
                                    ['reviewNo'],
                                orderId: ReviewInfo.memberReviews[index]
                                    ['orderInfo']['orderID'],
                              ),
                            ))),
              ],
            ),
          );
  }
}
