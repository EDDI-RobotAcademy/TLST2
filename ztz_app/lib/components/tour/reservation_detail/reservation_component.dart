

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ztz_app/components/tour/reservation_detail/reservation_card.dart';

import 'package:ztz_app/controller/tour/foundry_infos/foundry_info.dart';


class ReservationComponent extends StatefulWidget {
  const ReservationComponent({Key? key}) : super(key: key);

  @override
  _ReservationComponent createState() => _ReservationComponent();
}

class _ReservationComponent extends State<ReservationComponent> {

  var selectedFoundry = false;

  @override
  void initState() {
    FoundryInfo().setFoundryDetailInfo();
    super.initState();
    setFoundry();
  }

  void setFoundry() async {
    setState(() {
      selectedFoundry = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: selectedFoundry == false? isNullSelectFoundryList():isSelectFoundryList()
    );
  }

  Widget _buildFoundryList(){
    return Container(
      child: Text('양조장'),
    );
  }


  Widget isNullSelectFoundryList(){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(30),
      child: Text("협력하는 양조장이 없습니다."),
      decoration: BoxDecoration(
          border:Border.all(
              width:1,
              color: Colors.black
          ),
          borderRadius: BorderRadius.all(
              Radius.circular(3)
          )
      ),
    );
  }

  Widget isSelectFoundryList(){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
          children: [
            ReservationCard(
              image: FoundryInfo.foundryImgName,
              name: FoundryInfo.foundryName,
              address: FoundryInfo.foundryAddress,
              tel: FoundryInfo.foundryTel,
              content: FoundryInfo.foundryContent,
              onTap: () {
               //
              },
            )
          ]
      ),
    );
  }

}
