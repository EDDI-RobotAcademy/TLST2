import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ztz_app/controller/order/order_infos/order_info.dart';

class OrderController{
  static const httpUri = '192.168.200.175:7777';
  static var deliveryMessage = [
    "문 앞에 두고 가주세요",
    "조심히 안전하게 와주세요",
    "배송 후에 문자 부탁드립니다 ",
    "부재 시 경비실에 놔주세요",
  ];

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
  requestOrderInfoByPaymentId(paymentId) async {
    try{
      var orderInfoResponse = await http.post(
        Uri.http(httpUri, 'ztz/order/ReadAllOrder/$paymentId'),
        headers: {"Content-Type": "application/json"},
      );

      if(orderInfoResponse.statusCode == 200){
        var tmpOrderList = [];
        debugPrint("orderInfoResponse 결과: " + utf8.decode(orderInfoResponse.bodyBytes).toString());
        tmpOrderList = jsonDecode(utf8.decode(orderInfoResponse.bodyBytes));
        OrderInfo.orderInfoList.clear();
        OrderInfo.orderInfoList = tmpOrderList.obs;
      }else {
        debugPrint("orderInfo 통신 오류" + orderInfoResponse.statusCode.toString());
      }
    }catch(e){
      debugPrint("오류 발생" + e.toString());
    }
  }


}