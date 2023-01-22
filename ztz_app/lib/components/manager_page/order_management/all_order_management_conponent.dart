import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../controller/order/order_controller.dart';
import '../../../controller/order/order_infos/order_info.dart';
import '../../../pages/manager_page/order_management/all_order_detail_page.dart';
import '../../../utility/colors.dart';
import 'all_order_list_card.dart';

class AllOrderManagementComponent extends StatefulWidget {
  const AllOrderManagementComponent({Key? key,required this.dateRange}) : super(key: key);

  final String dateRange;
  @override
  State<AllOrderManagementComponent> createState() => _AllOrderManagementComponent();
}

class _AllOrderManagementComponent extends State<AllOrderManagementComponent> {

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setPaymentList();
  }

  void setPaymentList() async {
    switch (widget.dateRange) {
      case "전체보기":
        await OrderController()
            .requestPaymentListFromSpring("");
        break;
      case "3개월":
        await OrderController().requestPaymentListByDataFromSpring(
            "", "3개월");
        break;
      case "6개월":
        await OrderController().requestPaymentListByDataFromSpring(
            "",  "6개월");
        break;
      case "1년":
        await OrderController().requestPaymentListByDataFromSpring(
            "", "1년");
        break;
    }

    setState(() {
      isLoading = true;
    });
  }

  void callOrderList(paymentId , index) async {
    await OrderController().requestOrderInfoByPaymentId(paymentId);
    Get.to(
        AllOrderDetailPage(paymentState: OrderInfo.paymentList[index]['paymentState'],),
        //next page class
        duration: Duration(milliseconds: 500),
        //duration of transitions, default 1 sec
        transition: Transition.rightToLeft,
        //transition effect
        popGesture: true // 슬라이드로 뒤로가기
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: !isLoading
          ? const Padding(
              // 로딩시 나오는 동그라미 동글동글
              padding: EdgeInsets.all(100),
              child: Center(
                child: CircularProgressIndicator(
                  color: ColorStyle.mainColor,
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: List.generate(
                    OrderInfo.paymentList.length,
                    (index) => AllOrderListCard(
                        paymentDate: OrderInfo.paymentList[index]['regData'],
                        deliveryRequest: OrderInfo.paymentList[index]
                            ['deliveryRequest'],
                        orderState: OrderInfo.paymentList[index]
                            ['paymentState'],
                        imp_uid: OrderInfo.paymentList[index]['imp_uid'],
                        paymentTitle: OrderInfo.paymentList[index]
                            ['paymentTitle'],
                        totalPrice: OrderInfo.paymentList[index]
                            ['totalPaymentPrice'],
                        onTap: () {
                          callOrderList(OrderInfo.paymentList[index]['paymentId'] , index);
                        },
                        index: index)),
              ),
            ),
    );
  }
}
