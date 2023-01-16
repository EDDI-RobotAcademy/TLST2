import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ztz_app/components/product/best/best_list_component.dart';
import 'package:ztz_app/components/product/product_list/product_list_appbar.dart';

class BestListPage extends StatefulWidget {
  const BestListPage({Key? key}) : super(key: key);

  @override
  State<BestListPage> createState() => _BestListPageState();
}

class _BestListPageState extends State<BestListPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      initialIndex: 0,
      child: Scaffold(
          appBar: ProductListAppbar(title: "베스트"),
          body: const TabBarView(
            children: [
              SafeArea(
                  child: BestListComponent(
                    drinkItem: "전체보기",
                  )),
              SafeArea(
                  child: BestListComponent(
                    drinkItem: "소주증류주",
                  )),
              SafeArea(
                  child: BestListComponent(
                    drinkItem: "리큐르",
                  )),
              SafeArea(
                  child: BestListComponent(
                    drinkItem: "막걸리",
                  )),
              SafeArea(
                  child: BestListComponent(
                    drinkItem: "약주청주",
                  )),
              SafeArea(
                  child: BestListComponent(
                    drinkItem: "과실주",
                  )),
              SafeArea(
                  child: BestListComponent(
                    drinkItem: "기타주류",
                  )),
            ],
          )
      ),
    );
  }
}
