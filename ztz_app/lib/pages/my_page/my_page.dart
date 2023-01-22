import 'package:flutter/material.dart';
import 'package:ztz_app/components/layout/menu_app_bar.dart';
import 'package:ztz_app/components/my_page/my_page_form.dart';
import 'package:ztz_app/controller/account/sign_up_infos/account_state.dart';

import '../../components/manager_page/manager_page_form.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {

  @override
  Widget build(BuildContext context) {
      return Scaffold(
          appBar:
          AccountState.memberInfo['managerCheck'] == true? MenuAppBar(title: '관리자페이지'): MenuAppBar(title: '마이페이지'),
          body: SingleChildScrollView(
            child: Column(
          children: [
            if (AccountState.memberInfo['managerCheck'])
              ManagerPageForm(token: AccountState.accountGet.token.string)
            else
              MyPageForm(token: AccountState.accountGet.token.string)
             ],
            )
          )
      );
  }
}
