import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ztz_app/controller/account/member_api.dart';
import 'package:ztz_app/controller/account/sign_up_infos/account_state.dart';
import 'package:ztz_app/controller/order/order_controller.dart';
import 'package:ztz_app/controller/order/order_infos/order_info.dart';
import 'package:ztz_app/controller/reivew/review_controller.dart';
import 'package:ztz_app/controller/reivew/review_infos/review_info.dart';
import 'package:ztz_app/controller/tour/foundry_infos/foundry_info.dart';
import 'package:ztz_app/controller/tour/reservation_controller.dart';
import 'package:ztz_app/pages/home_page.dart';
import 'package:ztz_app/pages/my_page/modify_address_page.dart';
import 'package:ztz_app/pages/my_page/order_management/order_management_page.dart';
import 'package:ztz_app/pages/my_page/personal_info_management/profile_modify_page.dart';
import 'package:ztz_app/pages/my_page/reservation_management/my_reservation_page.dart';
import 'package:ztz_app/pages/my_page/board/question_board_page.dart';
import 'package:ztz_app/utility/colors.dart';
import 'package:ztz_app/utility/text_styles.dart';

import '../../pages/my_page/favorite_product/my_favorite_product_page.dart';
import '../../pages/my_page/review_management/reivew_management_page.dart';

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
  late var reservationCnt;
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
    await MemberApi().requestMemberProfileFromSpring(AccountState.accountGet.token.value);
    await ReservationController().requestMyReservationToSpring(widget.token);
    setState(() {
      username = AccountState.memberInfo['username'];
      orderCnt = OrderInfo.paymentList.length;
      reviewCnt = ReviewInfo.memberReviews.length;
      reservationCnt = FoundryInfo.reservationList.length;
      myPageProfileList = [
        {'title': "주문 내역", 'count': orderCnt},
        {'title': "리뷰 내역", 'count': reviewCnt},
        {'title': "예약 내역", 'count': reservationCnt},
      ];
    });
  }

  var myPageNaviList = [
    // page -> 이동할 페이지
    {'title': "주문 관리", 'page': OrderManagementPage()},
    {'title': "리뷰 관리", 'page': ReviewManagementPage()},
    {'title': "예약 관리", 'page': MyReservationPage()},
    {'title': "찜한 상품", 'page': MyFavoriteProductPage()},
    {'title': "1:1 문의", 'page': QuestionBoardPage()},
    {'title': "배송지 관리", 'page': ModifyAddressPage()},
    {'title': "개인 정보 수정", 'page': ProfileModifyPage()},
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
                            child: Text(username.toString() + '님 ',
                                style: blackBoldTextStyle(25))),
                        Container(
                            padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                            child: Text(AccountState.memberInfo['email'],
                                style: TextStyle(fontSize: 16, color: Colors.grey.shade700))
                        )
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
      width: 350,
      height: 50,
      padding: EdgeInsets.only(left: 30, right: 30),
      margin: EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: TextStyle(fontSize: 14)),
          Text(
            cnt + ' 건',
            textAlign: TextAlign.right,
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
