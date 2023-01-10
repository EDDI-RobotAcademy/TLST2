
import 'package:flutter/material.dart';
import 'package:ztz_app/controller/tour/foundry_infos/foundry_info.dart';
import 'package:ztz_app/controller/tour/reservation_controller.dart';
import 'package:ztz_app/utility/colors.dart';

import '../../controller/account/sign_up_infos/account_state.dart';
import '../../pages/home_page.dart';
import '../../pages/my_page/my_reservation_modify_detail_page.dart';
import '../../pages/tour/reservation_payment.dart';

class MyReservationListCard extends StatefulWidget{
  const MyReservationListCard({Key? key,
    required this.reservationId,
    required this.reservationNumberOfMember,
    required this.paymentState,
    required this.totalPaymentPrice,
    required this.reservationPhoneNumber,
    required this.reservationDate,
    required this.reservationMemberName,
    required this.reservationFoundryName,
    required this.foundryMinNumber

  }) : super(key: key);

  @override
  _MyReservationListCard createState() => _MyReservationListCard();

  final int reservationId, reservationNumberOfMember, totalPaymentPrice, foundryMinNumber;
  final bool paymentState;
  final String reservationPhoneNumber, reservationMemberName, reservationFoundryName, reservationDate;
}

class _MyReservationListCard extends State<MyReservationListCard> {


  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: Column(
          children: [
            MyReservationListCardTitle(),
            MyReservationListCardContent()
          ],
        ),
      ),
    );
  }
  Widget MyReservationListCardTitle(){
    return Container(
        width: double.infinity,
        // color: Color(0xff205c37),
        padding: const EdgeInsets.all(3),
        margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(15),
            borderRadius: BorderRadius.only(topLeft:Radius.circular(10), topRight:Radius.circular(10) ),
            boxShadow: [
              BoxShadow(color: Color(0xff205c37)),
            ],
            border: Border.all(
              color: Color(0xff205c37),
              width: 3,

            )
        ),
        child: Column(
          children: [
            SizedBox(height: 8,),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 10, top: 3, bottom: 3),
              child:
              Row(
                children: [
                  Text("예약코드 ", textAlign: TextAlign.start, style: TextStyle(color: Colors.white ) ),
                  Text("${widget.reservationId}", textAlign: TextAlign.start, style: TextStyle(color: Colors.white ) ),
                ],
              ),
            ),
            SizedBox(height: 8,),
          ],
        )
    );
  }

  Widget MyReservationListCardContent(){
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
        margin: const EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft:Radius.circular(10), bottomRight:Radius.circular(10) ),
            border: Border.all(
              color: Colors.grey,
              width: 1,

            )
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(height: 8,),
                        Text("예약자 | ", style: TextStyle( fontSize: 15) ),
                        Text("${widget.reservationMemberName}", style: TextStyle( fontSize: 14), ),
                        SizedBox(height: 5,),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(height: 8,),
                        Text("예약일 | ", style: TextStyle( fontSize: 15) ),
                        Text("${widget.reservationDate}", style: TextStyle( fontSize: 14), ),
                        SizedBox(height: 5,),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            // Icon(icons.)
            Divider(
              thickness: 1,
              color: Colors.grey.withOpacity(0.5),
              // indent: 5,
              // endIndent: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SizedBox(width: 1),
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(height: 8,),
                        Text("양조장명 | ", style: TextStyle( fontSize: 14), ),
                        Text("${widget.reservationFoundryName}", style: TextStyle( fontSize: 14), ),
                        SizedBox(height: 5,),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(height: 8,),
                        Text("예약인원 | ", style: TextStyle( fontSize: 14), ),
                        Text("${widget.reservationNumberOfMember}", style: TextStyle( fontSize: 14), ),
                        SizedBox(height: 5,),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Row(
              children: [
                SizedBox(height: 8,),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // SizedBox(width: 1),
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(height: 8,),
                        Text("연락처 | ", style: TextStyle( fontSize: 14), ),
                        Text("${widget.reservationPhoneNumber}", style: TextStyle( fontSize: 14), ),
                        SizedBox(height: 5,),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(height: 8,),
                        Text("결제상태 | ", style: TextStyle( fontSize: 14), ),
                        if(widget.paymentState == false)
                          Text("N", style: TextStyle( fontSize: 14), )
                        else
                          Text("Y", style: TextStyle( fontSize: 14), ),
                        SizedBox(height: 5,),
                      ],
                    ),
                  ],
                ),

              ],
            ),
            Row(
              children: [
                SizedBox(height: 12,),
              ],
            ),
            //예약 취소, 수정, 결제 버튼
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        if (widget.paymentState == false)
                        Container(
                          height: 30,
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
                                await ReservationController().requestDeleteReservationToSpring(widget.reservationId, AccountState.accountGet.token.string);
                                if (FoundryInfo.reservationResult == 1){
                                  showSuccessCancelReservation();
                                } else{
                                  showFailCancelReservation();
                                }
                              },
                              child: Text("예약취소", style: TextStyle(fontSize: 12, color: ColorStyle.mainColor),)),
                        ),
                        SizedBox(width: 5,),

                        if (widget.paymentState == false)
                        Container(
                          height: 30,
                          child: ElevatedButton(
                              style:
                              ElevatedButton.styleFrom(
                                  primary: ColorStyle.mainColor,
                                  // side: BorderSide(width:1, color:Colors.brown),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: EdgeInsets.all(0)
                              ),
                              onPressed: (){
                                FoundryInfo.reservationInfo = {
                                  'reservationId': widget.reservationId,
                                  'numberOfMember': widget.reservationNumberOfMember,
                                  'reservationDate' : widget.reservationDate,
                                  'username' : widget.reservationMemberName,
                                  'foundryName': widget.reservationFoundryName,
                                  'phoneNumber' : widget.reservationPhoneNumber,
                                  'foundryMinMember': widget.foundryMinNumber
                                };
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MyReservationModifyDetailPage()));
                              },
                              child: Text("예약수정", style: TextStyle(fontSize: 12),)),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: [
                    if (widget.paymentState == false)
                    Container(
                      height: 30,
                      child: ElevatedButton(
                          style:
                          ElevatedButton.styleFrom(
                              primary: Colors.white,
                              side: BorderSide(width:1, color:ColorStyle.mainColor),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              padding: EdgeInsets.all(0)
                          ),
                          onPressed: (){
                            debugPrint("선결제 누름 가격: ${widget.totalPaymentPrice}");
                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)
                            => ReservationPayment(
                                reservationId: widget.reservationId,
                                reservationNumberOfMember: widget.reservationNumberOfMember,
                                reservationDate : widget.reservationDate,
                                reservationMemberName : widget.reservationMemberName,
                                reservationFoundryName: widget.reservationFoundryName,
                                reservationPhoneNumber : widget.reservationPhoneNumber,
                                paymentState: widget.paymentState ,
                                totalPaymentPrice: widget.totalPaymentPrice,

                            )));
                          },
                          child: Text("선결제", style: TextStyle(fontSize: 12, color: ColorStyle.mainColor),)),
                    ),
                  ],
                ),
              ],
            ),
          ],
        )
    );
  }

  void showSuccessCancelReservation(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("예약이 취소되었습니다."),
          content: new Text("감사합니다."),
          actions: <Widget>[
            FlatButton(
              child: const Text("Close"),
              onPressed: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (BuildContext context) =>
                        HomePage()), (route) => false);
              },
            ),
          ],
        );
      },
    );
  }

  void showFailCancelReservation(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("예약취소에 실패하였습니다."),
          content: new Text("다시 시도해주세요."),
          actions: <Widget>[
            FlatButton(
              child: const Text("Close"),
              onPressed: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    builder: (BuildContext context) =>
                        HomePage()), (route) => false);
              },
            ),
          ],
        );
      },
    );
  }

}


  // final VoidCallback onTap;




