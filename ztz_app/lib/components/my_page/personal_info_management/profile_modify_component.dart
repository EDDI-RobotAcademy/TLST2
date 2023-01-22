import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ztz_app/controller/account/member_api.dart';
import 'package:ztz_app/controller/account/member_modify_infos/modify_profile_info.dart';
import 'package:ztz_app/utility/button_style.dart';
import 'package:ztz_app/utility/text_field_decoration.dart';
import 'package:ztz_app/utility/text_styles.dart';

import '../../../controller/account/sign_up_infos/account_state.dart';
import '../../../pages/home_page.dart';
import '../../../utility/colors.dart';
import '../../../utility/text_field_validate.dart';

class ProfileModifyComponent extends StatefulWidget {
  const ProfileModifyComponent({Key? key}) : super(key: key);

  @override
  State<ProfileModifyComponent> createState() => _ProfileModifyComponent();
}

class _ProfileModifyComponent extends State<ProfileModifyComponent> {

  late bool managerCheck;
  bool isLoading = false;
  late TextEditingController passwordController;
  late TextEditingController newPasswordController;
  late TextEditingController newPasswordCheckController;
  late TextEditingController phoneNumberController = TextEditingController( text: AccountState.memberProfile['phoneNumber']);
  late TextEditingController managerCodeController;

  late FocusNode passwordFocus;
  late FocusNode newPasswordFocus;
  late FocusNode newPasswordCheckFocus;
  late FocusNode managerCodeFocus;
  late FocusNode phoneNumberFocus;

  @override
  void initState() {
    super.initState();
    managerCheck = AccountState.memberInfo['managerCheck'];
    passwordController = TextEditingController();
    newPasswordController = TextEditingController();
    newPasswordCheckController = TextEditingController();
    managerCodeController = TextEditingController();

    passwordFocus = FocusNode();
    newPasswordFocus = FocusNode();
    newPasswordCheckFocus = FocusNode();
    phoneNumberFocus = FocusNode();
    managerCodeFocus = FocusNode();
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if(!isLoading){
      return Padding( // 로딩시 나오는 동그라미 동글동글
        padding: EdgeInsets.all(100),
        child: Center(
          child: CircularProgressIndicator(
            color: ColorStyle.mainColor,
          ),
        ),
      );
    } else{
      return Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: managerCheck
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Text(
                      "관리자 코드",
                      style: blackTextStyle(14),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                        controller: managerCodeController,
                        decoration: textFieldDecoration("관리자 코드"),
                        keyboardType: TextInputType.text,
                        focusNode: managerCodeFocus,
                        onSaved: (value) {
                          setState(() {
                            managerCodeController.text = value!;
                          });
                        }),
                  )
                ],
              )
                  : null,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Text(
                "현재 비밀번호",
                style: blackTextStyle(14),
              ),
            ),
            SizedBox(
                height: 50,
                child: passwordTextFromField(
                    passwordController, "현재 비밀번호", passwordFocus)),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Text("새 비밀번호", style: blackTextStyle(14)),
            ),
            SizedBox(
                height: 50,
                child: passwordTextFromField(
                    newPasswordController, "새 비밀번호", newPasswordFocus)),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Text("새 비밀번호 확인", style: blackTextStyle(14)),
            ),
            SizedBox(
                height: 50,
                child: passwordTextFromField(newPasswordCheckController,
                    "새 비밀번호 확인", newPasswordCheckFocus)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("전화번호", style: blackTextStyle(14)),
            ),
            SizedBox(
              height: 50,
              child: TextFormField(
                  controller: phoneNumberController,
                  decoration: textFieldDecoration("전화번호"),
                  keyboardType: TextInputType.text,
                  focusNode: phoneNumberFocus,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onSaved: (value) {
                    setState(() {
                      phoneNumberController.text = value!;
                    });
                  }),
            ),
            Padding(
              padding: EdgeInsets.only(left: size.width - 110),
              child: TextButton(
                child:Text("회원탈퇴" ,style: TextStyle(color: ColorStyle.mainColor),),
                onPressed :(){
                  showCheckWithdrawalMember();
                }
              ),
            ),
            ElevatedButton(
                style: defaultElevatedButtonStyle(size.width - 10, 20),
                onPressed: () {
                  String myPassword = newPasswordController.text;
                  int tmp = myPassword.compareTo(newPasswordCheckController.text);
                  debugPrint("myPassword : " +
                      myPassword +
                      "newPasswordCheckController.text :" +
                      newPasswordCheckController.text +
                      "tmp : " +
                      tmp.toString());

                  if (tmp != 0) {
                    showCheckPassword();
                  } else if (managerCheck) {
                    modifyManagerProfile();
                  } else {
                    modifyMemberProfile();
                  }
                },
                child: Text("변경하기"))
          ],
        ),
      );
    }

  }

  Widget passwordTextFromField(controller, hintText, focusNode) {
    return TextFormField(
      controller: controller,
      decoration: textFieldDecoration(hintText),
      keyboardType: TextInputType.visiblePassword,
      focusNode: focusNode,
      obscureText: true,
      obscuringCharacter: '*',
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) => CheckValidate().validatePassword(focusNode, value!),
      onSaved: (value) {
        setState(() {
          controller.text = value!;
        });
      },
    );
  }

  void modifyMemberProfile() async {
    ModifyProfileInfo modifyProfileInfo = ModifyProfileInfo(
        AccountState.memberInfo['managerCheck'],
        passwordController.text,
        newPasswordController.text,
        phoneNumberController.text,
        AccountState.memberInfo['id'],
        managerCodeController.text);

    await MemberApi().requestModifyProfileToSpring(modifyProfileInfo);

    showModifyResultPassword();
  }

  void modifyManagerProfile() async {
    ModifyProfileInfo modifyProfileInfo = ModifyProfileInfo(
        AccountState.memberInfo['managerCheck'],
        passwordController.text,
        newPasswordController.text,
        phoneNumberController.text,
        AccountState.memberInfo['id'],
        managerCodeController.text);

    await MemberApi().requestModifyProfileToSpring(modifyProfileInfo);

    showModifyResultPassword();
  }

  void showModifyResultPassword() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text("결과"),
          content: Text(ModifyProfileInfo.resultMsg),
          actions: <Widget>[
            FlatButton(
              child: const Text("확인"),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (route) => false);
              },
            ),
          ],
        );
      },
    );
  }

  void showCheckPassword() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text("비밀번호가 다릅니다"),
          content: const Text("비밀번호를 확인해주세요"),
          actions: <Widget>[
            FlatButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void showCheckWithdrawalMember() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text("정말 탈퇴 하실건가요?"),
          content: Text("탈퇴 하시면 기존 주문 정보는 모두 삭제 됩니다."),
          actions: <Widget>[
            FlatButton(
              child: const Text("탈퇴하기"),
              onPressed: () async {
                await MemberApi().requestWithdrawalMemberToSpring(AccountState.accountGet.token.string);
                AccountState().isLogin = false.obs;
                await AccountState.signInStorage.deleteAll();
                Navigator.pop(context);
                showSuccessWithdrawal();
              },
            ),
          ],
        );
      },
    );
  }

  void showSuccessWithdrawal() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text("탈퇴가 완료되었습니다"),
          content: Text("그동안 저희 전통주를 이용해주셔서 감사합니다."),
          actions: <Widget>[
            FlatButton(
              child: const Text("확인"),
              onPressed: () async {
                await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
              },
            ),
          ],
        );
      },
    );
  }
}
