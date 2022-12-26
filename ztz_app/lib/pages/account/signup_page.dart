import 'package:flutter/material.dart';
import 'package:ztz_app/components/account/sign_up_component.dart';

class SignUpPage extends StatefulWidget{
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPage createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage>{

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
              child: SignUpComponent()
          ),
      ),
    );
  }
}