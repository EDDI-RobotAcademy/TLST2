import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class AccountState extends GetxController{
  static AccountState get accountGet => Get.find();

  static var emailResult = false;
  static var managerCodeResult = false;
  static var signUpResult = false;

  static late var memberInfo = {}.obs;
// AccountState.memberInfo['email'] 이메일 가져오기


  static final signInStorage = new FlutterSecureStorage();
  late RxBool isLogin;
  RxString token = "No".obs;

  Future<RxString> isLoginCheck() async {
    var maybeToken = await signInStorage.read(key: "Log_in_token");
    debugPrint("로그인 중?"+maybeToken.toString());
    if(maybeToken != null){
      isLogin = true.obs;
      token = maybeToken.toString().obs;
    }else{
      isLogin = false.obs;
    }
    return token;
  }
}