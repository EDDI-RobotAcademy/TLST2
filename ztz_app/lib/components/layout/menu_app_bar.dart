import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ztz_app/pages/order/cart.dart';
import 'package:ztz_app/utility/text_styles.dart';

class MenuAppBar extends StatelessWidget with PreferredSizeWidget {
  const MenuAppBar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Size get preferredSize => Size.fromHeight(50);

  @override
  // 초록색 앱 바 + 하얀색 글자 + 장바구니 버튼 있음
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.1,
      // title => 카테고리, 검색, 마이페이지 등
      title: Text(title, style: whiteBoldTextStyle(16)),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined),
          onPressed: () {
            Get.to(() => Cart());
            // 장바구니 페이지로 이동
          },
        )
      ],
      backgroundColor: Color(0xff205C37),
    );

  }
}


