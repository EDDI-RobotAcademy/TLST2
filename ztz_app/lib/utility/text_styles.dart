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

TextStyle productTextStyle(){
  return const TextStyle(
      fontSize: 12,
      fontFamily: "NanumSquareNeo-cBd",
      color: Colors.black
  );
}

TextStyle productHazeTextStyle(){
  return const TextStyle(
      fontSize: 10,
      fontFamily: "NanumSquareNeo-cBd",
      color: ColorStyle.textGray
  );
}

TextStyle productTitleTextStyle(){
  return const TextStyle(
      fontSize: 18,
      fontFamily: "NanumSquareNeo-eHv",
      color: Colors.black
  );
}

TextStyle appBarTitleTextStyle(){
  return const TextStyle(
      fontSize: 16,
      fontFamily: "NanumSquareNeo-bRg",
      fontWeight: FontWeight.bold,
      color: Colors.white
  );
}