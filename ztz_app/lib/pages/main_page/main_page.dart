import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/main_page_components/main_component.dart';
import '../../utility/text_styles.dart';

class MainPage extends StatelessWidget{
  const MainPage ({Key?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top:12 , bottom: 5,left: 3),
              child: Text("👍 오늘의 추천 ZTZ",style: productTitleTextStyle(),textAlign: TextAlign.left,),
            ),
            MainComponent(),
          ],
        ),
      ),
    );
  }


}