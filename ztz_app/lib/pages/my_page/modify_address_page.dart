import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remedi_kopo/remedi_kopo.dart';
import 'package:ztz_app/components/layout/white_menu_app_bar.dart';
import 'package:ztz_app/controller/account/member_api.dart';
import 'package:ztz_app/controller/account/member_modify_infos/modify_address_info.dart';
import 'package:ztz_app/controller/account/sign_up_infos/account_state.dart';
import 'package:ztz_app/utility/button_style.dart';
import 'package:ztz_app/utility/colors.dart';
import 'package:ztz_app/utility/text_styles.dart';

import '../../controller/order/order_controller.dart';

class ModifyAddressPage extends StatefulWidget {
  const ModifyAddressPage({Key? key}) : super(key: key);


  @override
  State<ModifyAddressPage> createState() => _ModifyAddressPageState();
}

class _ModifyAddressPageState extends State<ModifyAddressPage> {

  TextEditingController zipcodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController addressDetailController = TextEditingController();

  String token = AccountState.accountGet.token.value;
  String city = "";
  String street = "";
  String addressDetail = "";
  String zipcode = "";

  @override
  void initState() {
    getMemberProfile();
    super.initState();
  }

  @override
  void dispose() {
    zipcodeController.dispose();
    addressController.dispose();
    addressDetailController.dispose();
    super.dispose();
  }

  void getMemberProfile() async {
    await MemberApi().requestMemberProfileFromSpring(token);
    setState(() {
      city = AccountState.memberProfile['address']['city'];
      street = AccountState.memberProfile['address']['street'];
      addressDetail = AccountState.memberProfile['address']['addressDetail'];
      zipcode = AccountState.memberProfile['address']['zipcode'];
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: WhiteMenuAppBar(title: "배송지 관리"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                width: 80,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text('기본 배송지', textAlign: TextAlign.center),
              ),
            ],
          ),
          SizedBox(height: 20,),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(child: Text("우편 번호"), height: 25),
                Row(
                  children: [
                    TextFormField(
                      readOnly: true,
                      controller: zipcodeController..text = zipcode,
                      onChanged: (text) => {},
                      decoration: InputDecoration(
                        constraints: BoxConstraints.tightFor(width: size.width/1.8),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: ColorStyle.mainColor)
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: OutlinedButton(
                        style: ButtonStyle(
                          fixedSize: MaterialStateProperty.all(Size(size.width/3.2, 55)),
                        ),
                        child: Text("배송지 수정", style: greenTextStyle(14),),
                        onPressed: () {
                          HapticFeedback.mediumImpact();
                          _addressApi();
                        },
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(child: Text("주소"), height: 25,),
                TextFormField(
                  readOnly: true,
                  controller: addressController..text = street,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: ColorStyle.mainColor)
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(child: Text("상세 주소"), height: 25,),
                TextFormField(
                  controller: addressDetailController..text = addressDetail,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorStyle.mainColor)
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 25,),
          Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            child: ElevatedButton(
                style:defaultElevatedButtonStyle(380,55),
                onPressed: (){
                  modifyAddressFunction();
                  _conveyModifyAddress();
                },
                child: Text("저장", style: whiteBoldTextStyle(16),
                ),
            ),
          )
        ],
      ),
    );
  }

  _addressApi() async {
    KopoModel model = await Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => RemediKopo ()
        )
    );
    addressController.text = '${model.address!} ${model.buildingName!}';
    zipcodeController.text = '${model.zonecode!}';
    city = model.sido!;
    street = model.address! + ' ' +  model.buildingName!;
    zipcode = model.zonecode!;
  }
  _conveyModifyAddress() {
    OrderController.city.value = city;
    OrderController.street.value = street;
    OrderController.addressDetail.value = addressDetailController.text;
    OrderController.zipcode.value = zipcode;
  }
  // 배송지 수정 함수
  modifyAddressFunction() async {
    ModifyAddressInfo modifyAddressInfo = ModifyAddressInfo(
        city, street, addressDetailController.text, zipcode, token);
    await MemberApi().requestModifyAddressToSpring(modifyAddressInfo);
    if(ModifyAddressInfo.modifyAddressResult) {
      showSuccessModifyAddress();
    } else {
      showFailModifyAddress();
    }
  }

  void showSuccessModifyAddress(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: Text("배송지를 수정하였습니다."),
          actions: [
            FlatButton(
              child: Text("확인"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void showFailModifyAddress(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("배송지 수정을 실패했습니다."),
          actions: [
            FlatButton(
              child: Text("확인"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
