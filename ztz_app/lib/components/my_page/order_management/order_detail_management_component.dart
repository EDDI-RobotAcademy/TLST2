import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ztz_app/controller/order/order_infos/order_info.dart';

import '../../../utility/button_style.dart';
import '../../../utility/text_styles.dart';

class OrderDetailManagementComponent extends StatefulWidget {
  const OrderDetailManagementComponent({Key? key, required this.paymentState}) : super(key: key);

  final String paymentState;
  @override
  State<OrderDetailManagementComponent> createState() =>
      _OrderDetailManagementComponent();
}

class _OrderDetailManagementComponent
    extends State<OrderDetailManagementComponent> {
  bool _productExpanded = true;
  bool _paymentExpanded = false;
  bool _orderInfoExpanded = false;
  bool _deliveryInfoExpanded = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          orderedProductTile(context),
          Divider(
            thickness: 8,
          ),
          paymentInfoPanel(),
          Divider(
            thickness: 8,
          ),
          orderedInfoPanel(),
          Divider(
            thickness: 8,
          ),
          deliveryInfoPanel(context),
          Divider(
            thickness: 8,
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            "결제취소는 전 상품 [결제완료] 상태일 경우에만 가능합니다.",
            style: grayLightTextStyle(13),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: widget.paymentState ==
                    "PAYMENT_COMPLETE"
                ? ElevatedButton(
                    onPressed: () {},
                    child: Text("전체 상품 결제 취소"),
                    style: defaultElevatedButtonStyle((size.width - 40), 50),
                  )
                : ElevatedButton(
                    onPressed: null,
                    child: Text("전체 상품 결제 취소"),
                    style: disableElevatedButtonStyle((size.width - 40), 50),
                  ),
          )
        ],
      ),
    );
  }

  Widget orderedProductTile(BuildContext context) {
    return ExpansionPanelList(
      elevation: 0,
      expandedHeaderPadding: EdgeInsets.all(0),
      animationDuration: Duration(milliseconds: 400),
      expansionCallback: (panelIndex, isExpanded) {
        _productExpanded = !_productExpanded;
        setState(() {});
      },
      children: [
        ExpansionPanel(
            isExpanded: _productExpanded,
            canTapOnHeader: true,
            headerBuilder: (context, isExpanded) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 17, 0, 0),
                child: Text(
                  "주문 번호 " + OrderInfo.orderInfoList[0]['payment']['imp_uid'],
                  style: blackBoldTextStyle(15),
                ),
              );
            },
            body: Column(
              children: List.generate(OrderInfo.orderInfoList.length,
                  (index) => orderedProductTileContent(context, index)),
            )),
      ],
    );
  }

  Widget orderedProductTileContent(BuildContext context, index) {
    var numberFormat = NumberFormat('###,###,###,###');
    String orderState = OrderInfo.orderInfoList[index]['orderState'];
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Image(
              image: AssetImage(
                  "assets/images/uploadImg/${OrderInfo.orderInfoList[index]['product']['productInfo']['thumbnailFileName']}"),
              fit: BoxFit.fill,
              width: 50,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Container(
            width: size.width - 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  OrderInfo.orderInfoList[index]['product']['name'],
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: MediumBlackTextStyle(),
                ),
                SizedBox(
                  height: 8,
                ),
                RichText(
                  text: TextSpan(
                      text: numberFormat.format(
                              OrderInfo.orderInfoList[index]['orderPrice']) +
                          "원",
                      style: mediumBlackBoldTextStyle(),
                      children: [
                        TextSpan(
                            text: "  |  " +
                                OrderInfo.orderInfoList[index]['orderCnt']
                                    .toString() +
                                "개",
                            style: mediumGrayTextStyle())
                      ]),
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
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
                                              : orderState ==
                                                      "DELIVERY_COMPLETE"
                                                  ? "배송완료"
                                                  : orderState ==
                                                          "DELIVERY_START"
                                                      ? "배송시작"
                                                      : "상태값이 존재하지 않습니다",
                      style: smallBlackTextStyle(),
                    ),
                    orderState == "DELIVERY_COMPLETE"
                        ? Row(
                            children: [
                              OutlinedButton(
                                  onPressed: () {}, child: Text("구매 확정")),
                              OutlinedButton(
                                  onPressed: () {}, child: Text("반품 신청"))
                            ],
                          )
                        : orderState == "PAYMENT_CONFIRM" ||
                                orderState == "REFUND_REQUEST"
                            ? OutlinedButton(
                                onPressed: () {}, child: Text("리뷰 작성"))
                            : SizedBox()
                  ],
                ),
                index == (OrderInfo.orderInfoList.length - 1)
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Divider(
                          thickness: 1,
                          color: Colors.white,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Divider(
                          thickness: 1,
                        ),
                      )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget paymentInfoPanel() {
    Size size = MediaQuery.of(context).size;
    var numberFormat = NumberFormat('###,###,###,###');
    return ExpansionPanelList(
      elevation: 0,
      expandedHeaderPadding: EdgeInsets.all(0),
      animationDuration: Duration(milliseconds: 400),
      expansionCallback: (panelIndex, isExpanded) {
        _paymentExpanded = !_paymentExpanded;
        setState(() {});
      },
      children: [
        ExpansionPanel(
            isExpanded: _paymentExpanded,
            canTapOnHeader: true,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 17, 0, 0),
                child: Text(
                  "결제 정보",
                  style: blackBoldTextStyle(15),
                ),
              );
            },
            body: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, bottom: 20),
                  width: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "상품금액",
                        style: grayLightTextStyle(14),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text("배송비", style: grayLightTextStyle(14)),
                      SizedBox(
                        height: 8,
                      ),
                      Text("적립금액", style: grayLightTextStyle(14)),
                      SizedBox(
                        height: 8,
                      ),
                      Text("총 금액", style: grayLightTextStyle(14)),
                    ],
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 20, right: 10),
                  width: size.width - 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(numberFormat.format(OrderInfo.orderInfoList[0]
                              ['payment']['totalPaymentPrice']) +
                          " 원"),
                      SizedBox(
                        height: 8,
                      ),
                      Text('0 원'),
                      SizedBox(
                        height: 8,
                      ),
                      Text("추후 추가 예정"),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        numberFormat.format(OrderInfo.orderInfoList[0]
                                ['payment']['totalPaymentPrice']) +
                            " 원",
                        style: blackBoldTextStyle(14),
                      ),
                    ],
                  ),
                )
              ],
            ))
      ],
    );
  }

  Widget orderedInfoPanel() {
    Size size = MediaQuery.of(context).size;
    return ExpansionPanelList(
      elevation: 0,
      expandedHeaderPadding: EdgeInsets.all(0),
      animationDuration: Duration(milliseconds: 400),
      expansionCallback: (panelIndex, isExpanded) {
        _orderInfoExpanded = !_orderInfoExpanded;
        setState(() {});
      },
      children: [
        ExpansionPanel(
            isExpanded: _orderInfoExpanded,
            canTapOnHeader: true,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 17, 0, 0),
                child: Text(
                  "주문 정보",
                  style: blackBoldTextStyle(15),
                ),
              );
            },
            body: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, bottom: 20),
                  width: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("주문번호", style: grayLightTextStyle(14)),
                      SizedBox(
                        height: 8,
                      ),
                      Text("보내는분", style: grayLightTextStyle(14)),
                      SizedBox(
                        height: 8,
                      ),
                      Text("결제일시", style: grayLightTextStyle(14)),
                    ],
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  width: size.width - 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(OrderInfo.orderInfoList[0]['payment']['imp_uid']),
                      SizedBox(
                        height: 8,
                      ),
                      Text(OrderInfo.orderInfoList[0]['member']['username']),
                      SizedBox(
                        height: 8,
                      ),
                      Text(OrderInfo.orderInfoList[0]['payment']['regData']),
                    ],
                  ),
                )
              ],
            ))
      ],
    );
  }

  Widget deliveryInfoPanel(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ExpansionPanelList(
      elevation: 0,
      expandedHeaderPadding: EdgeInsets.all(0),
      animationDuration: Duration(milliseconds: 400),
      expansionCallback: (panelIndex, isExpanded) {
        _deliveryInfoExpanded = !_deliveryInfoExpanded;
        setState(() {});
      },
      children: [
        ExpansionPanel(
            isExpanded: _deliveryInfoExpanded,
            canTapOnHeader: true,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 17, 0, 0),
                child: Text(
                  "배송 정보",
                  style: blackBoldTextStyle(15),
                ),
              );
            },
            body: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, bottom: 20),
                  width: 80,
                  // height: 120,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("받는분", style: grayLightTextStyle(14)),
                      SizedBox(
                        height: 11,
                      ),
                      Text("주소", style: grayLightTextStyle(14)),
                      SizedBox(
                        height: 24,
                      ),
                      Text("포장방법", style: grayLightTextStyle(14)),
                      SizedBox(
                        height: 8,
                      ),
                      Text("요청사항", style: grayLightTextStyle(14)),
                    ],
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 20),
                  width: size.width - 120,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(OrderInfo.orderInfoList[0]['member']['username']),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        OrderInfo.orderInfoList[0]['payment']['address']
                            ['street'],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Text("종이포장재"),
                      SizedBox(
                        height: 8,
                      ),
                      Text(OrderInfo.orderInfoList[0]['payment']
                          ['deliveryRequest']),
                    ],
                  ),
                )
              ],
            ))
      ],
    );
  }
}
