import 'package:flutter/material.dart';
import 'package:ztz_app/components/layout/white_cart_app_bar.dart';
import 'package:ztz_app/components/product/month/month_list_component.dart';

class MonthListPage extends StatefulWidget {
  const MonthListPage({Key? key}) : super(key: key);

  @override
  State<MonthListPage> createState() => _MonthListPageState();
}

class _MonthListPageState extends State<MonthListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WhiteCartAppBar(title: "이달의 술"),
      body: MonthListComponent(),
    );
  }
}
