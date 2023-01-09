import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ztz_app/controller/order/cart_controller.dart';

import 'cart_list_item.dart';

class CartList extends StatefulWidget {
  const CartList({Key? key}) : super(key: key);

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {

  @override
  void initState() {
    super.initState();
    CartController.checkStatusMap.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Obx(() =>
          CartController.obsCartStatus.value ? fullCartList() : emptyCartList() ,
        )
    );
  }

  Widget emptyCartList() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 120,
      alignment: Alignment.center,
      child: const Text("비어있는 카트입니다.", textAlign: TextAlign.center),
    );
  }

  Widget fullCartList(){
    print("reBuild + fullCart");
    return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 420,
          child: Obx(() =>
              ListView.builder(
                  itemCount: CartController.reactiveCartList.length,
                  itemBuilder: (context, index){
                    return
                      CartListItem(
                        index: index,
                        itemNo: CartController.reactiveCartList[index]['itemNo'],
                      );
                  }
              )
          )
      );
  }

}
