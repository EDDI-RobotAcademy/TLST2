import 'package:flutter/material.dart';
import 'package:ztz_app/components/layout/main_app_bar.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../components/main_page_components/home_banner.dart';
import '../../components/main_page_components/main_component.dart';
import '../../controller/account/member_api.dart';
import '../../controller/account/sign_up_infos/account_state.dart';

class MainPage extends StatelessWidget{
  const MainPage ({Key?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountState>(builder: (c) {
      return Scaffold(
        appBar: MainAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              HomeBanner(),
              MainComponent(),
              ElevatedButton(onPressed: (){
                MemberApi().userVerification(c.token.string);
                }, child: const Text("requestMemberInfo"))
            ],
          ),
        ),
      );
    });
  }


}