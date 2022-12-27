import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class LoginApi{
  static const httpUri = '192.168.0.8:7777';
  static final signInStorage = new FlutterSecureStorage();
  login (String email,String password) async{

    var data = {'email': email, 'password': password};
    var body = json.encode(data);

    debugPrint(body);
    try{
      var signInResponse = await http.post(
        Uri.http(httpUri,'/ztz/member/sign-in'),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if(signInResponse.statusCode == 200){
        var userToken = utf8.decode(signInResponse.bodyBytes);
        debugPrint("데이터" + userToken);
        await signInStorage.write(key: "Log_in_token", value: userToken);
      }else{
        debugPrint("로그인 실패" + signInResponse.statusCode.toString());
      }
    }catch (e){
      debugPrint("오류 발생 " + e.toString());
    }
  }
}