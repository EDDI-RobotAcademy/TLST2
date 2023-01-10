import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ztz_app/controller/tour/foundry_infos/foundry_info.dart';

class ReservationController extends GetxController{
  static const httpUri = '192.168.200.197:7777';

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

 
}