import 'package:flutter/material.dart';
import 'package:ztz_app/components/product/product_list/product_list_appbar.dart';

import '../../components/layout/menu_app_bar.dart';
import '../../components/product/product_list/product_list_component.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key, required this.drinkItemIndex}) : super(key: key);

  final int drinkItemIndex;

  @override
  State<ProductListPage> createState() => _ProductListPage();
}

class _ProductListPage extends State<ProductListPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: widget.drinkItemIndex,
      length: 7,
      child: Scaffold(
          appBar: ProductListAppbar(),
          body: const TabBarView(
            children: [
              SafeArea(
                  child: ProductListComponent(
                    drinkItem: "전체보기",
                  )),
              SafeArea(
                  child: ProductListComponent(
                    drinkItem: "소주증류주",
                  )),
              SafeArea(
                  child: ProductListComponent(
                    drinkItem: "리큐르",
                  )),
              SafeArea(
                  child: ProductListComponent(
                    drinkItem: "막걸리",
                  )),
              SafeArea(
                  child: ProductListComponent(
                    drinkItem: "약주청주",
                  )),
              SafeArea(
                  child: ProductListComponent(
                    drinkItem: "과실주",
                  )),
              SafeArea(
                  child: ProductListComponent(
                    drinkItem: "기타주류",
                  )),
            ],
          )),
    );
  }
}
