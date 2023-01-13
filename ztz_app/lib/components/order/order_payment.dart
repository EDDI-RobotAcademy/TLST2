import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
/* 아임포트 결제 모듈을 불러옵니다. */
import 'package:iamport_flutter/iamport_payment.dart';
/* 아임포트 결제 데이터 모델을 불러옵니다. */
import 'package:iamport_flutter/model/payment_data.dart';
import 'package:ztz_app/components/layout/menu_app_bar.dart';
import 'package:ztz_app/components/order/order_payment_result.dart';
import 'package:ztz_app/controller/account/sign_up_infos/account_state.dart';
import 'package:ztz_app/controller/order/order_controller.dart';


class OrderPayment extends StatefulWidget {
  OrderPayment({Key? key,}) : super(key: key);

  @override
  _OrderPayment createState() => _OrderPayment();
}

class _OrderPayment extends State<OrderPayment> {
  var rng = Random().nextInt(100000);
  String uid_num = '0o00321';
  var merchant_uid ='ORD2022-';
  var orderItems = Get.arguments;
  var address = '${OrderController.city} '
      '${OrderController.street} '
      '${OrderController.addressDetail} '
      '${OrderController.zipcode} ';

  @override
  Widget build(BuildContext context) {
    return IamportPayment(
      appBar: MenuAppBar(title: "ZTZ 상품 결제",),
      /* 웹뷰 로딩 컴포넌트 */
      initialChild: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo/logo.png'),
              Padding(padding: EdgeInsets.symmetric(vertical: 15)),
              Text('Loading...', style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
      /* [필수입력] 가맹점 식별코드 */
      userCode: 'imp51435132',
      /* [필수입력] 결제 데이터 */
      data: PaymentData(
          pg: 'html5_inicis',                                          // PG사
          payMethod: 'card',                                           // 결제수단
          name: 'INIpayTest',                                  // 주문명
          merchantUid: merchant_uid + '$rng', // 주문번호
          amount: 100 /*widget.totalPaymentPrice*/,                                               // 결제금액
          buyerEmail: AccountState.memberInfo['email'],
          buyerName: AccountState.memberInfo['username'],
          buyerTel: AccountState.memberProfile['phoneNumber'],
          buyerAddr: address ,
          buyerPostcode: AccountState.memberProfile['address']['zipcode'],                          // 구매자 우편번호
          appScheme: 'example',                                        // 앱 URL scheme
          cardQuota : [2,3],                                          //결제창 UI 내 할부개월수 제한
      ),
      /* [필수입력] 콜백 함수 */
      callback: (Map<String, String> result) {
        Get.to(() => OrderPaymentResult(), arguments: [result, orderItems]);
        // Navigator.pushReplacement(
        //   context, MaterialPageRoute(
        //     builder: (context) => OrderPaymentResult(orderItems: orderItems, result: result,)),
        // );
        debugPrint("결제완료 전: $result['success']");
      },
    );
  }
}


