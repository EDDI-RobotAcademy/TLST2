import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


import '../../controller/account/login_api.dart';
import '../../pages/main_page/main_page.dart';
import '../../utility/button_style.dart';
import '../../utility/text_styles.dart';
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
    signInStorage.deleteAll();
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
        padding: EdgeInsets.only(left: 25,right: 25),
      child: Column(
        children: [
          SizedBox(height: 80,),
          SizedBox(
            width: double.infinity,
            child: Text("ZTZ 로그인", style: welcomeTitle(), textAlign: TextAlign.left,),
          ),
          SizedBox(height: 20,),
          SizedBox(child: Text("이메일",textAlign: TextAlign.left,),height: 20,width: double.infinity,),
          TextFiledComponent(usedPosition: "email", controller: emailEditController,),
          SizedBox(height: 10,),
          SizedBox(child: Text("비밀번호",textAlign: TextAlign.left,),height: 20,width: double.infinity),
          TextFiledComponent(usedPosition: "password", controller: passwordController,),
          SizedBox(height: 20,),
          ElevatedButton(
              style: defaultElevatedButtonStyle(330,40),
              onPressed: (){
                login();
              },
              child: Text("로그인"))
        ],
      )
    );
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
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainPage() ));
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