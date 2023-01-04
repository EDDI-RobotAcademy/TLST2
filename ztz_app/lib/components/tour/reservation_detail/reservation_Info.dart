import 'package:flutter/material.dart';

class ReservationInfo extends StatelessWidget{
  const ReservationInfo({Key? key,
    //required this.변수명 -> ProductCard 위젯을 호출 시 사용하기 위한 파라미터. 해당 파라미터값 넣어서 호출해야함
    required this.foundryMinMember,
    required this.foundryDurationOfTime,
    required this.foundryPrice,
    required this.foundryContent
    ,}) : super(key: key);

  final int foundryMinMember, foundryDurationOfTime, foundryPrice;
  final String foundryContent;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(3),
        margin:  EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text("프로그램 내용: ",  ),
                SizedBox(height: 8,),
                Text("체험 시간: ", ),
                SizedBox(height: 8,),
                Text("최소 인원: ",  ),
                SizedBox(height: 8,),
                Text("금액: ",  ),
                // SizedBox(height: 8,),
              ],
            ),
            Column(
              children: [
                SizedBox(width:50),
              ]
            ),
            Column(
              children: [
              Text("$foundryContent" ),
              SizedBox(height: 8,),
              Text("약 $foundryDurationOfTime 시간", ),
              SizedBox(height: 8,),
              Text(" $foundryMinMember 명",  ),
              SizedBox(height: 8,),
              Text(" 인당 $foundryPrice 원",  ),
            ]
            )
          ],
        ),
      ),

    );
  }
}