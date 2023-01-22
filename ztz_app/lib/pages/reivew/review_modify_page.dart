import 'package:flutter/material.dart';
import 'package:ztz_app/components/reivew/review_register/review_modify_component.dart';
import 'package:ztz_app/components/reivew/review_register/review_register_component.dart';

import '../../utility/colors.dart';
import '../../utility/text_styles.dart';

class ReviewModifyPage extends StatefulWidget{
  const ReviewModifyPage({Key?key,
    required this.productName ,
    required this.productId ,
    required this.reviewNo,
    required this.orderId,
    required this.content,
    required this.rate,
    required this.thumbnailFileName
  }) : super (key: key);

  final String productName, content, thumbnailFileName;
  final int productId , reviewNo , orderId;
  final double rate;
  @override
  State<ReviewModifyPage> createState() => _ReviewModifyPage();
}

class _ReviewModifyPage extends State<ReviewModifyPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.termGray,
      appBar: AppBar(
        centerTitle: true,
        title: Text("리뷰 수정" , style: blackBoldTextStyle(15),),
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.clear,
              color: Colors.black,
            )),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: ReviewModifyComponent(
          productId: widget.productId,
          productName: widget.productName,
          reviewNo: widget.reviewNo,
          orderId: widget.orderId,
          rate: widget.rate,
          content: widget.content,
          thumbnailFileName: widget.thumbnailFileName,
        )),
      ),
    );
  }

}