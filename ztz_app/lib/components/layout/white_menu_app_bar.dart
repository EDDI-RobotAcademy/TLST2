import 'package:flutter/material.dart';
import 'package:ztz_app/utility/text_styles.dart';

class WhiteMenuAppBar extends StatelessWidget with PreferredSizeWidget {
  const WhiteMenuAppBar({Key? key, required this.title}) : super(key: key);

  final String title;


  @override
  Size get preferredSize => Size.fromHeight(50);

  // 하얀색 앱 바 + 검은색 글자 + 장바구니 버튼 없음
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.grey,
      ),
      elevation: 0.3,
      // title => 카테고리, 검색, 마이페이지 등
      title: Text(title, style: blackBoldTextStyle(16)),
      centerTitle: true,
      backgroundColor: Colors.white,
      leading: InkWell(
        onTap: (){
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black,),
      ),
    );
  }
}