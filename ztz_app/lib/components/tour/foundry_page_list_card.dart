import 'package:flutter/material.dart';

import '../../utility/text_styles.dart';

class FoundryPageListCard extends StatelessWidget{
  const FoundryPageListCard({Key? key,
    //required this.변수명 -> ProductCard 위젯을 호출 시 사용하기 위한 파라미터. 해당 파라미터값 넣어서 호출해야함
    required this.image,
    required this.name,
    required this.address,
    required this.tel,
    required this.onTap,
    required this.content,}) : super(key: key);

  final String image, name, address, tel, content;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // width: double.infinity,
        height: 160,
        padding: EdgeInsets.all(3),
        margin:  EdgeInsets.all(10),
        // color: Colors.grey,
        child: Row(
          children: [
            Column(
              children: [
                SizedBox(width: 8,)
              ],
            ),
            Column(
              children: [
                Image(image: AssetImage("assets/images/foundryImg/${image}"), width: 150, height: 150,),
              ]
            ),
            Column(
              children: [
              SizedBox(width: 20,)
            ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // width: double.infinity,
              children: [
              Text("$name", style: xMediumBlackTextStyle(), ),
              SizedBox(height: 8,),
              Text("$address", style: MediumBlackTextStyle(), ),
              SizedBox(height: 8,),
              Text("$content", style: MediumBlackTextStyle(), ),
              SizedBox(height: 5,),
              Text("$tel" ),
              SizedBox(height: 5,),
            ]
            // SizedBox(height: 8,),
            )
          ],
        ),
      ),
      // onTap:,
      //클릭 이벤트
    );
  }
}