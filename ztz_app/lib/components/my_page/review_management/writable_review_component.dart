import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ztz_app/components/my_page/review_management/writable_review_list_card.dart';
import 'package:ztz_app/controller/order/order_controller.dart';

import '../../../controller/account/sign_up_infos/account_state.dart';
import '../../../controller/order/order_infos/order_info.dart';
import '../../../utility/colors.dart';
import '../../../utility/text_styles.dart';

class WritableReviewComponent extends StatefulWidget {
  const WritableReviewComponent({Key? key}) : super(key: key);

  @override
  State<WritableReviewComponent> createState() => _WritableReviewComponent();
}

class _WritableReviewComponent extends State<WritableReviewComponent> {
  bool isLoading = false;
  bool isPresentReview = true;

  @override
  void initState() {
    super.initState();
    requestWritableOrderList();
  }

  void requestWritableOrderList() async {
    String memberToken = AccountState.accountGet.token.string;
    await OrderController().requestWritableOrderList(memberToken);
    setState(() {
      isLoading = true;
      if (OrderInfo.writableOrderInfoList.isEmpty) {
        isPresentReview = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            : !isPresentReview
                ? SizedBox(
                  height: size.height,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("작성 가능한 후기가 없습니다."),
                    ],
                  ),
                )
                : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: Text("총 " + OrderInfo.writableOrderInfoList.length.toString() + "개"
                      ,style: blackBoldTextStyle(16),),
                    ),
                    writableReviewCard(),
                  ],
                ));
  }

  Widget writableReviewCard() {
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
            OrderInfo.writableOrderInfoList.length,
            (index) => Column(
                  children: [
                    WritableReviewListCard(
                      productName: OrderInfo.writableOrderInfoList[index]['product']['name'],
                      price: OrderInfo.writableOrderInfoList[index]['orderPrice'],
                      image: OrderInfo.writableOrderInfoList[index]['product']['productInfo']['thumbnailFileName'],
                      orderCnt: OrderInfo.writableOrderInfoList[index]['orderCnt'],
                      orderState: OrderInfo.writableOrderInfoList[index]['orderState'],
                      productId: OrderInfo.writableOrderInfoList[index]['product']['productNo'],
                      orderID: OrderInfo.writableOrderInfoList[index]['orderID'],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20 , right: 20),
                      child: Divider(thickness: 1,),
                    )
                  ],
                )),
      ),
    );
  }
}
