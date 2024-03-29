import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../pages/order/cart.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  const MainAppBar({Key? key}) : super(key: key);


  @override
  Size get preferredSize => Size.fromHeight(50);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.1,
      title: Image.asset("assets/images/logo/logo.png", width: 100, height: 30),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.shopping_cart_outlined),
          onPressed: () {
            Get.to(() => Cart()); // 장바구니 페이지로 이동
          },
        )
      ],
      backgroundColor: Color(0xff205C37),
    );
  }
}
