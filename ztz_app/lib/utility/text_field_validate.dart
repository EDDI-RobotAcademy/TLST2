import 'package:flutter/cupertino.dart';

class CheckValidate{
  String? validateEmail(FocusNode focusNode, String value){
    if(value.isEmpty) {
      focusNode.requestFocus();
      return '이메일을 입력하세요';
    } else if(!value.isValidEmail()) {
      focusNode.requestFocus();
      return '유효하지 않은 이메일 형식입니다.';
    } else {
      return null;
    }
  }

  String? validatePassword(FocusNode focusNode, String value) {
    if(value.isEmpty) {
      focusNode.requestFocus();
      return '비밀번호를 입력하세요';
    } else if(!value.isValidPassword()) {
      focusNode.requestFocus();
      return '유효하지 않은 비밀번호입니다.';
    } else {
      return null;
    }
  }

  String? defaultValidate(FocusNode focusNode, String value){
    if(value.isEmpty) {
      focusNode.requestFocus();
      return '값을 입력하세요';
    }else{
      return null;
    }
  }
}

extension InputValidate on String {

  //이메일 양식
  bool isValidEmail() {
    final emailRegExp = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

    return emailRegExp.hasMatch(this);
  }

  // 비밀번호 양식 소문자 + 숫자 + 특수문자 + 최소 6자리 이상
  bool isValidPassword() {
    final passwordRegExp = RegExp(
        r"^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$");

    return passwordRegExp.hasMatch(this);
  }
}