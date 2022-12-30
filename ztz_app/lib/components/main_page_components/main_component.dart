import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ztz_app/components/main_page_components/todays_recommend_component.dart';


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
          ToDaysRecommendComponent(),
          ElevatedButton(
              onPressed: (){
                signInStorage.deleteAll();
              },
              child: const Text("임시 로그아웃(localStorage 삭제)"))
        ],
      ),
    );
  }
}