import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ztz_app/utility/text_styles.dart';

import '../../../components/layout/menu_app_bar.dart';
import '../../../components/my_page/reservation_management/my_reservation_modify_form_component.dart';


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
        appBar: MenuAppBar(title: "์์ฝ ์์ ",),
        body: SingleChildScrollView(
            child:Column(
                children:[
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top:20 , bottom: 12,left: 10),
                    child:
                    Text("๐น ์์กฐ์ฅ ์์ฝ ์์  ์๋ด", style:xMediumBlackTextStyle(), textAlign: TextAlign.left,),
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
                    child: Text("๋ฐฉ๋ฌธํ์๊ณ  ์ถ์ ์์กฐ์ฅ ๋ณ๊ฒฝ์ ์์ฝ ์ทจ์ ํ ์ ๊ท ์์ฝ ์งํ ๋ถํ๋๋ฆฝ๋๋ค. ์ ๊ฒฐ์  ์์ฝ๊ฑด์ ์ํ QnA๊ฒ์ํ์ผ๋ก ๋ฌธ์์ฃผ์๊ธฐ ๋ฐ๋ผ๋ฉฐ, ์ด ์ธ ๋ฌธ์์ฌํญ์ ํด๋น ์์กฐ์ฅ์ผ๋ก ๋ฌธ์ ๋ถํ๋๋ฆฝ๋๋ค.",
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
                    Text("๐ ์์ฝ์์ ", style:xMediumBlackTextStyle(), textAlign: TextAlign.left,),
                  ),
                  MyReservationModifyFormComponent()
                ]
            )
        )
    );
  }
}
