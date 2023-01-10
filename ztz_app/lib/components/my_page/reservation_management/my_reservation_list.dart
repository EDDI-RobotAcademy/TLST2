import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../../controller/account/sign_up_infos/account_state.dart';
import '../../../controller/tour/foundry_infos/foundry_info.dart';
import '../../../controller/tour/reservation_controller.dart';
import 'my_reservation_list_card.dart';

class MyReservationList extends StatefulWidget {
  const MyReservationList({Key? key}) : super(key: key);

  @override
  _MyReservationList createState() => _MyReservationList();
}

class _MyReservationList extends State<MyReservationList> {

  var getMyReservationList = false;

  @override
  void initState() {
    setMyReservation();
    super.initState();
  }

  void setMyReservation() async {
    await ReservationController().requestMyReservationToSpring(AccountState.accountGet.token.string);
    setState(() {
      if(FoundryInfo.reservationList.length > 0){
        getMyReservationList = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              margin: const EdgeInsets.only(left: 15, right: 15),
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
              child: Text("양조장 예약은 양조장의 사정으로 인해 취소 될 수 있으며, 양조장에서 개별 연락이 갈 수 있습니다. 양조장 프로그램은 우천이나 인원, 안전 등의 이유로 변경 될 수 있음을 안내드립니다. 관련 문의사항은 해당 양조장으로 문의 부탁드립니다.",
                      style: TextStyle(color: Colors.grey.shade700,
                                      // fontWeight: FontWeight.w700,
                      ),),
            ),
            getMyReservationList == false? isNullReservationList():isMyReservationist()
          ],
        ),

    );
  }

  Widget isNullReservationList(){
    return Container(
      margin:  EdgeInsets.all(40),
      child: Text("양조장 예약 내역이 없습니다."),

    );
  }

  Widget isMyReservationist(){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
            children: List.generate(
            FoundryInfo.reservationList.length,
                (index) => Padding(
                padding: EdgeInsets.zero,
                child: MyReservationListCard(
                    reservationId : FoundryInfo.reservationList[index]['reservationId'],
                    reservationNumberOfMember: FoundryInfo.reservationList[index]['numberOfMember'],
                    paymentState: FoundryInfo.reservationList[index]['paymentReservation']['paymentState'],
                    totalPaymentPrice: FoundryInfo.reservationList[index]['foundry']['price'] * FoundryInfo.reservationList[index]['numberOfMember'],
                    reservationPhoneNumber: FoundryInfo.reservationList[index]['contactNumber'],
                    reservationDate: FoundryInfo.reservationList[index]['reservationDate'],
                    reservationMemberName: FoundryInfo.reservationList[index]['member']['username'],
                    reservationFoundryName: FoundryInfo.reservationList[index]['foundry']['name'],
                    foundryMinNumber : FoundryInfo.reservationList[index]['foundry']['minMember']
            )
          )
         ),
      )
    );
  }

}
