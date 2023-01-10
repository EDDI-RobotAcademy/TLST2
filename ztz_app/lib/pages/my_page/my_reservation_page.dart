
import 'package:flutter/material.dart';
import 'package:ztz_app/components/layout/white_menu_app_bar.dart';
import 'package:ztz_app/components/my_page/my_reservation_list.dart';

class MyReservationPage extends StatefulWidget {
  const MyReservationPage({Key? key}) : super(key: key);

  _MyReservationPage createState() => _MyReservationPage();
}

class _MyReservationPage extends State<MyReservationPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:WhiteMenuAppBar(title: "예약 관리",),
        body: SingleChildScrollView(
          child:Column(
            children:[
              Container(
                width: double.infinity,
                  margin: EdgeInsets.only(top:10 , bottom: 12),
                  child: Image(image: AssetImage("assets/images/banner/second_banner5.jpg"), )
              ),
              MyReservationList(),
            ]
        )
        )
    );
  }
}
