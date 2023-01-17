import 'package:flutter/material.dart';
import 'package:ztz_app/components/product/product_list/product_list_appbar.dart';

import '../../../components/product/favorite/favorite_product_list_component.dart';



class FavoriteProductListPage extends StatefulWidget {
  const FavoriteProductListPage({Key? key, required this.drinkItemIndex}) : super(key: key);

  final int drinkItemIndex;

  @override
  State<FavoriteProductListPage> createState() => _FavoriteProductListPage();
}

class _FavoriteProductListPage extends State<FavoriteProductListPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.drinkItemIndex,
      length: 7,
      child: Scaffold(
          appBar: ProductListAppbar(title: "좋아요",),
          body: const TabBarView(
            children: [
              SafeArea(
                  child: FavoriteProductListComponent(
                    drinkItem: "전체보기",
                  )),
              SafeArea(
                  child: FavoriteProductListComponent(
                    drinkItem: "소주증류주",
                  )),
              SafeArea(
                  child: FavoriteProductListComponent(
                    drinkItem: "리큐르",
                  )),
              SafeArea(
                  child: FavoriteProductListComponent(
                    drinkItem: "막걸리",
                  )),
              SafeArea(
                  child: FavoriteProductListComponent(
                    drinkItem: "약주청주",
                  )),
              SafeArea(
                  child: FavoriteProductListComponent(
                    drinkItem: "과실주",
                  )),
              SafeArea(
                  child: FavoriteProductListComponent(
                    drinkItem: "기타주류",
                  )),
            ],
          )),
    );
  }
}
