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
    } else {
      return null;
    }
  }

  String? validateBirthday(FocusNode focusNode, String value) {
    if(value.isEmpty) {
      focusNode.requestFocus();
      return '생년월일 8자리를 입력 해주세요';
    } else if(!value.isValidBirthday()) {
      focusNode.requestFocus();
      return '생년월일 8자리를 입력 해주세요';
    } else {
      return null;
    }
  }

  String? validatePhoneNumber(FocusNode focusNode, String value) {
    if(value.isEmpty) {
      focusNode.requestFocus();
      return '전화번호를 입력헤주세요';
    } else if(!value.isValidPhoneNumber()) {
      focusNode.requestFocus();
      return '- 를 포함한 전화번호를 입력해주세요';
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
        r'^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$');

    return emailRegExp.hasMatch(this);
  }

  // 비밀번호 양식 소문자 + 숫자 + 특수문자 + 최소 6자리 이상
  bool isValidPassword() {
    final passwordRegExp = RegExp(
        r"^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$");

    return passwordRegExp.hasMatch(this);
  }

  bool isValidBirthday(){
    final birthdayRegExp = RegExp(
      r"^(19[0-9][0-9]|20\d{2})(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$");

    return birthdayRegExp.hasMatch(this);
  }

  bool isValidPhoneNumber(){
    final phoneNumberRegExp = RegExp(
      r"/010-\d{4}-\d{4}/");

    return phoneNumberRegExp.hasMatch(this);
  }
}