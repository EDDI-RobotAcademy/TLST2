import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ztz_app/controller/tour/foundry_infos/foundry_info.dart';

class ReservationController extends GetxController{
  static const httpUri = '192.168.200.168:7777';

  requestAllFoundryToSpring() async{
    try{
      var requestFoundryListResponse = await http.get(
        Uri.http(httpUri,'ztz/tour/list'),
        headers: {"Content-Type": "application/json"},
      );

      debugPrint(requestFoundryListResponse.statusCode.toString());
      if(requestFoundryListResponse.statusCode == 200){
        debugPrint("양조장 리스트 결과 : " + utf8.decode(requestFoundryListResponse.bodyBytes).toString());
        FoundryInfo.foundryList = jsonDecode(utf8.decode(requestFoundryListResponse.bodyBytes));
      }
    }catch(e){
      debugPrint("오류 발생 " + e.toString());
    }
  }

  requestSaveReservationToSpring(username, numberOfMember, reservationDate, phoneNumber, token, foundryName) async{
    var data = {'username' : username, 'numberOfMember' : numberOfMember, 'reservationDate' : reservationDate,
                 'contactNumber' : phoneNumber, 'token' : token, 'foundryName' : foundryName};
    var body = json.encode(data);
    try{
      var requestReserveaionResponse = await http.post(
        Uri.http(httpUri,'ztz/tour/reservation'),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      debugPrint(requestReserveaionResponse.statusCode.toString());
      if(requestReserveaionResponse.statusCode == 200){
        debugPrint("양조장 리스트 결과 : " + utf8.decode(requestReserveaionResponse.bodyBytes).toString());
        FoundryInfo.reservationResult = jsonDecode(utf8.decode(requestReserveaionResponse.bodyBytes));
      }
    }catch(e){
      debugPrint("오류 발생 " + e.toString());
    }
  }

  //스프링 getMapping- headers: token 방식
  requestMyReservationToSpring(Token) async{
    var token = json.encode(Token);
    Map<String, String> Headers = {"Content-Type": "application/json", "token": token};

    debugPrint("나의 양조장 조회: 토큰 "+token);

    try{
      var requestMyReservationListResponse = await http.get(
        Uri.http(httpUri,'ztz/tour/my-reservation'),
        headers: Headers,
      );

      debugPrint(requestMyReservationListResponse.statusCode.toString());
      if(requestMyReservationListResponse.statusCode == 200){
        debugPrint("나의 예약 리스트 결과 : " + utf8.decode(requestMyReservationListResponse.bodyBytes).toString());
        FoundryInfo.reservationList = jsonDecode(utf8.decode(requestMyReservationListResponse.bodyBytes));
      }
    }catch(e){
      debugPrint("오류 발생 " + e.toString());
    }
  }

  //스프링 getMapping- headers: token 방식
  requestModifyReservationToSpring(reservationId, username, numberOfMember, reservationDate, phoneNumber, token, foundryName) async{
    var data = {'username' : username, 'numberOfMember' : numberOfMember, 'reservationDate' : reservationDate,
      'contactNumber' : phoneNumber, 'token' : token, 'foundryName' : foundryName};
    var body = json.encode(data);

    debugPrint("나의 양조장 수정: 예약 아이디 "+reservationId.toString());
    debugPrint("나의 양조장 수정: 예약 명수 "+numberOfMember.toString());
    debugPrint("나의 양조장 수정: 예약 날짜 "+reservationDate);
    debugPrint("나의 양조장 수정: 예약 전화번호 "+phoneNumber);
    debugPrint("나의 양조장 수정: 예약자 "+username);


    try{
      var requestModfyReservationResponse = await http.put(
        Uri.http(httpUri,'ztz/tour/my-reservation/$reservationId'),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      debugPrint(requestModfyReservationResponse.statusCode.toString());
      if(requestModfyReservationResponse.statusCode == 200){
        debugPrint("나의 예약 수정 결과 : " + utf8.decode(requestModfyReservationResponse.bodyBytes).toString());
        FoundryInfo.reservationResult = jsonDecode(utf8.decode(requestModfyReservationResponse.bodyBytes));
      }
    }catch(e){
      debugPrint("오류 발생 " + e.toString());
    }
  }

  //스프링 getMapping- headers: token 방식
  requestDeleteReservationToSpring(reservationId, Token) async{
    var token = json.encode(Token);
    Map<String, String> Headers = {"Content-Type": "application/json", "token": token};

    debugPrint("나의 양조장 조회: 토큰 "+token);

    try{
      var requestDeleteMyReservationResponse = await http.delete(
        Uri.http(httpUri,'ztz/tour/my-reservation/$reservationId'),
        headers: Headers,
      );

      debugPrint(requestDeleteMyReservationResponse.statusCode.toString());
      if(requestDeleteMyReservationResponse.statusCode == 200){
        debugPrint("나의 예약 리스트 결과 : " + utf8.decode(requestDeleteMyReservationResponse.bodyBytes).toString());
        FoundryInfo.reservationResult = jsonDecode(utf8.decode(requestDeleteMyReservationResponse.bodyBytes));
      }
    }catch(e){
      debugPrint("오류 발생 " + e.toString());
    }
  }

  requestSaveReservationPaymentToSpring(merchant_uid, reservationId, memberId, totalPaymentPrice, paymentState) async{
    var data = {'merchant_uid' : merchant_uid, 'reservationId' : reservationId, 'memberId' : memberId,
      'totalPaymentPrice' : totalPaymentPrice, 'paymentState' : paymentState};
    var body = json.encode(data);
    try{
      var requestReserveaionPaymentResponse = await http.post(
        Uri.http(httpUri,'ztz/tour/my-reservation/payment'),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      debugPrint(requestReserveaionPaymentResponse.statusCode.toString());
      if(requestReserveaionPaymentResponse.statusCode == 200){
        debugPrint("양조장 리스트 결과 : " + utf8.decode(requestReserveaionPaymentResponse.bodyBytes).toString());
        FoundryInfo.reservationPaymentResult = jsonDecode(utf8.decode(requestReserveaionPaymentResponse.bodyBytes));
      }
    }catch(e){
      debugPrint("오류 발생 " + e.toString());
    }
  }
  requestAllReservationToSpring() async{
    try{
      var requestFoundryListResponse = await http.get(
        Uri.http(httpUri,'ztz/tour/allReservationList'),
        headers: {"Content-Type": "application/json"},
      );

      debugPrint(requestFoundryListResponse.statusCode.toString());
      if(requestFoundryListResponse.statusCode == 200){
        debugPrint("양조장 리스트 결과 : " + utf8.decode(requestFoundryListResponse.bodyBytes).toString());
        FoundryInfo.reservationList = jsonDecode(utf8.decode(requestFoundryListResponse.bodyBytes));
      }
    }catch(e){
      debugPrint("오류 발생 " + e.toString());
    }
  }
}