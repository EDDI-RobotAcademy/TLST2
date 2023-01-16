import 'package:flutter/material.dart';

import '../../../components/layout/menu_app_bar.dart';
import '../../../components/my_page/personal_info_management/profile_modify_component.dart';

class ProfileModifyPage extends StatefulWidget{
  const ProfileModifyPage({Key?key}) : super(key: key);

  @override
  State<ProfileModifyPage> createState() => _ProfileModifyPage();
}

class _ProfileModifyPage extends State<ProfileModifyPage>{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: MenuAppBar(title: '개인정보 수정',),
          body: SingleChildScrollView(child: ProfileModifyComponent()),
        )
    );
  }

}