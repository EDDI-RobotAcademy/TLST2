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

InputDecoration searchTextFieldDecoration(String hintText ,TextEditingController controller) {
  return InputDecoration(
    suffixIcon: Padding(
        padding: const EdgeInsets.all(0),
        child: IconButton(
          icon: const Icon(
            Icons.clear,
            color: ColorStyle.mainColor,
          ),
          onPressed: () { controller.clear(); },
        )),
    hintStyle: hintTextStyle(),
    hintText: hintText,
    prefixIcon: const Padding(
      padding: EdgeInsets.only(left: 13),
      child: Icon(
        Icons.search,
        color: ColorStyle.mainColor,
      ),
    ),
    contentPadding:
        const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black, width: 2.0)),
    errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 2.0)),
    focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.red, width: 2.0)),
  );
}