import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/main_page_components/main_component.dart';

class MainPage extends StatelessWidget{
  const MainPage ({Key?key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: MainComponent(),
      ),
    );
  }


}