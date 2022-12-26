import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ztz_app/api/account/sign_up_infos/manager_sign_up_info.dart';
import 'package:ztz_app/api/account/sign_up_infos/member_sign_up_info.dart';
import 'package:http/http.dart' as http;

import 'sign_up_infos/account_state.dart';


class SignUpApi{
  static const httpUri = '192.168.0.8:7777';

  memberSignUp(MemberSignUpInfo memberSignUpInfo) async {
    var data = {'email' : memberSignUpInfo.email, 'password' : memberSignUpInfo.password , 'username' : memberSignUpInfo.username,
      'birthdate' : memberSignUpInfo.birthdate, 'city' : memberSignUpInfo.city,'street':memberSignUpInfo.street,
      'addressDetail' : memberSignUpInfo.addressDetail , 'zipcode' : memberSignUpInfo.zipcode , 'phoneNumber' : memberSignUpInfo.phoneNumber,
      'authorityNo' : 2 , 'authorityName' : '일반회원' , 'managerCheck' : false};
    var body = json.encode(data);

    debugPrint(body);

    try{
      var signUpResponse = await http.post(
          Uri.http(httpUri,'/ztz/member/sign-up'),
          headers: {"Content-Type": "application/json"},
          body: body,
      );
      if(signUpResponse.statusCode == 200){
        debugPrint("결과 : " + jsonDecode(signUpResponse.body).toString());
        if(jsonDecode(signUpResponse.body)){
          AccountState.signUpResult = true;
        }
      }
    }catch(e){
      debugPrint("오류 발생 " + e.toString());
    }
  }

  managerSignUp(ManagerSignUpInfo managerSignUpInfo) async {
    var data = {'email' : managerSignUpInfo.email , 'password' : managerSignUpInfo.password , 'username' : managerSignUpInfo.username,
    'birthdate' : managerSignUpInfo.birthdate ,'phoneNumber' : managerSignUpInfo.phoneNumber,
    'authorityNo' : 1 , 'authorityName' : '관리자' , 'managerCheck' : true};

    var body = json.encode(data);
    debugPrint(body);

    try{
      var signUpResponse = await http.post(
        Uri.http(httpUri,'/ztz/member/sign-up'),
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if(signUpResponse.statusCode == 200){
        debugPrint("결과 : " + jsonDecode(signUpResponse.body).toString());
        if(jsonDecode(signUpResponse.body)){
          AccountState.signUpResult = true;
        }
      }
    }catch(e){
      debugPrint("오류 발생 " + e.toString());
    }
  }

  emailValidate(String email) async {
    AccountState.emailResult = false;
    var data = {'email' : email};
    var body = json.encode(data);

    debugPrint(body);

    try{
      var validateResponse = await http.post(
        Uri.http(httpUri,'/ztz/member/check-email/$email'),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if(validateResponse.statusCode == 200){
        debugPrint("통신 확인");
        debugPrint("결과 : " + jsonDecode(validateResponse.body).toString());
        if(jsonDecode(validateResponse.body)){
          AccountState.emailResult = true;
        }
      }
    }catch(e){
      debugPrint("오류 발생 " + e.toString());
    }
  }
  managerCodeValidate(String managerCode) async {
    AccountState.managerCodeResult = false;
    var data = {'managerCode' : managerCode};
    var body = json.encode(data);

    debugPrint(body);

    try{
      var validateResponse = await http.post(
        Uri.http(httpUri,'/ztz/member/check-manager/$managerCode'),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      if(validateResponse.statusCode == 200){
        debugPrint("통신 확인");
        debugPrint("결과 : " + jsonDecode(validateResponse.body).toString());
        if(jsonDecode(validateResponse.body)){
          AccountState.managerCodeResult = true;
        }
      }
    }catch(e){
      debugPrint("오류 발생 " + e.toString());
    }
  }
}