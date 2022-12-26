import 'package:flutter/material.dart';
import 'package:ztz_app/utility/colors.dart';

TextStyle welcomeTitle(){
  return const TextStyle(
      fontSize: 30,
      fontFamily: "Cafe24Ohsquare"
  );
}

TextStyle welcomeSubTitle(){
  return const TextStyle(
      fontSize: 15,
      fontFamily: "Cafe24Ohsquare",
      color:ColorStyle.textGray
  );
}

TextStyle hintTextStyle(){
  return const TextStyle(
      fontSize: 12,
      fontFamily: "Cafe24Ohsquare",
      color:ColorStyle.textGray
  );
}

TextStyle defaultTextStyle(){
  return const TextStyle(
      fontSize: 12,
      fontFamily: "Cafe24Ohsquare",
      color: Colors.black
  );
}