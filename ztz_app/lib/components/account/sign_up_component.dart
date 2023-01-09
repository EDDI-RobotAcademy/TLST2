import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:remedi_kopo/remedi_kopo.dart';
import 'package:ztz_app/components/text_filed/common_text_filed.dart';
import 'package:ztz_app/controller/account/sign_up_api.dart';
import 'package:ztz_app/controller/account/sign_up_infos/manager_sign_up_info.dart';
import 'package:ztz_app/controller/account/sign_up_infos/member_sign_up_info.dart';
import 'package:ztz_app/pages/account/login_page.dart';
import 'package:ztz_app/utility/colors.dart';


import '../../controller/account/sign_up_infos/account_state.dart';
import '../../utility/button_style.dart';
import '../../utility/text_field_decoration.dart';
import '../../utility/text_styles.dart';

class SignUpComponent extends StatefulWidget{
  const SignUpComponent({Key?key}) : super(key: key);

  @override
  _SignUpComponent createState() => _SignUpComponent();
}

class _SignUpComponent extends State<SignUpComponent>{
  late List<bool> isSelected;

  late TextEditingController emailEditController;
  late TextEditingController passwordController;
  late TextEditingController checkPasswordController;
  late TextEditingController userNameController;
  late TextEditingController addressDetailController;
  late TextEditingController phoneNumberController;
  late TextEditingController birthdayController;
  late TextEditingController addressController;
  late TextEditingController managerCodeController;

  late String city;
  late String street;
  late String zipcode;

  var passEmailValidate = false;
  var passManagerCodeValidate = false;
  @override
  void initState() {
    super.initState();
    isSelected = [true, false];
    emailEditController = TextEditingController();
    passwordController = TextEditingController();
    checkPasswordController = TextEditingController();
    userNameController = TextEditingController();
    addressDetailController = TextEditingController();
    phoneNumberController = TextEditingController();
    birthdayController = TextEditingController();
    addressController = TextEditingController();
    managerCodeController = TextEditingController();
  }

