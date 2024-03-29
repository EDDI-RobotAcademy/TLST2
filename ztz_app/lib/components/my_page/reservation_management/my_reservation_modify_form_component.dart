
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ztz_app/pages/my_page/reservation_management/my_reservation_page.dart';

import '../../../controller/account/member_api.dart';
import '../../../controller/account/sign_up_infos/account_state.dart';
import '../../../controller/tour/foundry_infos/foundry_info.dart';
import '../../../controller/tour/reservation_controller.dart';
import '../../../utility/colors.dart';


class MyReservationModifyFormComponent extends StatefulWidget {
  const MyReservationModifyFormComponent({Key? key}) : super(key: key);

  @override
  _MyReservationModifyFormComponent createState() => _MyReservationModifyFormComponent();
}

class _MyReservationModifyFormComponent extends State<MyReservationModifyFormComponent> {
  TextEditingController dateinput = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();

  var loginInfoCheck = false;
  late var name= "";
  int minMember = FoundryInfo.reservationInfo['foundryMinMember'];
  late int selectedAmount = FoundryInfo.reservationInfo['numberOfMember'];
  String foundryName = FoundryInfo.reservationInfo['foundryName'];
  late int reservationResult = 0;

  @override
  void initState() {
    setMemberCheck();
    dateinput.text = "";
    super.initState();

  }

  void setMemberCheck() async {
    await AccountState.accountGet.isLoginCheck();
    debugPrint("로그인 체크" + AccountState.accountGet.isLogin.value.toString());
    if (AccountState.accountGet.isLogin.value) {
      await MemberApi().userVerification(AccountState.accountGet.token.value);
      setState(() {
        loginInfoCheck = true;
        name = AccountState.memberInfo['username'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: loginInfoCheck == false? isNullMemberInfo():isMemberPresentReservationInfo()
    );
  }

  Widget _buildFoundryList(){
    return Container(
      child: Text('양조장'),
    );
  }


  Widget isNullMemberInfo(){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      child: Text("예약 서비스는 로그인 후 사용가능합니다 🙏 🙏"),
      decoration: BoxDecoration(
      ),
    );
  }

  Widget isMemberPresentReservationInfo(){
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 40),
                Text("양조장    ", style: TextStyle(fontSize:15, fontWeight: FontWeight.w800), ),
                SizedBox(width: 15),
                Container(
                  width: 200,
                  height:40,
                  child:
                  TextField(
                    style: TextStyle(fontSize: 14.0, height: 0.5, color: Colors.black),
                    decoration: InputDecoration(
                      enabled: false,
                      labelText: FoundryInfo.reservationInfo['foundryName'],
                      border: OutlineInputBorder(),
                    ),),
                ),
              ],
            ),
            Container(
              height: 20,
            ),
            Row(
            children: [
              SizedBox(width: 40),
              Text("예약자    ", style: TextStyle(fontSize:15, fontWeight: FontWeight.w800), ),
              SizedBox(width: 15),
              Container(
                width: 200,
                height:40,
                child:
                TextField(
                  style: TextStyle(fontSize: 14.0, height: 0.5, color: Colors.black),
                  decoration: InputDecoration(
                    enabled: false,
                    labelText: '$name',
                    border: OutlineInputBorder(),
                  ),),
              ),
            ],
          ),
            Container(
            height: 20,
            ),
            Row(
                children: [
                  SizedBox(width: 40),
                  Text("연락처    ", style: TextStyle(fontSize:15, fontWeight: FontWeight.w800), ),
                  SizedBox(width: 15),
                  Container(
                    width: 200,
                    height:40,
                    child:
                    TextFormField(
                      controller: phoneNumber,
                      style: TextStyle(fontSize: 14.0, height: 0.5, color: Colors.black),
                      decoration: InputDecoration(
                        labelText: FoundryInfo.reservationInfo['phoneNumber'],
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
            ),
            Container(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(width: 40),
                Text("예약일    ", style: TextStyle(fontSize:15, fontWeight: FontWeight.w800), ),
                SizedBox(width: 15),
                Container(
                  width: 200,
                  height:40,
                  child:
                  TextField(
                    controller: dateinput,
                    style: TextStyle(fontSize: 14.0, height: 0.5, color: Colors.black),
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: FoundryInfo.reservationInfo['reservationDate'],
                      border: OutlineInputBorder(),
                    ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                        );
                        if(pickedDate != null ){
                          print(pickedDate);
                          String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                          print(formattedDate);
                          setState(() {
                            dateinput.text = formattedDate;
                          });
                        }else{
                          print("Date is not selected");
                        }
                      }
                  ),
                ),
              ],
            ),
            // Text("$name")
            Container(
              height: 20,
            ),
            Row(
              children: [
                SizedBox(width: 40),
                Text("예약인원", style: TextStyle(fontSize:15, fontWeight: FontWeight.w800), ),
                SizedBox(width: 15),
                Container(
                  width: 100,
                  height:40,
                  child:
                  amountOfMember(),
                ),
              ],
            ),
            Container(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 20),
                Container(
                  width: 300,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xff205C37),
                      ),
                      onPressed:() async{
                        if(phoneNumber.text.isEmpty){
                          phoneNumber.text = FoundryInfo.reservationInfo['phoneNumber'];
                        }
                        if(dateinput.text.isEmpty){
                          dateinput.text = FoundryInfo.reservationInfo['reservationDate'];
                        }
                        await ReservationController().requestModifyReservationToSpring(
                            FoundryInfo.reservationInfo['reservationId'],
                            name,
                            selectedAmount,
                            dateinput.text,
                            phoneNumber.text,
                            AccountState.accountGet.token.value,
                            foundryName);

                        reservationResult= FoundryInfo.reservationResult;

                        if(reservationResult == 1){
                          showSuccessModifyReservation();
                        } else{
                          showFailModifyReservation();
                        }
                        },

                      child: const Text("예약수정")),
                ),

                SizedBox(width: 15),
              ],
            ),
          ]

      ),
    );
  }

  Widget amountOfMember(){
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black54),
          borderRadius: BorderRadius.circular(4)
      ),
      child: Row(
        children: [
          InkWell(
            child: selectedAmount == minMember ? Icon(Icons.remove,color: ColorStyle.textGray,):Icon(Icons.remove),
            onTap: (){
              if(selectedAmount!= minMember){
                setState((){
                  selectedAmount--;
                });
              }
            },
          ),
          SizedBox(
            width: 30,
            child: Text(selectedAmount.toString(),textAlign: TextAlign.center,),
          ),
          InkWell(
              child: Icon(Icons.add),
              onTap: (){
                setState((){
                  selectedAmount++;
                });
              }
          ),
        ],
      ),
    );
  }

  void showSuccessModifyReservation(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("예약이 수정이 완료되었습니다."),
          content: new Text("감사합니다."),
          actions: <Widget>[
            FlatButton(
              child: const Text("Close"),
              onPressed: (){
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyReservationPage()),
                ).then((value) => setState(() {}));
              },
            ),
          ],
        );
      },
    );
  }

  void showFailModifyReservation(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("예약 수정에 실패하였습니다."),
          content: new Text("다시 시도해주세요."),
          actions: <Widget>[
            FlatButton(
              child: const Text("Close"),
              onPressed: (){
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyReservationPage()),
                ).then((value) => setState(() {}));
              },
            ),
          ],
        );
      },
    );
  }
}
