import 'package:flutter/material.dart';
import 'package:ztz_app/components/layout/main_app_bar.dart';
import 'package:ztz_app/components/layout/menu_app_bar.dart';

import '../../components/main_page_components/main_component.dart';

class MainPage extends StatelessWidget{
  const MainPage ({Key?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MainAppBar(),
      body: SafeArea(
        child: MainComponent(),
      ),
    );
  }


}