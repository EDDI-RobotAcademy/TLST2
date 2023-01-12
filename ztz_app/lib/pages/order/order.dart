import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ztz_app/components/order/select_box.dart';


import '../../components/order/order_amount_widget.dart';
import '../../components/order/order_list_builder.dart';
import '../../components/order/order_my_info_widget.dart';
import '../../controller/account/sign_up_infos/account_state.dart';
import '../../utility/text_styles.dart';

class OrderPage extends StatelessWidget {

  var getOrderData = Get.arguments[0];
  var getPriceData = Get.arguments[1];
  
  @override
  Widget build(BuildContext context) {
    print("야호" + getPriceData.toString());
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black87),
          centerTitle: true,
          title: const Text(
              '주문서',
              style: TextStyle(color: Colors.black87)
          ),
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(13, 10, 15, 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  OrderItemsList(receivedData: getOrderData),
                  OrderMyInfo(),   // 내정보
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                        Text("결제 방법", style: productInCartPriceTextStyle()),
                        TextButton(
                            child: Text("이니시스", style: smallOrderGreenTextStyle()),
                            onPressed: (){},
                        )
                      ]
                    ),
                  ),  //결제방법
                  OrderAmount(receivedData: getPriceData),  //금액정보

                  SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 54,
                    child: ElevatedButton(
                      child: Text( "주문하기",
                              style: buttonTextStyle()),
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(Color(0xff276039)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              )
                          )
                      ),
                    ),
                  )   // 버튼
                ],
              ),
            )
        )
    );
  }


}
