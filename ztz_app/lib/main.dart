import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ztz_app/pages/splash/splash_screen_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TLST',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: "/splash_page",
      routes: {
        "/splash_page" : (context) => const SplashScreenPage(),
      },
    );
  }
}
