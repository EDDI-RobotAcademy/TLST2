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
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.all(10),
          margin:  EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Image(
                  image: AssetImage("assets/images/foundryImg/${image}"),
                  width: size.width,
                  height: 170,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Container(
                child: foundryInfo(),
              )
            ],
          )),
      // onTap:,
      //클릭 이벤트
    );
  }

  Widget foundryInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5,),
        Text("$name", style:TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        SizedBox(height: 5,),
        Text("$address", style: MediumBlackTextStyle(), ),
        SizedBox(height: 5,),
        Text("$content", style: xMediumBlackTextStyle(), ),
        SizedBox(height: 5,),
        Text("$tel" ),
      ],
    );
  }
}