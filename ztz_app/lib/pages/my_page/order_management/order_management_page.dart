import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ztz_app/components/my_page/order_management/order_list_appbar.dart';

import '../../../components/my_page/order_management/order_management_conponent.dart';

class OrderManagementPage extends StatefulWidget {
  const OrderManagementPage({Key? key}) : super(key: key);

  @override
  State<OrderManagementPage> createState() => _OrderManagementPage();
}

class _OrderManagementPage extends State<OrderManagementPage> with TickerProviderStateMixin{

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    setState(() {
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: OrderListAppbar(controller: _tabController,),
        body: TabBarView(
          children: const [
            SafeArea(child: OrderManagementComponent(dateRange: "전체보기",)),
            SafeArea(child: OrderManagementComponent(dateRange: "3개월",)),
            SafeArea(child: OrderManagementComponent(dateRange: "6개월",)),
            SafeArea(child: OrderManagementComponent(dateRange: "1년",)),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}
