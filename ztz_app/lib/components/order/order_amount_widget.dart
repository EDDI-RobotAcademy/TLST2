import 'package:flutter/material.dart';

import '../../utility/text_styles.dart';

class OrderAmount extends StatefulWidget {
  var receivedData;

  OrderAmount({
    Key? key,
    required this.receivedData
  }) : super(key: key);

  @override
  State<OrderAmount> createState() => _OrderAmountState();
}

class _OrderAmountState extends State<OrderAmount> {
  var priceData;
  int sum = 0;

  @override
  void initState() {
    super.initState();
    priceData = widget.receivedData;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.symmetric(vertical: 10),
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
                  Text(
                      "${priceData[0]} won",
                      style: productInCartPriceTextStyle()
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

                  Text(
                      // sum > 50000 ? "0 won" : "3000 won",
                     "${priceData[1]} won",
                      style: productInCartPriceTextStyle()
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

                  Text(
                      //sum > 50000 ? "$sum won" : "${sum + 3000} won",
                      "${priceData[2]} won",
                      style: productInCartPriceTextStyle()
                  ),
                ]
            ),
          ],
        )
    );
  }
}
