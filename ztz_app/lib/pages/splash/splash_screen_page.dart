import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ztz_app/pages/account/first_page.dart';
import 'package:ztz_app/pages/main_page/main_page.dart';
import 'package:ztz_app/utility/colors.dart';

class SplashScreenPage extends StatefulWidget{
  const SplashScreenPage({Key? key}) : super(key :key);


  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>{
  static final signInStorage = new FlutterSecureStorage();

  @override
  void initState(){
    super.initState();
    Timer( const Duration(seconds: 5), (){
      moveToMain();
    });
  }
  void moveToMain() async {
    var isLogIn = await signInStorage.read(key: "Log_in_token");
    if(isLogIn != null){
      setState(() {// 로그인이 되어 있으면 메인 페이지 이동
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage() ));
      });
    }else{
      setState(() {//비로그인시 로그인 or 회원 가입 선택 창으로 이동
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FirstPage() ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          color: ColorStyle.mainColor,
          child: const Center(child: Image(image: AssetImage("assets/images/LogoAnimation.gif"),))
      ),
    );
  }
}