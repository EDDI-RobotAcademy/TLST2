
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utility/text_field_decoration.dart';
import '../../utility/text_field_validate.dart';

class TextFiledComponent extends StatefulWidget{
  const TextFiledComponent({Key? key, required this.controller , required this.usedPosition}) : super(key: key);

  final TextEditingController controller;
  final String usedPosition;

  @override
  State<TextFiledComponent> createState() => _TextFiledComponent();
}

class _TextFiledComponent extends State<TextFiledComponent>{

  var Controller;
  late String hintText;
  late FocusNode nickNameFocus;
  late FocusNode emailFocus;
  late FocusNode passwordFocus;
  late FocusNode passwordCheckFocus;
  late FocusNode addressFocus;
  late FocusNode phoneNumberFocus;

  late FocusNode useFocus;
  var textInputType = TextInputType.text;

  void initState() {
    super.initState();
    Controller = widget.controller;
    setPosition();
  }

  void setPosition(){
    switch(widget.usedPosition){
      case "nickName":
        hintText = "이름";
        nickNameFocus = FocusNode();
        useFocus = nickNameFocus;
        textInputType = TextInputType.text;
        break;
      case "email":
        hintText = "이메일";
        emailFocus = FocusNode();
        useFocus = emailFocus;
        textInputType = TextInputType.emailAddress;
        break;
      case "password":
        hintText = "비밀번호";
        passwordFocus = FocusNode();
        useFocus = passwordFocus;
        textInputType = TextInputType.visiblePassword;
        break;
      case "passwordCheck":
        hintText = "비밀번호 확인";
        passwordCheckFocus = FocusNode();
        useFocus = passwordCheckFocus;
        textInputType = TextInputType.visiblePassword;
        break;
      case "addressDetail":
        hintText = "상세주소";
        addressFocus = FocusNode();
        useFocus = addressFocus;
        textInputType = TextInputType.text;
        break;
      case "phoneNumber":
        hintText = "전화번호";
        phoneNumberFocus = FocusNode();
        useFocus = phoneNumberFocus;
        textInputType = TextInputType.number;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
      return TextFormField(
        controller: Controller,
        decoration: textFieldDecoration(hintText),
        keyboardType : textInputType,
        focusNode: useFocus,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.usedPosition == "email"?
            (value) => CheckValidate().validateEmail(useFocus, value!):
        widget.usedPosition == "password"?
            (value) => CheckValidate().validatePassword(useFocus, value!):
        widget.usedPosition == "passwordCheck" ?
            (value) => CheckValidate().validatePassword(useFocus, value!):
            (value) => CheckValidate().defaultValidate(useFocus, value!),
        onSaved: (value) {
          setState(()
          {Controller.text = value!;}
          );
        },
      );
  }

}