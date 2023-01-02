import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:http/http.dart' as http;
import 'package:ztz_app/controller/account/sign_up_infos/account_state.dart';

class MemberApi{
  static const httpUri = '192.168.0.8:7777';

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
}