import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import '../../utility/text_styles.dart';
import 'order_list_item.dart';

class OrderItemsList extends StatefulWidget {
  var receivedData;

  OrderItemsList({
    Key? key,
    required this.receivedData
  }) : super(key: key);

  @override
  State<OrderItemsList> createState() => _OrderItemsListState();
}

class _OrderItemsListState extends State<OrderItemsList> {
  var orderItems;

  @override
  void initState() {
    super.initState();
    orderItems = widget.receivedData;
    print("list builder :" + orderItems.toString());
  }

  @override
  Widget build(BuildContext context) {
      return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.fromLTRB(20,22,20,16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: const Color(0xffd5e3d8),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 30,
                        child: Text(
                            "주문 상품",
                            style: productInCartPriceTextStyle()
                        ),
                      )
                    ],
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: orderItems.length,
                      itemBuilder: (context, index){
                        return Column(
                          children: [
                            OrderItem(orderItems[index]),
                            orderItems.length != index + 1 ? verticalLine(): SizedBox(height: 1)
                          ],
                        );
                      }
                  )
                ],
              )
      );
  }

  Widget verticalLine(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 1,
      color: Colors.black12,
      margin: EdgeInsets.fromLTRB(0, 16, 0, 20),
    );
  }
}
