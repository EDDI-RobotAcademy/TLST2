import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../utility/text_styles.dart';

class PhotoReviewComponent extends StatelessWidget{
  const PhotoReviewComponent({Key?key,
    required this.content,
    required this.thumbnailFileName,
    required this.regDate,
    required this.username,
    required this.productName,
    required this.rate,}) : super(key: key);

  final String content , thumbnailFileName , regDate , username , productName;
  final double rate;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Column(
        children: [
          Image.asset("assets/images/item2.jpg"),
          SizedBox(height: 15,),
          ListTile(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:17,left: 10),
                  child: Text("작성자 : "+username , style: MediumBlackTextStyle(),textAlign: TextAlign.left,),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5,left: 10),
                  child: Text(productName , style: smallGrayTextStyle(),textAlign: TextAlign.left),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15,left: 10),
                  child: Text(content,textAlign: TextAlign.left),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 15,left: 10),
                    child: Text(regDate , style: smallGrayTextStyle(),textAlign: TextAlign.left)

                )
              ],
            ),
            trailing: ratingStar(),
          ),
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
}