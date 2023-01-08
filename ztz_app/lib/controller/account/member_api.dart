import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;
import 'package:ztz_app/controller/account/member_modify_infos/modify_address_info.dart';
import 'package:ztz_app/controller/account/sign_up_infos/account_state.dart';

class MemberApi{
  static const httpUri = '172.30.1.54:7777';

  userVerification(token) async{
    var data = {'token': token};
    var body = json.encode(data);

    debugPrint(body);
    try{

      var memberInfoResponse = await http.post(
        Uri.http(httpUri,'/ztz/member/user-verification'),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if(memberInfoResponse.statusCode == 200){
        var result = {};
        result = jsonDecode(utf8.decode(memberInfoResponse.bodyBytes));
        AccountState.memberInfo = result.obs;
        debugPrint("맴버 정보" + AccountState.memberInfo.toString());

      }else{
        debugPrint("통신 오류" + memberInfoResponse.statusCode.toString());
      }
    }catch(e){
      debugPrint("오류 발생 " + e.toString());
    }
  }

  requestMemberProfileFromSpring(token) async {
    var data = {'token': token};
    var body = json.encode(data);
    try {
      var memberProfileResponse = await http.post(
        Uri.http(httpUri, '/ztz/member/user-profile'),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if (memberProfileResponse.statusCode == 200) {
        var result = {};
        result = jsonDecode(utf8.decode(memberProfileResponse.bodyBytes));
        AccountState.memberProfile = result.obs;
        debugPrint("memberProfile: " + AccountState.memberProfile.toString());
      } else {
        debugPrint("memberProfile 통신 오류" + memberProfileResponse.statusCode.toString());
      }
    } catch(e) {
      debugPrint("memberProfile 오류 발생 " + e.toString());
    }
  }

  requestModifyAddressToSpring(ModifyAddressInfo modifyAddressInfo) async {
    var data = {
      'city' : modifyAddressInfo.city,
      'street' : modifyAddressInfo.street,
      'addressDetail' : modifyAddressInfo.addressDetail,
      'zipcode' : modifyAddressInfo.zipcode,
      'token' : modifyAddressInfo.token
    };
    var body = json.encode(data);
    debugPrint("주소 수정 보내기" + body);
    try {
      var modifyAddressResponse = await http.post(
          Uri.http(httpUri, 'ztz/member/modify-address'),
          headers: {"Content-Type": "application/json"},
          body: body
      );
      if(modifyAddressResponse.statusCode == 200) {
        debugPrint("주소 수정 결과: " + jsonDecode(modifyAddressResponse.body).toString());
        ModifyAddressInfo.modifyAddressResult = true;
      }
    } catch(e) {
      debugPrint("주소 수정 오류 발생: " + e.toString());
    }
  }
}