import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:ztz_app/components/main_page_components/todays_recommend_component.dart';

import '../../controller/account/sign_up_infos/account_state.dart';
import '../../pages/home_page.dart';
import '../../utility/text_styles.dart';
import 'main_foundry_list_component.dart';


class MainComponent extends StatefulWidget {
  const MainComponent({Key?key}) : super (key: key);

  @override
  _MainComponent createState() =>_MainComponent();
}

class _MainComponent extends State<MainComponent>{
  static final signInStorage = new FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top:20 , bottom: 12,left: 3),
            child: Text("👍 오늘의 추천 ZTZ",style: productTitleTextStyle(),textAlign: TextAlign.left,),
          ),
          ToDaysRecommendComponent(),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top:30 , bottom: 12,left: 3),
            child: Text("🏫 TOUR + EXPERIENCE", style: productTitleTextStyle(),textAlign: TextAlign.left,),
          ),
          MainFoundryListComponent(),
          ElevatedButton(
              onPressed: () async{
                AccountState().isLogin = false.obs;
                await AccountState.signInStorage.deleteAll();
               // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage() ));
              },
              child: const Text("임시 로그아웃")),
        ],
      ),
    );
  }
}