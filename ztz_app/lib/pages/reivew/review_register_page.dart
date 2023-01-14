import 'package:flutter/material.dart';
import 'package:ztz_app/components/reivew/review_register/review_register_component.dart';
import 'package:ztz_app/utility/colors.dart';

import '../../utility/text_styles.dart';

class ReviewRegisterPage extends StatefulWidget{
  const ReviewRegisterPage({Key?key, required this.productName , required this.productId, required this.orderID}) : super (key: key);

  final String productName;
  final int productId , orderID;

  @override
  State<ReviewRegisterPage> createState() => _ReviewRegisterPage();
}

class _ReviewRegisterPage extends State<ReviewRegisterPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyle.termGray,
      appBar: AppBar(
        centerTitle: true,
        title: Text("리뷰 쓰기" , style: blackBoldTextStyle(15),),
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
        child: SingleChildScrollView(child: ReviewRegisterComponent(productId: widget.productId, productName: widget.productName, orderId: widget.orderID,)),
      ),
    );
  }

}