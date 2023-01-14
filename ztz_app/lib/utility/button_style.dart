import 'package:flutter/material.dart';
import 'package:ztz_app/utility/colors.dart';

ButtonStyle defaultElevatedButtonStyle(double width,double height){
  return ButtonStyle(
      fixedSize: MaterialStateProperty.all(Size(width,height)),
      elevation: MaterialStateProperty.all(0),
      shape:MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      backgroundColor: MaterialStateProperty.all(ColorStyle.mainColor),
  );
}

ButtonStyle disableElevatedButtonStyle(double width,double height){
  return ButtonStyle(
    fixedSize: MaterialStateProperty.all(Size(width,height)),
    elevation: MaterialStateProperty.all(0),
    shape:MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
    backgroundColor: MaterialStateProperty.all(Colors.grey),
  );
}

ButtonStyle defaultOutlinedButtonStyle(double width,double height){
  return ButtonStyle(
    fixedSize: MaterialStateProperty.all(Size(width,height)),
    elevation: MaterialStateProperty.all(0),
    shape:MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
    side: MaterialStateProperty.all(BorderSide(color: ColorStyle.mainColor, width: 1.0, style: BorderStyle.solid))
  );
}