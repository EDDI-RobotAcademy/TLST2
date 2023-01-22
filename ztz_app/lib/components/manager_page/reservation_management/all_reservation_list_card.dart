
import 'package:flutter/material.dart';

class AllReservationListCard extends StatefulWidget{
  const AllReservationListCard({Key? key,
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
  _AllReservationListCard createState() => _AllReservationListCard();

  final int reservationId, reservationNumberOfMember, totalPaymentPrice, foundryMinNumber;
  final bool paymentState;
  final String reservationPhoneNumber, reservationMemberName, reservationFoundryName, reservationDate;
}

class _AllReservationListCard extends State<AllReservationListCard> {


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

  Widget MyReservationListCardTitle() {
    return Container(
        width: double.infinity,
        // color: Color(0xff205c37),
        padding: const EdgeInsets.all(3),
        margin: const EdgeInsets.only(left: 15, right: 15, top: 20),
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(15),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
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
                  Text("예약코드 ", textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.white)),
                  Text("${widget.reservationId}", textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
            SizedBox(height: 8,),
          ],
        )
    );
  }

  Widget MyReservationListCardContent() {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.only(
            left: 10, right: 10, top: 15, bottom: 15),
        margin: const EdgeInsets.only(left: 15, right: 15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
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
                          Text("예약자 | ", style: TextStyle(fontSize: 15)),
                          Text("${widget.reservationMemberName}",
                            style: TextStyle(fontSize: 14),),
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
                          Text("예약일 | ", style: TextStyle(fontSize: 15)),
                          Text("${widget.reservationDate}",
                            style: TextStyle(fontSize: 14),),
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
                          Text("양조장명 | ", style: TextStyle(fontSize: 14),),
                          Text("${widget.reservationFoundryName}",
                            style: TextStyle(fontSize: 14),),
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
                          Text("예약인원 | ", style: TextStyle(fontSize: 14),),
                          Text("${widget.reservationNumberOfMember}",
                            style: TextStyle(fontSize: 14),),
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
                          Text("연락처 | ", style: TextStyle(fontSize: 14),),
                          Text("${widget.reservationPhoneNumber}",
                            style: TextStyle(fontSize: 14),),
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
                          Text("결제상태 | ", style: TextStyle(fontSize: 14),),
                          if(widget.paymentState == false)
                            Text("N", style: TextStyle(fontSize: 14),)
                          else
                            Text("Y", style: TextStyle(fontSize: 14),),
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
            ]
        )
    );
  }

// final VoidCallback onTap;


}
