
import 'package:flutter/material.dart';

import '../../components/tour/foundry_list_component.dart';
import '../../components/layout/main_app_bar.dart';
import '../../utility/text_styles.dart';

class FoundaryPage extends StatefulWidget {
  const FoundaryPage({Key? key}) : super(key: key);

  _FoundaryPage createState() => _FoundaryPage();
}

class _FoundaryPage extends State<FoundaryPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(),
        body: SingleChildScrollView(
          child:Column(
            children:[
              Container(
                width: double.infinity,
                  margin: EdgeInsets.only(top:10 , bottom: 12),
                  child: Image(image: AssetImage("assets/images/banner/second_banner2.jpg"), )
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top:30 , bottom: 12,left: 3),
                child: Text("🏫 TOUR + EXPERIENCE", style: productTitleTextStyle(),textAlign: TextAlign.left,),
              ),
              FoundryListComponent(),
            ]
        )
        )
    );
  }
}
