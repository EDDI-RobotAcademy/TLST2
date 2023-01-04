import 'package:flutter/material.dart';
import 'package:ztz_app/utility/text_styles.dart';

class MenuAppBar extends StatefulWidget with PreferredSizeWidget {
  const MenuAppBar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MenuAppBar> createState() => _MenuAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(50);
}

class _MenuAppBarState extends State<MenuAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // title => 카테고리, 검색, 마이페이지 등
      title: Text(widget.title, style: appBarTitleTextStyle(16)),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined),
          onPressed: () {
            // 장바구니 페이지로 이동
          },
        )
      ],
      backgroundColor: Color(0xff205C37),
    );
  }
}
