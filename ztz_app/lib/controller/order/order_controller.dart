import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ztz_app/controller/order/order_infos/order_info.dart';

class OrderController{
  static const httpUri = '192.168.200.168:7777';
  static var deliveryMessageList = [
    "문 앞에 두고 가주세요",
    "조심히 안전하게 와주세요",
    "배송 후에 문자 부탁드립니다 ",
    "부재 시 경비실에 놔주세요",
  ];
  static var deliveryMessage = '';
  static RxString city = "".obs;
  static RxString street = "".obs;
  static RxString addressDetail = "".obs;
  static RxString zipcode = "".obs;
  static get address => '${city.value} ${street.value} ${addressDetail.value} ${zipcode.value}';

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

  requestModifyOrderState(reqType, orderId , paymentId) async {
    var data = {'reqType' : reqType , 'orderId' : orderId , 'paymentId' : paymentId};
    var body = json.encode(data);

    try{
      var orderInfoResponse = await http.post(
        Uri.http(httpUri, 'ztz/order/changeOrderState'),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if(orderInfoResponse.statusCode == 200){
        var tmpOrderList = [];
        debugPrint("ModifyOrderState 결과 =" + utf8.decode(orderInfoResponse.bodyBytes).toString());
        tmpOrderList = jsonDecode(utf8.decode(orderInfoResponse.bodyBytes));
        OrderInfo.orderInfoList.clear();
        OrderInfo.orderInfoList = tmpOrderList.obs;
      }else{
        debugPrint("오류 발생" + orderInfoResponse.statusCode.toString());
      }
    }catch(e){
      debugPrint("오류 발생" + e.toString());
    }
  }

  requestRefundOrder(refundPaymentId , refundReason) async {
    var data = {'refundPaymentId' : refundPaymentId , 'refundReason' : refundReason};
    var body = json.encode(data);

    try{
      var orderRefundResponse = await http.post(
        Uri.http(httpUri, 'ztz/order/refundAllOrder/$refundPaymentId'),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if(orderRefundResponse.statusCode == 200){
        debugPrint("결과 = " + utf8.decode(orderRefundResponse.bodyBytes));

        if(jsonDecode(orderRefundResponse.body) == true){
          debugPrint("실행?");
          OrderInfo.refundResult = true.obs;
          debugPrint("실행? =" + OrderInfo.refundResult.toString());
        }else{
          debugPrint("실행?2");
          OrderInfo.refundResult = false.obs;
          debugPrint("실행?2 =" + OrderInfo.refundResult.toString());
        }
      }else{
        debugPrint("오류 발생" + orderRefundResponse.statusCode.toString());
      }
    }catch(e){
      debugPrint("오류 발생" + e.toString());
    }
  }

  requestWritableOrderList(token) async {
    var data = {'token' : token};
    var body = json.encode(data);

    try{
      var writableOrderListResponse = await http.post(
        Uri.http(httpUri, 'ztz/order/writableReview'),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if(writableOrderListResponse.statusCode == 200){
        var tmpWritableOrderList = [];
        debugPrint("writableOrderListResponse 결과 =" + utf8.decode(writableOrderListResponse.bodyBytes).toString());
        tmpWritableOrderList = jsonDecode(utf8.decode(writableOrderListResponse.bodyBytes));
        OrderInfo.writableOrderInfoList.clear();
        OrderInfo.writableOrderInfoList = tmpWritableOrderList.obs;
      }else{
        debugPrint("통신 오류 발생" + writableOrderListResponse.statusCode.toString());
      }
    }catch(e){
      debugPrint("오류 발생" + e.toString());
    }
  }

  requestSalesAmount() async {
    try{
      var orderInfoResponse = await http.get(
        Uri.http(httpUri, 'ztz/order/salesAmount'),
        headers: {"Content-Type": "application/json"},
      );

      if(orderInfoResponse.statusCode == 200){

        debugPrint("orderInfoResponse 결과: " + utf8.decode(orderInfoResponse.bodyBytes).toString());
        OrderInfo.salesAmount = jsonDecode(utf8.decode(orderInfoResponse.bodyBytes));
        // OrderInfo.salesAmount.clear();
        // OrderInfo.salesAmount = tmpOrderList.obs;
      }else {
        debugPrint("orderInfo 통신 오류" + orderInfoResponse.statusCode.toString());
      }
    }catch(e){
      debugPrint("오류 발생" + e.toString());
    }
  }

}