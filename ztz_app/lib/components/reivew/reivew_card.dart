import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ztz_app/pages/home_page.dart';
import 'package:ztz_app/pages/reivew/review_modify_page.dart';

import '../../pages/reivew/photo_review_page.dart';
import '../../utility/text_styles.dart';

class ReviewCard extends StatelessWidget {
  ReviewCard(
      {Key? key,
      required this.content,
      required this.thumbnailFileName,
      required this.regDate,
      required this.username,
      required this.productName,
      required this.rate,
      required this.isWrittenByBuyer,
      required this.deleteReview,
      required this.reviewNo,
      required this.orderId,
      required this.productId})
      : super(key: key);

  final String content, thumbnailFileName, regDate, username, productName;
  final double rate;
  final int productId, reviewNo , orderId;
  final bool isWrittenByBuyer;
  final VoidCallback deleteReview;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Row(children: [
            SizedBox(
              width: 10,
            ),
            isWrittenByBuyer? Text(
              "작성자 : " + username,
              textAlign: TextAlign.left,
              style: MediumBlackTextStyle(),
            ) : Text(
              "작성자 : " + username.substring(0) + "**",
              textAlign: TextAlign.left,
              style: MediumBlackTextStyle(),
            ),
            SizedBox(
              width: size.width - (size.width / 1.8),
            ),
            ratingStar(),
          ]),
          Container(
            padding: EdgeInsets.only(left: 10, top: 10),
            width: size.width,
            child: Text(
              productName,
              textAlign: TextAlign.left,
              style: smallGrayTextStyle(),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 5, bottom: 5),
            width: size.width,
            child: thumbnailFileName == "NoImage"
                ? SizedBox(
                    width: 0,
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                        IconButton(
                          onPressed: () {
                            Get.to(
                                PhotoReviewPage(
                                  rate: rate,
                                  productName: productName,
                                  username: username,
                                  content: content,
                                  regDate: regDate,
                                  thumbnailFileName: thumbnailFileName,
                                ), //next page class
                                duration: Duration(milliseconds: 500),
                                //duration of transitions, default 1 sec
                                transition: Transition.rightToLeft,
                                //transition effect
                                popGesture: true // 슬라이드로 뒤로가기
                                );
                          },
                          icon: Image.asset(
                              "assets/images/uploadImg/$thumbnailFileName"),
                          iconSize: 80,
                        )
                      ]),
          ),
          Container(
              padding: EdgeInsets.only(left: 10, top: 10),
              width: size.width,
              child: Text(
                content,
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: "NanumSquareNeo-cBd",
                    color: Colors.black),
              )),
          Container(
            width: size.width,
            padding: EdgeInsets.all(10),
            child: Text(
              regDate,
              textAlign: TextAlign.left,
              style: mediumGrayTextStyle(),
            ),
          ),
          Container(
            child: isWrittenByBuyer ? Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(onPressed: () {
                  Get.to(() => ReviewModifyPage(productName: productName, productId: productId, reviewNo: reviewNo, orderId: orderId,));
                }, child: Text("수정" ,style: blackBoldTextStyle(10),)),
                TextButton(onPressed: () {
                  showCheckPassword(context);

                }, child: Text("삭제", style: blackBoldTextStyle(10))),
              ],
            ) : null,
          ),
          const Divider(thickness: 1),
        ],
      ),
    );
  }

  Widget ratingStar() {
    return RatingBar.builder(
      ignoreGestures: true,
      initialRating: rate,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 15,
      itemPadding: const EdgeInsets.symmetric(horizontal: 1),
      itemBuilder: (context, _) => Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {},
    );
  }

  void showCheckPassword(context){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("정말로 삭제하시겠습니까?"),
          actions: <Widget>[
            FlatButton(
              child: const Text("삭제"),
              onPressed: () {
                deleteReview();
                Navigator.pop(context);
                showSuccessDelete(context);
              },
            ),
            FlatButton(
              child: const Text("취소"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void showSuccessDelete(context){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("삭제가 성공적으로 되었습니다!"),
          actions: <Widget>[
            FlatButton(
              child: const Text("확인"),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => HomePage()),
                        (route) => false
                );
              },
            ),
          ],
        );
      },
    );
  }
}
