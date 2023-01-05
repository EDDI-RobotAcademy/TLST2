import 'package:flutter/material.dart';
import 'package:ztz_app/utility/text_styles.dart';

class WhiteMenuAppBar extends StatefulWidget with PreferredSizeWidget {
  const WhiteMenuAppBar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<WhiteMenuAppBar> createState() => _WhiteMenuAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(50);
}

// 하얀색 앱 바 + 검은색 글자 + 장바구니 버튼 없음
class _WhiteMenuAppBarState extends State<WhiteMenuAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.grey,
      ),
      elevation: 0.3,
      // title => 카테고리, 검색, 마이페이지 등
      title: Text(widget.title, style: blackBoldTextStyle(16)),
      centerTitle: true,
      backgroundColor: Colors.white,
    );
  }
}
