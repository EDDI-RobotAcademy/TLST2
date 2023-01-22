import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ztz_app/components/my_page/order_management/order_list_appbar.dart';

import '../../../components/manager_page/order_management/all_order_management_conponent.dart';


class AllOrderManagementPage extends StatefulWidget {
  const AllOrderManagementPage({Key? key}) : super(key: key);

  @override
  State<AllOrderManagementPage> createState() => _AllOrderManagementPage();
}

class _AllOrderManagementPage extends State<AllOrderManagementPage> with TickerProviderStateMixin{

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
            SafeArea(child: AllOrderManagementComponent(dateRange: "전체보기",)),
            SafeArea(child: AllOrderManagementComponent(dateRange: "3개월",)),
            SafeArea(child: AllOrderManagementComponent(dateRange: "6개월",)),
            SafeArea(child: AllOrderManagementComponent(dateRange: "1년",)),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}
