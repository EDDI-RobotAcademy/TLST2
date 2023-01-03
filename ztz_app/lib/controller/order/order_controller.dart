import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ztz_app/controller/order/order_infos/order_info.dart';

class OrderController{
  static const httpUri = '172.30.1.54:7777';

  requestPaymentListFromSpring(token) async {
    var data = {'token' : token};
    var body = json.encode(data);
    try {
      var paymentResponse = await http.post(
        Uri.http(httpUri, 'ztz/order/ReadAllPayment'),
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if(paymentResponse.statusCode == 200) {
        debugPrint("paymentList 결과: " + utf8.decode(paymentResponse.bodyBytes).toString());
        OrderInfo.paymentList = jsonDecode(utf8.decode(paymentResponse.bodyBytes));
      } else {
        debugPrint("payment 통신 오류" + paymentResponse.statusCode.toString());
      }
    } catch(e) {
      debugPrint("오류 발생" + e.toString());
    }
  }
}