import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ztz_app/components/my_page/order_management/order_detail_management_component.dart';

import '../../../utility/text_styles.dart';

class OrderDetailPage extends StatefulWidget {
  const OrderDetailPage ({Key?key, required this.paymentState}): super (key:key);

  final String paymentState;

  @override
  State<OrderDetailPage> createState() => _OrderDetailPage();
}

class _OrderDetailPage extends State<OrderDetailPage>{
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            elevation: 1,
            backgroundColor: Colors.white,
            centerTitle: true,
            title:Text("주문 내역 상세" ,style: blackTextStyle(14),),
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.black,
                )),
          ),
          body: SingleChildScrollView(
            child: OrderDetailManagementComponent( paymentState: widget.paymentState,),
      ),
    ));
  }
}