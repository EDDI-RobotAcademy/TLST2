import 'package:flutter/material.dart';
import 'package:ztz_app/utility/text_styles.dart';

class NaviAppBar extends StatefulWidget with PreferredSizeWidget {
  const NaviAppBar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<NaviAppBar> createState() => _NaviAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(50);
}

class _NaviAppBarState extends State<NaviAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      // title => 카테고리, 검색, 마이페이지 등
      title: Text(widget.title, style: appBarTitleTextStyle(),),
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
