import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ztz_app/components/order/select_box.dart';
import 'package:ztz_app/controller/order/order_controller.dart';
import '../../controller/account/member_api.dart';
import '../../controller/account/sign_up_infos/account_state.dart';
import '../../pages/my_page/modify_address_page.dart';
import '../../utility/text_styles.dart';
class OrderMyInfo extends StatefulWidget {
  const OrderMyInfo({Key? key}) : super(key: key);

  @override
  State<OrderMyInfo> createState() => _OrderMyInfoState();
}

class _OrderMyInfoState extends State<OrderMyInfo> {
  String city = "";
  String street = "";
  String addressDetail = "";
  String zipcode = "";

  @override
  void initState() {
    getMemberProfile();
    super.initState();
  }

  void getMemberProfile() async {
    await MemberApi().requestMemberProfileFromSpring(AccountState.accountGet.token.value);
    setState(() {
      city = AccountState.memberProfile['address']['city'];
      street = AccountState.memberProfile['address']['street'];
      addressDetail = AccountState.memberProfile['address']['addressDetail'];
      zipcode = AccountState.memberProfile['address']['zipcode'];
      OrderController.city = AccountState.memberProfile['address']['city'];
      OrderController.street = AccountState.memberProfile['address']['street'];
      OrderController.addressDetail = AccountState.memberProfile['address']['addressDetail'];
      OrderController.zipcode = AccountState.memberProfile['address']['zipcode'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(vertical: 8),
                padding: const EdgeInsets.symmetric(vertical:22, horizontal: 20),
                decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                      color: const Color(0xffd5e3d8),
                      width: 1,
                      ),
                ),
                child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                          Text(
                              "주문자 정보",
                              style: productInCartPriceTextStyle()
                          ),
                          Text("${AccountState.memberInfo['username']}, "
                              "${AccountState.memberProfile['phoneNumber']}",
                              style: smallOrderTextStyle()
                          ),
                      ]
                ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.symmetric(vertical:8, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xffd5e3d8),
                width: 1,
              ),
            ),
            child:Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("배송지 정보", style: productInCartPriceTextStyle()),
                    TextButton(
                      child: Text("배송지 변경", style: smallOrderGreenTextStyle()),
                      onPressed: (){
                        Get.to(()=> ModifyAddressPage());
                      },
                    )
                  ],
                ),
                Text('$city $street $addressDetail $zipcode', textAlign: TextAlign.left),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  color: Colors.black12,
                  margin: EdgeInsets.fromLTRB(0, 16, 0, 20),
                ),
                MessageSelectBox()
              ],
            )
        )
      ],
    );
  }
}
