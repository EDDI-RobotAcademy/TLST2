import 'package:flutter/material.dart';
import 'package:ztz_app/utility/colors.dart';

ButtonStyle defaultElevatedButtonStyle(double width,double height){
  return ButtonStyle(
      fixedSize: MaterialStateProperty.all(Size(width,height)),
      elevation: MaterialStateProperty.all(0),
      shape:MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      overlayColor: MaterialStateProperty.all(Colors.orange),
      backgroundColor: MaterialStateProperty.all(ColorStyle.mainColor),
  );
}