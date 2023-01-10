import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ztz_app/utility/text_styles.dart';

import '../../components/layout/menu_app_bar.dart';
import '../../components/my_page/my_reservation_modify_form_component.dart';

class MyReservationModifyDetailPage extends StatefulWidget {
  const MyReservationModifyDetailPage({Key? key}) : super(key: key);

  _MyReservationModifyDetailPage createState() => _MyReservationModifyDetailPage();
}

class _MyReservationModifyDetailPage extends State<MyReservationModifyDetailPage> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MenuAppBar(title: "예약 수정",),
        body: SingleChildScrollView(
            child:Column(
                children:[
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top:20 , bottom: 12,left: 10),
                    child:
                    Text("🍹 양조장 예약 수정 안내", style:xMediumBlackTextStyle(), textAlign: TextAlign.left,),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(25),
                    margin: const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Color(0xffc7d6cd),
                        boxShadow: [
                        ],
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        )
                    ),
                    child: Text("방문하시고 싶은 양조장 변경은 예약 취소 후 신규 예약 진행 부탁드립니다. 선결제 예약건은 상품 QnA게시판으로 문의주시기 바라며, 이 외 문의사항은 해당 양조장으로 문의 부탁드립니다.",
                      style: TextStyle(color: Colors.grey.shade700,
                        // fontWeight: FontWeight.w700,
                      ),),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top:20 , bottom: 12,left: 10),
                    child:
                    Text("📃 예약수정", style:xMediumBlackTextStyle(), textAlign: TextAlign.left,),
                  ),
                  MyReservationModifyFormComponent()
                ]
            )
        )
    );
  }
}
