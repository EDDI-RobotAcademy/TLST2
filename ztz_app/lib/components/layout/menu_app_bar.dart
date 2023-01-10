import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ztz_app/utility/text_styles.dart';

import '../../pages/cart.dart';

class MenuAppBar extends StatefulWidget with PreferredSizeWidget {
  const MenuAppBar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MenuAppBar> createState() => _MenuAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(50);
}

// 초록색 앱 바 + 하얀색 글자 + 장바구니 버튼 있음
class _MenuAppBarState extends State<MenuAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.1,
      // title => 카테고리, 검색, 마이페이지 등
      title: Text(widget.title, style: whiteBoldTextStyle(16)),
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
