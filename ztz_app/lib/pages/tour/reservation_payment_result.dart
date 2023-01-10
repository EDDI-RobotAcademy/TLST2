import 'package:flutter/material.dart';
import 'package:ztz_app/components/layout/menu_app_bar.dart';
import 'package:ztz_app/controller/tour/reservation_controller.dart';
import 'package:ztz_app/pages/home_page.dart';

import '../../controller/account/sign_up_infos/account_state.dart';
import '../../utility/colors.dart';
import '../my_page/my_reservation_page.dart';

class ReservationPaymentResult extends StatefulWidget {
  final Map<String, String> result;
  final int reservationId;
  final int totalPaymentPrice;
  const ReservationPaymentResult({Key? key,
    required this.result,
    required this.reservationId,
    required this.totalPaymentPrice
  }) : super(key: key);

  @override
  _ReservationPaymentResult createState() => _ReservationPaymentResult();

}

class _ReservationPaymentResult extends State<ReservationPaymentResult> {
  late Map<String, String> Result = widget.result;
  late bool isSuccessed;

  @override
  void initState() {
    super.initState();
    isSuccessed = getIsSuccessed(Result);
    debugPrint("결제 결과: ${Result['success']}");
  }

  bool getIsSuccessed(Map<String, String> result) {
    if (result['imp_success'] == 'true') {
      ReservationController().requestSaveReservationPaymentToSpring(
          Result['merchant_uid'],
          widget.reservationId,
          AccountState.memberInfo['id'],
          widget.totalPaymentPrice,
          true);
      return true;
    }
    if (result['success'] == 'true') {
      ReservationController().requestSaveReservationPaymentToSpring(
          Result['merchant_uid'],
          widget.reservationId,
          AccountState.memberInfo['id'],
          widget.totalPaymentPrice,
          true);
      return true;
    }
    return false;
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: MenuAppBar(title: '양조장 결제 결과',),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 50),
              child: Image(image: AssetImage("assets/images/banner/second_banner5.jpg"), )
          ),
          if(isSuccessed)
            Text('결제에 성공하였습니다. 이용해주셔서 감사합니다.', style: TextStyle(fontSize: 15),)
          else
            Text('결제에 실패했습니다. 다시 시도해주세요'),
          Container(
            padding: EdgeInsets.fromLTRB(50.0, 30.0, 50.0, 30.0),
            child: Column(
              children: <Widget>[
                isSuccessed ? Container(
                  padding: EdgeInsets.fromLTRB(0, 5.0, 0, 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 4,
                          child: Text('주문 번호', style: TextStyle(color: Colors.grey))
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(Result['merchant_uid'] ?? '-'),
                      ),
                    ],
                  ),
                ) : Container(
                  padding: EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text('에러 메시지', style: TextStyle(color: Colors.grey)),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(Result['error_msg'] ?? '-'),
                      ),
                    ],
                  ),
                ),
              ],

            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(25),
            margin: const EdgeInsets.only(left: 30, right: 30),
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
            child: Text("양조장 예약은 양조장의 사정으로 인해 취소 될 수 있으며, 양조장에서 개별 연락이 갈 수 있습니다. 본 사이트에서 안내한 금액은 ZTZ와의 협의에 의한 금액으로 선결제 시 해당하는 금액입니다. 방문 결제 시 금액은 변경될 수 있습니다.이 외 관련 문의사항은 해당 양조장으로 문의 부탁드립니다.",
              style: TextStyle(color: Colors.grey.shade700,
                // fontWeight: FontWeight.w700,
              ),),
          ),
        Container(
          margin: const EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 100,
                height: 35,
                child:
                ElevatedButton(
                    style:
                    ElevatedButton.styleFrom(
                        primary: Colors.white,
                        side: BorderSide(width:1, color:ColorStyle.mainColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.all(0)
                    ),
                    onPressed: () async{
                      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      //     builder: (BuildContext context) =>
                      //         MyReservationPage()), (route) => false);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => HomePage()));
                    },
                    child: Text("메인으로", style: TextStyle(fontSize: 12, color: ColorStyle.mainColor),)),
              ),
              SizedBox(width: 5,),
              Container(
                width: 100,
                height: 35,
                child:
                ElevatedButton(
                    style:
                    ElevatedButton.styleFrom(
                        primary: ColorStyle.mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: EdgeInsets.all(0)
                    ),
                    onPressed: () async{
                      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      //     builder: (BuildContext context) =>
                      //         MyReservationPage()), (route) => false);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => MyReservationPage()));
                    },
                    child: Text("예약현황", style: TextStyle(fontSize: 12),)),
              ),
            ],
          ),
        )

        ],
      ),
    );
  }
}