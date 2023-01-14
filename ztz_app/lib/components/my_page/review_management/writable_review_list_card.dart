
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ztz_app/pages/reivew/review_register_page.dart';
import 'package:ztz_app/utility/button_style.dart';

import '../../../utility/text_styles.dart';

class WritableReviewListCard extends StatefulWidget{
  const WritableReviewListCard ({Key?key,
    required this.image ,
    required this.productName,
    required this.orderState,
    required this.price,
    required this.orderCnt,
    required this.productId,
    required this.orderID
  }) : super (key: key);

  final String image, productName , orderState;
  final int price, orderCnt , productId , orderID;
  @override
  State<WritableReviewListCard> createState() => _WritableReviewListCard();
}

class _WritableReviewListCard extends State<WritableReviewListCard>{

  @override
  Widget build(BuildContext context) {
    var numberFormat = NumberFormat('###,###,###,###');
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 20),
            child: Image(
              image: AssetImage(
                  "assets/images/uploadImg/${widget.image}"),
              fit: BoxFit.fill,
              width: 50,
            ),
          ),
          SizedBox(width: 30),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.productName , ),
              Padding(
                padding: const EdgeInsets.only(top: 10 , bottom: 10),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(numberFormat.format(widget.price) + "원",style : blackBoldTextStyle(14)),
                    Text(" | " + widget.orderCnt.toString() + "개", style: grayLightTextStyle(14),),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.orderState == "PAYMENT_CONFIRM" ? "구매확정 ": "반품신청", style: blackBoldTextStyle(12)),
                  SizedBox(width: size.width - 270),
                ],
              ),
            ],
          ),
          OutlinedButton(onPressed: (){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ReviewRegisterPage(productName: widget.productName, productId: widget.productId, orderID: widget.orderID,)));
          }, child: Text("리뷰작성" ,style: blackTextStyle(14),) , style: defaultOutlinedButtonStyle(90, 8))
        ],
      ),
    );
  }
}