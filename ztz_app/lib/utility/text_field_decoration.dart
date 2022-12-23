import 'package:flutter/material.dart';
import 'package:ztz_app/utility/colors.dart';
import 'package:ztz_app/utility/text_styles.dart';

InputDecoration textFieldDecoration(String hintText){
  return InputDecoration(
    hintStyle: hintTextStyle(),
    hintText: hintText,
    contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
    enabledBorder:
    OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.black, width: 2.0)
    ),
    focusedBorder:
    OutlineInputBorder(borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: ColorStyle.mainColor, width: 2.0)),
    errorBorder:
    OutlineInputBorder(borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red , width: 2.0)),
    focusedErrorBorder:
    OutlineInputBorder(borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.red, width: 2.0)),
  );
}