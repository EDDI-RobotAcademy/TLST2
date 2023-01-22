
import 'package:flutter/material.dart';
import 'package:ztz_app/components/layout/white_menu_app_bar.dart';

import '../../../components/manager_page/reservation_management/all_reservation_list.dart';

class AllReservationPage extends StatefulWidget {
  const AllReservationPage({Key? key}) : super(key: key);

  _AllReservationPage createState() => _AllReservationPage();
}

class _AllReservationPage extends State<AllReservationPage> {

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
              AllReservationList(),
            ]
        )
        )
    );
  }
}
