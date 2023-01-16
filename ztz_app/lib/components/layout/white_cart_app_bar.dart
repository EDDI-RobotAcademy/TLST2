import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ztz_app/pages/order/cart.dart';
import 'package:ztz_app/utility/text_styles.dart';

class WhiteCartAppBar extends StatelessWidget implements PreferredSizeWidget{
  const WhiteCartAppBar({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Size get preferredSize => Size.fromHeight(50);

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
      actions: <Widget>[
        IconButton(
            onPressed: () {
              //장바구니 라우터 연결
              Get.to(() => Cart());
            },
            icon: Icon(
              Icons.shopping_cart_outlined,
              color: Colors.black,
            )),
      ],
      leading: InkWell(
        onTap: (){
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black,),
      ),
    );
  }
}
