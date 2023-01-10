import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../utility/text_styles.dart';

class OrderListCard extends StatelessWidget {
  const OrderListCard(
      {Key? key,
      required this.paymentDate,
      required this.deliveryRequest,
      required this.orderState,
      required this.imp_uid,
      required this.paymentTitle,
      required this.totalPrice,
      required this.onTap,
      required this.index})
      : super(key: key);

  final String paymentDate, deliveryRequest, orderState, imp_uid, paymentTitle;
  final int totalPrice, index;
  final VoidCallback onTap;

  Widget paymentContent(BuildContext context) {
    return Row(
      children: [
        paymentTitleColumnContent(),
        SizedBox(
          width: 40,
        ),
        paymentContentColumnContent(context)
      ],
    );
  }

  Widget paymentTitleColumnContent() {
    return SizedBox(
      width: 50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "상품 명",
            style: mediumBlackLightTextStyle(),
          ),
          SizedBox(
            height: 10,
          ),
          Text("주문 번호", style: mediumBlackLightTextStyle()),
          SizedBox(
            height: 10,
          ),
          Text("결제 금액", style: mediumBlackLightTextStyle()),
          SizedBox(
            height: 10,
          ),
          Text("주문 상태", style: mediumBlackLightTextStyle()),
          SizedBox(
            height: 10,
          ),
          Text("요청 사항", style: mediumBlackLightTextStyle()),
        ],
      ),
    );
  }

  Widget paymentContentColumnContent(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var numberFormat = NumberFormat('###,###,###,###');
    return SizedBox(
      width: (size.width - 120),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            paymentTitle,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: mediumBlackBoldTextStyle(),
          ),
          SizedBox(
            height: 10,
          ),
          Text(imp_uid, style: mediumBlackBoldTextStyle()),
          SizedBox(
            height: 10,
          ),
          Text(numberFormat.format(totalPrice) + "원",
              style: mediumBlackBoldTextStyle()),
          SizedBox(
            height: 10,
          ),
          Text(
              orderState == "PAYMENT_COMPLETE"
                  ? "결제완료"
                  : orderState == "PAYMENT_REFUND"
                      ? "환불완료"
                      : orderState == "DELIVERY_ONGOING"
                          ? "배송중"
                          : orderState == "PART_DELIVERY_ONGOING"
                              ? "부분배송중"
                              : orderState == "PAYMENT_CONFIRM"
                                  ? "구매확정"
                                  : orderState == "REFUND_REQUEST"
                                      ? "반품신청"
                                      : orderState == "DELIVERY_COMPLETE"
                                          ? "배송완료"
                                          : "상태값이 존재하지 않습니다",
              style: mediumBlackBoldTextStyle()),
          SizedBox(
            height: 10,
          ),
          Text(deliveryRequest,
              overflow: TextOverflow.ellipsis, style: mediumBlackBoldTextStyle()),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          child: Column(
        children: [
          index == 0
              ? const SizedBox()
              : const Divider(
                  thickness: 8,
                ),
          ListTile(
            visualDensity: VisualDensity(vertical: -3),
            title: Padding(
              padding: const EdgeInsets.only(top: 6 , left: 3),
              child: Text(paymentDate, style: mediumBlackBoldTextStyle()),
            ),
            trailing: Text("주문 상세 > ", style: mediumBlackBoldTextStyle()),
          ),
          const Divider(
            thickness: 0.7,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 20),
            child: paymentContent(context),
          ),
          SizedBox(
            height: 10,
          )
        ],
      )),
    );
  }
}
