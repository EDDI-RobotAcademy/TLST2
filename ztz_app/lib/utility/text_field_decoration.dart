import 'package:flutter/material.dart';
import 'package:ztz_app/utility/colors.dart';
import 'package:ztz_app/utility/text_styles.dart';

InputDecoration textFieldDecoration(String hintText){
  return InputDecoration(
    hintStyle: hintTextStyle(),
    hintText: hintText,
    contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
    border:
    OutlineInputBorder(),
    focusedBorder:
    OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black, width: 2.0)),
    errorBorder:
    OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red , width: 2.0)),
    focusedErrorBorder:
    OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 2.0)),
  );
}