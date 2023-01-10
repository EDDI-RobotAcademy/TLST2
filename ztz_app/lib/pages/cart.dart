import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/layout/menu_app_bar.dart';
import '../components/order/cart_list_builder.dart';
import '../controller/order/cart_controller.dart';
import '../utility/text_styles.dart';


class Cart extends StatelessWidget {
  Cart({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    Get.put(CartController());
    return Scaffold(
      appBar: MenuAppBar(title:'My Cart'),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(13, 10, 15, 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: const Color(0xfff0f3f1),
                  ),
                  child: Obx(() =>
                      Text(
                          "선택된 상품 ${CartController.selectNum.value}",
                          style: productInCartNameTextStyle()
                      )
                  )
                ),
                CartList(),
                //가격
                Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    padding: const EdgeInsets.symmetric(vertical:30, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: const Color(0xfff0f3f1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[
                              Text(
                                  "상품금액 :  ",
                                  style: productInCartNameTextStyle()
                              ),
                              Obx(() =>
                                  Text(
                                      "${CartController.totalAmount} won",
                                      style: productInCartPriceTextStyle()
                                  ),
                              ),
                            ]
                        ),
                        SizedBox(height: 8),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[
                              Text(
                                  "배송비 :  ",
                                  style: productInCartNameTextStyle()
                              ),
                              Obx(() =>
                                  Text(
                                      "${CartController.deliveryFee} won",
                                      style: productInCartPriceTextStyle()
                                  ),
                              ),
                            ]
                        ),
                        SizedBox(height: 12),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          color: Color(0xffacc0b8),
                        ),
                        SizedBox(height: 12),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:[
                              Text(
                                  "총합금액 :  ",
                                  style: productInCartNameTextStyle()
                              ),
                              Obx(() =>
                                  Text(
                                      "${CartController.sum} won",
                                      style: productInCartPriceTextStyle()
                                  ),
                              ),
                            ]
                        ),
                      ],
                    )
                ),
                //버튼
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 54,

                  child: ElevatedButton(
                    child: Obx(() =>
                        Text(
                            "${CartController.sum}원 결제하기",
                            style: buttonTextStyle()
                        ),
                    ),
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xff276039)),
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            )
                        )
                    ),
                  ),
                )
              ],
            ),
          )
      )
    );
  }
}
