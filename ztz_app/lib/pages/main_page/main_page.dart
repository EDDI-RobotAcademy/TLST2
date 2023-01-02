import 'package:flutter/material.dart';
import 'package:ztz_app/components/layout/main_app_bar.dart';
import 'package:ztz_app/components/layout/menu_app_bar.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../components/main_page_components/main_component.dart';
import '../../controller/account/member_api.dart';
import '../../controller/account/sign_up_infos/account_state.dart';
import '../../utility/text_styles.dart';

class MainPage extends StatelessWidget{
  const MainPage ({Key?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AccountState>(builder: (c) {
      return Scaffold(
        appBar: MainAppBar(),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 12, bottom: 5, left: 3),
                child: Text(
                  "👍 오늘의 추천 ZTZ",
                  style: productTitleTextStyle(),
                  textAlign: TextAlign.left,
                ),
              ),
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