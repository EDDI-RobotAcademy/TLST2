import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ztz_app/pages/account/login_page.dart';
import 'package:ztz_app/utility/colors.dart';

import '../../utility/button_style.dart';
import '../../utility/text_styles.dart';

class FirstPage extends StatelessWidget{
  const FirstPage({Key? key}) : super(key :key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 400),
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(40),topLeft: Radius.circular(40)),
                color: ColorStyle.mainColor),
            child: Column(
              children: [
                const SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage() ));
                  },
                  child: const Text("로그인",),
                  style: defaultElevatedButtonStyle(300,50),),
                const SizedBox(height: 30,),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage() ));
                  },
                  child: const Text("회원가입",),
                  style: defaultElevatedButtonStyle(300,50),)
              ],
            ),
          ),
          Container(
            child:Column(children: const [
              SizedBox(height: 100,),
              Image(image: AssetImage("assets/images/welcomeImage.png"),)
            ],
            )
          ),
          Container(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                SizedBox(height: 60,),
                Text("ZTZ", style: welcomeTitle(),),
                Text("전국의 모든 전통주", style: welcomeSubTitle(),)
              ],
            ),
          )
        ],
      )
    );
  }

}