  @override
  void dispose() {
    emailEditController.dispose();
    passwordController.dispose();
    checkPasswordController.dispose();
    userNameController.dispose();
    addressDetailController.dispose();
    phoneNumberController.dispose();
    birthdayController.dispose();
    addressController.dispose();
    managerCodeController.dispose();
    super.dispose();
  }
  //맴버 회원가입 함수
  memberSignUpFunction() async {
    MemberSignUpInfo memberSignUpInfo = MemberSignUpInfo(
        userNameController.text, emailEditController.text, passwordController.text, birthdayController.text,
        city, street, addressDetailController.text, zipcode, phoneNumberController.text);

    await SignUpApi().memberSignUp(memberSignUpInfo);
    if(AccountState.signUpResult){
      showSuccessSignUp();
    }
  }
  //관리자 회원가입 함수
  managerSignUpFunction() async {
    ManagerSignUpInfo managerSignUpInfo = ManagerSignUpInfo(
        userNameController.text, emailEditController.text, passwordController.text,
        birthdayController.text, phoneNumberController.text);

    await SignUpApi().managerSignUp(managerSignUpInfo);
    if(AccountState.signUpResult){
      showSuccessSignUp();
    }
  }
  //이매일 유효성 검사 함수
  emailValidation() async {
    await SignUpApi().emailValidate(emailEditController.text);
    if(AccountState.emailResult){
      passEmailValidate = true;
      showSuccessEmailValidate();
    }else{
      passEmailValidate = false;
      showFailEmailValidate();
    }
  }
  //매니저 코드 검사 함수
  managerCodeValidation() async {
    await SignUpApi().managerCodeValidate(managerCodeController.text);
    if(AccountState.managerCodeResult){
      passManagerCodeValidate = true;
      showSuccessManagerValidate();
    }else{
      passManagerCodeValidate = false;
      showFailManagerValidate();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 25,right: 25),
      child: Column(
        children: [
          SizedBox(height: 20,),
          ToggleButtons(
            selectedBorderColor: ColorStyle.mainColor,
              selectedColor: ColorStyle.mainColor,
              fillColor: Colors.white,
              children: const [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(" 일반 회원가입 "),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text("관리자 회원가입"),),
              ],
              onPressed: (int index) {
                setState(() {
                  for (int i = 0; i < isSelected.length; i++) {
                    isSelected[i] = i == index;
                  }
                  debugPrint(isSelected[0].toString());
                });
              },
              isSelected: isSelected),
          SizedBox(height: 10),
          SizedBox(
            child: isSelected[0] ? memberSignUp() : managerSignUp(),
          )
        ],
      ),
    );
  }

  //관리자 회원가입  UI
  Widget managerSignUp(){
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Column(
        children: [
          SizedBox(height: 7,),
          SizedBox(
              width: double.infinity,
              child: Text("관리자 검증",textAlign: TextAlign.left,style: defaultTextStyle(),)
          ),
          SizedBox(height: 5,),
          TextFiledComponent(controller: managerCodeController, usedPosition: "managerCode"),
          SizedBox(height: 5,),
          ElevatedButton(//관리자 검증 버튼
              onPressed: (){
                managerCodeValidation();
              },
              child: Text("관리자 코드 확인", style: whiteTextStyle(16),),style:defaultElevatedButtonStyle(360,50)),
          SizedBox(height: 7,),
          SizedBox(
              width: double.infinity,
              child: Text("이메일",textAlign: TextAlign.left,style: defaultTextStyle(),)
          ),
          SizedBox(height: 5,),
          TextFiledComponent(controller: emailEditController, usedPosition: "email"),
          SizedBox(height: 5,),
          ElevatedButton(//이메일 중복 버튼
              onPressed: (){
                emailValidation();
              },
              child: Text("이메일 중복", style: whiteTextStyle(16),),style:defaultElevatedButtonStyle(360,50)),
          SizedBox(height: 7,),
          SizedBox(
              width: double.infinity,
              child: Text("이름",textAlign: TextAlign.left,style: defaultTextStyle(),)
          ),
          SizedBox(height: 5,),
          TextFiledComponent(controller: userNameController, usedPosition: "nickName"),
          SizedBox(height: 7,),
          SizedBox(
              width: double.infinity,
              child: Text("비밀번호",textAlign: TextAlign.left,style: defaultTextStyle(),)
          ),
          SizedBox(height: 5,),
          TextFiledComponent(controller: passwordController, usedPosition: "password"),
          SizedBox(height: 7,),
          SizedBox(
              width: double.infinity,
              child: Text("비밀번호 확인",textAlign: TextAlign.left,style: defaultTextStyle(),)
          ),
          SizedBox(height: 5,),
          TextFiledComponent(controller: checkPasswordController, usedPosition: "passwordCheck"),
          SizedBox(height: 7,),
          SizedBox(
              width: double.infinity,
              child: Text("전화번호",textAlign: TextAlign.left,style: defaultTextStyle(),)
          ),
          SizedBox(height: 5,),
          TextFiledComponent(controller: phoneNumberController, usedPosition: "phoneNumber"),
          SizedBox(height: 7,),
          SizedBox(
              width: double.infinity,
              child: Text("생년월일",textAlign: TextAlign.left,style: defaultTextStyle(),)
          ),
          SizedBox(height: 5,),
          TextFiledComponent(controller: birthdayController, usedPosition: "birthdate"),
          SizedBox(height: 12,),
          ElevatedButton(//회원가입 버튼
            onPressed: (){

              String myPassword = passwordController.text;
              int tmp = myPassword.compareTo(checkPasswordController.text);
              debugPrint("myPassword : "+ myPassword
                  +"passwordCheckController.text :"+ checkPasswordController.text + "tmp : "+tmp.toString());

              if(tmp != 0){
                showCheckPassword();
              }else if(!passEmailValidate){
                showCheckEmail();
              }else if(!passManagerCodeValidate){
                showCheckManagerCode();
              }else{
                managerSignUpFunction();
              }
            },
            child: Text("가입하기", style: whiteTextStyle(16),),style:defaultElevatedButtonStyle(360,50),
          )
        ],
      ),
    );
  }
  //맴버 회원가입 UI
  Widget memberSignUp(){
    return Padding(
      padding: const EdgeInsets.all(3),
      child: Column(
        children: [
          textBox("이메일",emailEditController,"email"),
          SizedBox(height: 5),
          ElevatedButton(
              onPressed: (){
                emailValidation();
              },
              child: Text("이메일 중복 확인", style: whiteTextStyle(16),),style:defaultElevatedButtonStyle(360,50)),
          textBox("이름",userNameController,"nickName"),
          textBox("비밀번호",passwordController,"password"),
          textBox("비밀번호 확인",checkPasswordController,"passwordCheck"),
          // SizedBox(height: 7),
          // ElevatedButton(
          //     onPressed: (){
          //       HapticFeedback.mediumImpact();
          //       _addressApi();
          // }, child: Text("주소찾기"),style:defaultElevatedButtonStyle(300,25)),
          SizedBox(height: 7),
          SizedBox(
              width: double.infinity,
              child: Text("주소",textAlign: TextAlign.left,style: defaultTextStyle(),)
          ),
          SizedBox(height: 7,),
          addressTextFromField(),
          textBox("상세 주소",addressDetailController,"addressDetail"),
          textBox("전화번호",phoneNumberController,"phoneNumber"),
          textBox("생년월일",birthdayController,"birthdate"),
          SizedBox(height: 12),
          ElevatedButton(
            onPressed: (){

              String myPassword = passwordController.text;
              int tmp = myPassword.compareTo(checkPasswordController.text);
              debugPrint("myPassword : "+ myPassword
                  +"passwordCheckController.text :"+ checkPasswordController.text + "tmp : "+tmp.toString());

              if(tmp != 0){
                showCheckPassword();
              }else if(!passEmailValidate){
                showCheckEmail();
              }else{
                memberSignUpFunction();
              }
            },
            child: Text("가입하기", style: whiteTextStyle(16),),
            style:defaultElevatedButtonStyle(360,50),
          )
        ],
      ),
    );
  }

  //주소 찾기 api
  _addressApi() async {
    KopoModel model = await Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => RemediKopo ()
        )
    );
    addressController.text = '${model.zonecode!} ${model.address!} ${model.buildingName!}';
    city = model.sido!;
    street = model.address! + ' ' +  model.buildingName!;
    zipcode = model.zonecode!;
  }

  // 텍스트 필드 form
  Widget textBox(inputText , controller ,usedPosition ){
    return SizedBox(
      child: Column(
        children: [
          SizedBox(height: 7,),
          SizedBox(
            width: double.infinity,
            child: Text(inputText,textAlign: TextAlign.left,style: defaultTextStyle(),)
          ),
          SizedBox(height: 5,),
          TextFiledComponent(controller: controller, usedPosition: usedPosition)
        ],
      )
    );
  }


  //주소 텍스트 필드
  Widget addressTextFromField(){
    return TextFormField(
      controller: addressController,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
          focusedBorder:
          OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2.0)),
        hintText: '도로명, 지번, 건물명 검색',
        suffixIcon: IconButton(
          icon: Icon(Icons.search),
          color: Colors.black,
          onPressed: () {
            _addressApi();
          },
        )
      ),
      readOnly: true,
    );
  }

  // 여기는 전부 알람창
  void showCheckPassword(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("비밀번호가 다릅니다"),
          content: new Text("비밀번호를 확인해주세요"),
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
  void showCheckEmail(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("이메일검증이 필요합니다"),
          content: new Text("이메일 중복 확인 버튼을 눌러 이메일을 확인해주세요"),
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
  void showCheckManagerCode(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("관리자 코드 확인이 필요합니다"),
          content: new Text("관리자 코드 확인 버튼을 눌러 관리자검증을 해주세요"),
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
  void showSuccessEmailValidate(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("이메일 인증 완료"),
          content: new Text("해당 이메일은 사용 가능합니다!"),
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
  void showFailEmailValidate(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("이메일 인증 실패"),
          content: new Text("해당 이메일은 누군가 이미 사용중입니다."),
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
  void showSuccessManagerValidate(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("관리자 인증 완료"),
          content: new Text("관리자 인증이 완료 되었습니다."),
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
  void showFailManagerValidate(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("관리자 인증 실패"),
          content: new Text("해당 하는 관리자 코드가 없습니다."),
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
  void showSuccessSignUp(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("회원 가입 성공!"),
          content: new Text("축하합니다 \n회원 가입에 성공 했습니다!"),
          actions: <Widget>[
            FlatButton(
              child: const Text("Close"),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage() ));
              },
            ),
          ],
        );
      },
    );
  }
}