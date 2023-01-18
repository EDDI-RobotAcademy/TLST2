import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ztz_app/components/layout/white_cart_app_bar.dart';
import 'package:ztz_app/components/tour/reservation_detail/reservation_Info.dart';

import 'package:ztz_app/components/tour/reservation_detail/foundry_map.dart';
import 'package:ztz_app/components/tour/reservation_detail/reservation_component.dart';
import 'package:ztz_app/controller/tour/foundry_infos/foundry_info.dart';
import 'package:ztz_app/utility/text_styles.dart';

import '../../components/tour/reservation_detail/reservation_form_component.dart';

class FoundryDetailPage extends StatefulWidget {
  const FoundryDetailPage({Key? key}) : super(key: key);

  _FoundryDetailPage createState() => _FoundryDetailPage();
}

class _FoundryDetailPage extends State<FoundryDetailPage> {

  @override
  void initState() {
    FoundryInfo().setFoundryDetailInfo();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: WhiteCartAppBar(title: "양조장",),
        body: SingleChildScrollView(
            child:Column(
                children:[
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top:20 , bottom: 12,left: 3),
                    child: Text("🍷 양조장 프로그램", style: productTitleTextStyle(),textAlign: TextAlign.left,),
                  ),
                  ReservationComponent(),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(top:10 , bottom: 12,left: 10),
                      child:  
                      Text("🚗 위치", style:xMediumBlackTextStyle(), textAlign: TextAlign.left,),
                      
                  ),
                  Container(
                    color: Colors.green,
                    width: double.infinity,
                    height: 180,
                    margin: EdgeInsets.only(top:10 , bottom: 12, left: 20, right: 20),
                    child: FoundryMap( lat: FoundryInfo.foundryLat, lng: FoundryInfo.foundryLng, name: FoundryInfo.foundryName)
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top:10 , bottom: 12,left: 10),
                    child:
                    Text("🍹 양조장 프로그램 안내", style:xMediumBlackTextStyle(), textAlign: TextAlign.left,),
                  ),
                  ReservationInfo(
                        foundryMinMember: FoundryInfo.foundryMinMember,
                        foundryDurationOfTime: FoundryInfo.foundryDurationOfTime,
                        foundryPrice: FoundryInfo.foundryPrice,
                        foundryContent: FoundryInfo.foundryContent),
                  Divider(
                    thickness: 1,
                    color: Colors.grey,
                    indent: 20,
                    endIndent: 20,
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top:10 , bottom: 12,left: 10),
                    child:
                    Text("📃 예약하기", style:xMediumBlackTextStyle(), textAlign: TextAlign.left,),
                  ),
                  ReservationFormComponent()
                ]
            )
        )
    );
  }
}
