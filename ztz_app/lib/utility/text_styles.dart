import 'package:flutter/material.dart';
import 'package:ztz_app/utility/colors.dart';
//핑크색
TextStyle xSmallPinkTextStyle(){
  return const TextStyle(
      fontSize: 15,
      fontFamily: "NanumSquareNeo-cBd",
      color: ColorStyle.textPink
  );
}
//햐얀색

TextStyle lageWhiteTextStyle(){
  return const TextStyle(
      fontSize: 17,
      fontFamily: "NanumSquareNeo-cBd",
      color: Colors.white
  );
}

TextStyle xMediumWhiteTextStyle(){
  return const TextStyle(
      fontSize: 15,
      fontFamily: "NanumSquareNeo-cBd",
      color: Colors.white
  );
}
//검은색
TextStyle lageBlackTextStyle(){
  return const TextStyle(
      fontSize: 17,
      fontFamily: "NanumSquareNeo-dEb",
      color: Colors.black
  );
}

TextStyle xMediumBlackTextStyle(){
  return const TextStyle(
      fontSize: 15,
      fontFamily: "NanumSquareNeo-dEb",
      color: Colors.black
  );
}

TextStyle MediumBlackTextStyle(){
  return const TextStyle(
      fontSize: 12,
      fontFamily: "NanumSquareNeo-dEb",
      color: Colors.black
  );
}

TextStyle smallBlackTextStyle(){
  return const TextStyle(
      fontSize: 10,
      fontFamily: "NanumSquareNeo-cBd",
      color: Colors.black
  );
}
//회색

TextStyle xMediumGrayTextStyle(){
  return const TextStyle(
      fontSize: 15,
      fontFamily: "NanumSquareNeo-cBd",
      color: ColorStyle.textGray
  );
}

TextStyle mediumGrayTextStyle(){
  return const TextStyle(
      fontSize: 12,
      fontFamily: "NanumSquareNeo-cBd",
      color: ColorStyle.textGray
  );
}

TextStyle smallGrayTextStyle(){
  return const TextStyle(
      fontSize: 10,
      fontFamily: "NanumSquareNeo-cBd",
      color: ColorStyle.textGray
  );
}
//커스텀
TextStyle productTitleTextStyle(){
  return const TextStyle(
      fontSize: 18,
      fontFamily: "NanumSquareNeo-eHv",
      color: Colors.black
  );
}

TextStyle whiteBoldTextStyle(double fontSize) {
  return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: Colors.white
  );
}

TextStyle blackBoldTextStyle(double fontSize) {
  return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: Colors.black
  );
}

TextStyle greenBoldTextStyle(double fontSize) {
  return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: Color(0xff205C37)
  );
}

TextStyle whiteTextStyle(double fontSize) {
  return TextStyle(
      fontSize: fontSize,
      color: Colors.white
  );
}

TextStyle blackTextStyle(double fontSize) {
  return TextStyle(
      fontSize: fontSize,
      color: Colors.black
  );
}

TextStyle greenTextStyle(double fontSize) {
  return TextStyle(
      fontSize: fontSize,
      color: Color(0xff205C37)
  );
}

TextStyle productDetailTitle(){
  return const TextStyle(
      fontSize: 25,
      fontFamily: "NanumSquareNeo-dEb",
      color: Colors.black
  );
}

TextStyle welcomeTitle(){
  return const TextStyle(
      fontSize: 30,
      fontFamily: "NanumSquareNeo-eHv"
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
      fontFamily: "NanumSquareNeo-cBd",
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
