import 'package:flutter/material.dart';

import '../../utility/text_styles.dart';

class MainFoundryListCard extends StatelessWidget{
  const MainFoundryListCard({Key? key,
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
        width: 160,
        padding: const EdgeInsets.all(3),
        margin: const EdgeInsets.all(5),
        // color: Colors.blue,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Image(image: AssetImage("assets/images/foundryImg/${image}"), width: 150, height: 150,),
            ),
            SizedBox(height: 8,),
            Text("$name",overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700) ),
            SizedBox(height: 5,),
            Container(
              height: 20,
              child:  Text("$address", style: TextStyle(fontSize: 14) ),
            ),
            SizedBox(height: 5,),
            Text("$content" ),
            SizedBox(height: 20,),
            
          ],
        ),
      ),
      // onTap:,
      //클릭 이벤트
    );
  }
}