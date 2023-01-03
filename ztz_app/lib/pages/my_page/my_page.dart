import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ztz_app/components/account/login_component.dart';
import 'package:ztz_app/components/layout/menu_app_bar.dart';
import 'package:ztz_app/components/my_page/my_page_form.dart';
import 'package:ztz_app/controller/account/sign_up_infos/account_state.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountState>(builder: (c) {
      return Scaffold(
          appBar: MenuAppBar(title: '마이페이지'),
          body: SingleChildScrollView(
            child: checkLoginStatus()
          )
      );

    });
  }

  // 로그인 상태 확인
  Widget checkLoginStatus() {
    return GetBuilder<AccountState>(builder: (c){
      if(c.token.string == 'No')
        return LoginComponent();
      else
        return MyPageForm(token: c.token.toString());
    });
  }
}
