import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ztz_app/controller/account/member_api.dart';
import 'package:ztz_app/controller/account/sign_up_infos/account_state.dart';
import 'package:ztz_app/controller/order/order_controller.dart';
import 'package:ztz_app/controller/order/order_infos/order_info.dart';
import 'package:ztz_app/controller/reivew/review_controller.dart';
import 'package:ztz_app/controller/reivew/review_infos/review_info.dart';
import 'package:ztz_app/pages/account/login_page.dart';
import 'package:ztz_app/pages/home_page.dart';
import 'package:ztz_app/utility/colors.dart';
import 'package:ztz_app/utility/text_styles.dart';

class MyPageForm extends StatefulWidget {
  const MyPageForm({Key? key, required this.token}) : super(key: key);

  final String token;

  @override
  State<MyPageForm> createState() => _MyPageFormState();
}

class _MyPageFormState extends State<MyPageForm> {
  var username = "";
  late var orderCnt;
  late var reviewCnt;
  late var myPageProfileList;

  @override
  void initState() {
    setProfileSection();
    super.initState();
  }

  void setProfileSection() async {
    await MemberApi().userVerification(widget.token);
    await ReviewController()
        .requestMyPageReviewToSpring(AccountState.memberInfo['id']);
    await OrderController().requestPaymentListFromSpring(widget.token);
    setState(() {
      username = AccountState.memberInfo['username'];
      orderCnt = OrderInfo.paymentList.length;
      reviewCnt = ReviewInfo.memberReviews.length;
      myPageProfileList = [
        {'title': "주문 내역", 'count': orderCnt},
        {'title': "리뷰 내역", 'count': reviewCnt},
        {'title': "예약 내역", 'count': 0},
      ];
    });
  }

  var myPageNaviList = [
    // page -> 이동할 페이지
    {'title': "주문 관리", 'page': LoginPage()},
    {'title': "리뷰 관리", 'page': LoginPage()},
    {'title': "예약 관리", 'page': LoginPage()},
    {'title': "상품 문의ㅅ", 'page': LoginPage()},
    {'title': "배송지 관리", 'page': LoginPage()},
    {'title': "개인 정보 수정", 'page': LoginPage()},
  ];

  @override
  Widget build(BuildContext context) {
    if (username.isEmpty) {
      return const Padding( // 로딩시 나오는 동그라미 동글동글
        padding: EdgeInsets.all(100),
        child: Center(
          child: CircularProgressIndicator(
            color: ColorStyle.mainColor,
          ),
        ),
      );
    } else {
      return Column(
        children: [
          Container(
            width: double.infinity,
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 0.2, color: Colors.grey))),
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Row(
                      children: [
                        SizedBox(width: 30),
                        SizedBox(
                            child: Text(username.toString() + '님',
                                style: blackBoldTextStyle(25)))
                      ],
                    ),
                    SizedBox(height: 30),
                    for (int i = 0; i < myPageProfileList.length; i++)
                      myPageProfile(myPageProfileList[i]['title'].toString(),
                          myPageProfileList[i]['count'].toString()),
                  ],
                ),
              ),
            ]),
          ),
          for (int i = 0; i < myPageNaviList.length; i++)
            myPageNavi(myPageNaviList[i]['title'].toString(),
                myPageNaviList[i]['page'] as Widget),
          ListTile(
            title: Text('로그아웃'),
            onTap: () async {
              //로그아웃
              AccountState().isLogin = false.obs;
              await AccountState.signInStorage.deleteAll();
              await Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
            },
            shape: Border(bottom: BorderSide(width: 0.2, color: Colors.grey)),
          )
        ],
      );
    }
  }

  Widget myPageNavi(String title, Widget linkedPage) {
    return ListTile(
      title: Text(title),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => linkedPage));
      },
      shape: Border(bottom: BorderSide(width: 0.2, color: Colors.grey)),
    );
  }

  Widget myPageProfile(String title, String cnt) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffc7d6cd),
      ),
      width: 250,
      height: 50,
      padding: EdgeInsets.only(left: 30, right: 30),
      margin: EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(
            cnt + ' 건',
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}
