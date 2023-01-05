import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ztz_app/pages/account/signup_page.dart';
import 'package:ztz_app/pages/home_page.dart';
import '../../controller/account/login_api.dart';
import '../../controller/account/sign_up_infos/account_state.dart';
import '../../utility/button_style.dart';
import '../text_filed/common_text_filed.dart';

class LoginComponent extends StatefulWidget{
  const LoginComponent({Key?key}) : super(key: key);

  @override
  _LoginComponent createState() => _LoginComponent();
}

class _LoginComponent extends State<LoginComponent>{

  late TextEditingController emailEditController;
  late TextEditingController passwordController;
  static final signInStorage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    emailEditController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailEditController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  login() async{
    await LoginApi().login(emailEditController.text, passwordController.text);

    var userTokenInfo = await signInStorage.read(key: "Log_in_token");
    if (userTokenInfo != null){
      showSuccessLogin();
    }else{
      // 로그인 실패 알람
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: EdgeInsets.only(left: 25, right: 25),
        child: Column(
          children: [
            SizedBox(height: 30),
            Container(
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    "회원 가입하고",
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "다양한 혜택을 받아보세요!",
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            TextFiledComponent(
              usedPosition: "email",
              controller: emailEditController,
            ),
            SizedBox(height: 15),
            TextFiledComponent(
              usedPosition: "password",
              controller: passwordController,
            ),
            SizedBox(height: 20),
            ElevatedButton(
                style: defaultElevatedButtonStyle(360, 50),
                onPressed: () {
                  login();
                },
                child: Text("로그인", style: TextStyle(fontSize: 15))),
            SizedBox(height: 15),
            ElevatedButton(
                style: defaultElevatedButtonStyle(360, 50),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage()));
                },
                child: Text("회원가입", style: TextStyle(fontSize: 15),))
          ],
        ));
  }

  void showSuccessLogin(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("로그인 성공!"),
          content: new Text("환영 합니다!"),
          actions: <Widget>[
            FlatButton(
              child: const Text("Close"),
              onPressed: () async {
                await AccountState.accountGet.isLoginCheck();
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage() ));
              },
            ),
          ],
        );
      },
    );
  }

  void showFailLogin(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("로그인 실패"),
          content: new Text("로그인에 실패 하였습니다."),
          actions: <Widget>[
            FlatButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}