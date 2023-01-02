import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ztz_app/pages/home_page.dart';
import 'package:ztz_app/utility/colors.dart';

import '../../controller/account/sign_up_infos/account_state.dart';

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
  void moveToMain() async {
    await AccountState.accountGet.isLoginCheck();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage() ));
  }

  @override
  Widget build(BuildContext context) {
    Get.put(AccountState());
    return Scaffold(
      body: Container(
          color: ColorStyle.mainColor,
          child: const Center(child: Image(image: AssetImage("assets/images/LogoAnimation.gif"),))
      ),
    );
  }
}