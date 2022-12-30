import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ztz_app/pages/home_page.dart';
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
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage() ));

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