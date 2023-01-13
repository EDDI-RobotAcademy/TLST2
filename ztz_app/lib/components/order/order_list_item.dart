import 'package:flutter/material.dart';
import '../../utility/text_styles.dart';
class OrderItem extends StatefulWidget {
  var orderItem;

  OrderItem(this.orderItem);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  var orderItem;

  @override
  void initState() {
    super.initState();
    orderItem = widget.orderItem;
  }

  @override
  Widget build(BuildContext context) {
      return Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical:8),

          child: Row(
            children: [
              Container(
                width: 60,
                height: 80,
                margin: const EdgeInsets.only(right: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Image.asset('assets/images/uploadImg/${orderItem['thumbnail']}', fit: BoxFit.cover),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(height: 2),
                  Text(
                    '${orderItem['productName']}',
                    style: productInCartPriceTextStyle(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  SizedBox(height: 10),
                  Text(
                      "${orderItem['selectedProductAmount']} won / ${orderItem['count']}개",
                      style: smallOrderTextStyle()
                  ),
                ],
              )
            ],
          )
      );
    }
}
