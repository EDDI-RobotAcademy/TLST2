import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ztz_app/pages/account/first_page.dart';
import 'package:ztz_app/utility/colors.dart';

class SplashScreenPage extends StatefulWidget{
  const SplashScreenPage({Key? key}) : super(key :key);


  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>{

  @override
  void initState(){
    super.initState();
    Timer( const Duration(seconds: 5), (){
      moveToMain();
    });
  }
  void moveToMain() {
    setState(() {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const FirstPage() ));
    });
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