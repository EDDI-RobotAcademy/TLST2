import 'package:flutter/material.dart';
import 'package:ztz_app/controller/account/member_api.dart';
import 'package:ztz_app/controller/account/sign_up_infos/account_state.dart';
import 'package:ztz_app/pages/account/login_page.dart';
import 'package:ztz_app/pages/category/category_page.dart';
import 'package:ztz_app/pages/main_page/main_page.dart';
import 'package:ztz_app/pages/my_page/my_page.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  var loginInfoCheck = false;

  @override
  void initState() {
    loginCheck();
    super.initState();
  }

  void loginCheck() async {
    await AccountState.accountGet.isLoginCheck();
    debugPrint("로그인 체크" + AccountState.accountGet.isLogin.value.toString());
    if (AccountState.accountGet.isLogin.value) {
      await MemberApi().userVerification(AccountState.accountGet.token.value);
      setState(() {
        loginInfoCheck = true;
      });
    }
  }

  static const List _loginPages = [
    //로그인 상태에서 보이는 페이지
    MainPage(),
    CategoryPage(),
    MainPage(),
    LoginPage(),
  ];

  static List _logoutPages = [
    //로그아웃 상태에서 보이는 페이지
    MainPage(),
    CategoryPage(),
    MainPage(),
    MyPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: loginInfoCheck == false
              ? _loginPages.elementAt(_selectedIndex)
              : _logoutPages.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.reorder),
              label: 'Category'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'My'
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xff205C37),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}