import 'package:flutter/material.dart';
import 'package:ztz_app/components/account/login_component.dart';
import 'package:ztz_app/components/layout/white_menu_app_bar.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}) : super(key:key);


    @override
    _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage>{

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        appBar: WhiteMenuAppBar(title: "로그인"),
        body: SafeArea(
          child: SingleChildScrollView(
              child: LoginComponent()
          ),
        ),
    );
  }
}