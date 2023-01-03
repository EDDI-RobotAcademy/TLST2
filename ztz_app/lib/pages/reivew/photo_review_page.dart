import 'package:flutter/material.dart';

import '../../components/reivew/photo_review_component.dart';
import '../../utility/text_styles.dart';


class PhotoReviewPage extends StatelessWidget{
  const PhotoReviewPage({Key?key,
    required this.content,
    required this.thumbnailFileName,
    required this.regDate,
    required this.username,
    required this.productName,
    required this.rate,}) : super (key: key);

  final String content , thumbnailFileName , regDate , username , productName;
  final double rate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text("사진후기",style: xMediumBlackTextStyle(),),
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          child: const Padding(
            padding: EdgeInsets.only(top: 13,bottom: 10),
            child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black,),
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
              child: PhotoReviewComponent(
                rate: rate, thumbnailFileName: thumbnailFileName, regDate: regDate, productName: productName, content: content, username: username,)
          )
      ),
    );
  }
}