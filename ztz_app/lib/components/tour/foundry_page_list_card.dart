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
        padding: EdgeInsets.all(10),
        margin:  EdgeInsets.only(top: 10, bottom: 10),

        decoration: BoxDecoration(
        ),
        child: Row(
          children: [
            Column(
              children: [
                SizedBox(width: 5,)
              ],
            ),
            Column(
              children: [
                Image(image: AssetImage("assets/images/foundryImg/${image}"), width: 170, height: 170,),
              ]
            ),
            Column(
              children: [
              SizedBox(width: 10,)
            ],
            ),
             Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text("$name", style:TextStyle(fontSize: 18, fontWeight: FontWeight.w700), ),
                SizedBox(height: 15,),
                Text("$address", style: MediumBlackTextStyle(), ),
                SizedBox(height: 15,),
                Text("$content", style: xMediumBlackTextStyle(), ),
                SizedBox(height: 15,),
                Text("$tel" ),
                ]
              // SizedBox(height: 8,),
              ),
          ],
        ),
      ),
      // onTap:,
      //클릭 이벤트
    );
  }
}