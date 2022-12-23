import 'package:flutter/material.dart';
import 'package:ztz_app/utility/colors.dart';

ButtonStyle defaultElevatedButtonStyle(double width,double height){
  return ButtonStyle(
      fixedSize: MaterialStateProperty.all(Size(width,height)),
      elevation: MaterialStateProperty.all(5.0),
      shape:MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      overlayColor: MaterialStateProperty.all(ColorStyle.mainColor),
      backgroundColor: MaterialStateProperty.all(Colors.orange),
  );
}