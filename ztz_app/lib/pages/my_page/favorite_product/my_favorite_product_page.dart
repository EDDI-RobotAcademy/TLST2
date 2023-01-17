import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ztz_app/components/layout/white_cart_app_bar.dart';

import '../../../components/my_page/favorite/my_favorite_product_component.dart';

class MyFavoriteProductPage extends StatefulWidget {
  const MyFavoriteProductPage({Key? key}) : super(key: key);

  @override
  State<MyFavoriteProductPage> createState() => _MyFavoriteProductPage();
}

class _MyFavoriteProductPage extends State<MyFavoriteProductPage> {


  @override
  void initState() {
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: WhiteCartAppBar(title: "찜한 상품"),
        body: SafeArea(child: MyFavoriteProductComponent()),

      );
  }
}
