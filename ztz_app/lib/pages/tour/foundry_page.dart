
import 'package:flutter/material.dart';
import 'package:ztz_app/components/layout/white_cart_app_bar.dart';
import '../../components/tour/foundry_list_component.dart';

class FoundryPage extends StatefulWidget {
  const FoundryPage({Key? key}) : super(key: key);

  _FoundryPage createState() => _FoundryPage();
}

class _FoundryPage extends State<FoundryPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:WhiteCartAppBar(title: "양조장",),
        body: SingleChildScrollView(
          child:Column(
            children:[
              Container(
                width: double.infinity,
                  margin: EdgeInsets.only(top:0 , bottom: 12),
                  child: Image(image: AssetImage("assets/images/banner/second_banner3_1.jpg"), )
              ),
              FoundryListComponent(),
            ]
        )
        )
    );
  }
}
