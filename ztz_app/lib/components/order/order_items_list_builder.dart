import 'package:flutter/material.dart';

import '../../utility/text_styles.dart';

class OrderItemsList extends StatefulWidget {
  const OrderItemsList({Key? key}) : super(key: key);

  @override
  State<OrderItemsList> createState() => _OrderItemsListState();
}

class _OrderItemsListState extends State<OrderItemsList> {
  @override
  Widget build(BuildContext context) {
      return Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.symmetric(vertical:22, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: const Color(0xffd5e3d8),
              width: 1,
            ),
          ),
          child: SizedBox(
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 80,
                      margin: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xffd5e3d8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset('assets/images/Hongju.jpg', fit: BoxFit.fitHeight),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(height: 2),
                        Text(
                          '경기홍주',
                          style: productInCartPriceTextStyle(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        SizedBox(height: 10),
                        Text(
                            "43000 won / 2개",
                            style: smallOrderTextStyle()
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  color: Colors.black12,
                  margin: EdgeInsets.fromLTRB(0, 16, 0, 20),
                ),
                Row(
                  children: [
                    Container(
                      width: 60,
                      height: 80,
                      margin: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xffd5e3d8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset('assets/images/item1.jpg', fit: BoxFit.fitHeight),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(height: 2),
                        Text(
                          '경기홍주',
                          style: productInCartPriceTextStyle(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        SizedBox(height: 10),
                        Text(
                            "43000 won / 2개",
                            style: smallOrderTextStyle()
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
      );
  }
}
