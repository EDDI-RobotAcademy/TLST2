import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ztz_app/controller/order/order_infos/order_info.dart';

class OrderController{
  static const httpUri = '192.168.0.8:7777';

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
        var tmpPaymentList = [];
        debugPrint("paymentList 결과: " + utf8.decode(paymentResponse.bodyBytes).toString());
        tmpPaymentList = jsonDecode(utf8.decode(paymentResponse.bodyBytes));
        OrderInfo.paymentList.clear();
        OrderInfo.paymentList = tmpPaymentList.obs;
      } else {
        debugPrint("payment 통신 오류" + paymentResponse.statusCode.toString());
      }
    } catch(e) {
      debugPrint("오류 발생" + e.toString());
    }
  }

  requestPaymentListByDataFromSpring(token , readData) async {
    var data = {'token' : token , 'readData' : readData};
    var body = json.encode(data);
    try{
      var paymentResponse = await http.post(
        Uri.http(httpUri, 'ztz/order/readPayment/byDate'),
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if(paymentResponse.statusCode == 200) {
        var tmpPaymentList = [];
        debugPrint("paymentList 결과: " + utf8.decode(paymentResponse.bodyBytes).toString());
        tmpPaymentList = jsonDecode(utf8.decode(paymentResponse.bodyBytes));
        OrderInfo.paymentList.clear();
        OrderInfo.paymentList = tmpPaymentList.obs;
      } else {
        debugPrint("기간 payment 통신 오류" + paymentResponse.statusCode.toString());
      }
    }catch(e){
      debugPrint("오류 발생" + e.toString());
    }
  }
}