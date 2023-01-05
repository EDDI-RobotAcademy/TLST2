import 'package:flutter/material.dart';
import 'package:ztz_app/components/account/sign_up_component.dart';
import 'package:ztz_app/components/layout/white_menu_app_bar.dart';

class SignUpPage extends StatefulWidget{
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPage createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage>{

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: WhiteMenuAppBar(title: "회원가입"),
      body: SafeArea(
          child: SingleChildScrollView(
              child: SignUpComponent()
          ),
      ),
    );
  }
}