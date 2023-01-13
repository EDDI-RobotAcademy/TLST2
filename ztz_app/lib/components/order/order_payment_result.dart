import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ztz_app/controller/order/api/order_service_api.dart';

import '../../utility/colors.dart';
import '../layout/menu_app_bar.dart';

class OrderPaymentResult extends StatefulWidget {



  @override
  State<OrderPaymentResult> createState() => _OrderPaymentResultState();
}

class _OrderPaymentResultState extends State<OrderPaymentResult> {
  var result = Get.arguments[0];
  var orderItems = Get.arguments[1];

  late bool isSuccessed;

  @override
  void initState() {
    super.initState();
    isSuccessed = getIsSuccessed(result);
    print(result.toString());
    print(orderItems.toString());

    debugPrint("결제 결과: ${result['success']}");
  }

  bool getIsSuccessed(var result) {
    if (result['imp_success'] == 'true') {
      OrderService.requestOrder(
          result['imp_uid'],
          result['merchant_uid'],
          orderItems
      );
      return true;
    }
    if (result['success'] == 'true') {
      OrderService.requestOrder(
          result['imp_uid'],
          result['merchant_uid'],
          orderItems);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MenuAppBar(title: '주문 완료',),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              width: double.infinity,
              margin: EdgeInsets.only(bottom: 50),
              child: Image(image: AssetImage("assets/images/banner/second_banner5.jpg"), )
          ),
          if(isSuccessed)
            Text('결제에 성공하였습니다. 이용해주셔서 감사합니다.', style: TextStyle(fontSize: 15),)
          else
            Text('결제에 실패했습니다. 다시 시도해주세요'),
          Container(
            padding: EdgeInsets.fromLTRB(50.0, 30.0, 50.0, 30.0),
            child: Column(
              children: <Widget>[
                isSuccessed ? Container(
                  padding: EdgeInsets.fromLTRB(0, 5.0, 0, 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 4,
                          child: Text('주문 번호', style: TextStyle(color: Colors.grey))
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(result['merchant_uid'] ?? '-'),
                      ),
                    ],
                  ),
                ) : Container(
                  padding: EdgeInsets.fromLTRB(0, 5.0, 0, 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text('에러 메시지', style: TextStyle(color: Colors.grey)),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(result['error_msg'] ?? '-'),
                      ),
                    ],
                  ),
                ),
              ],

            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(25),
            margin: const EdgeInsets.only(left: 30, right: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(0xffc7d6cd),
                boxShadow: [
                ],
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                )
            ),
            child: Text("ZTZ는 전국팔도의 좋은 우리 술을 엄선하여 셀렉 판매 합니다."
                "ZTZ의 상품은 한번 마시면 (ㅋㅅㅋ)!",
              style: TextStyle(color: Colors.grey.shade700,
                // fontWeight: FontWeight.w700,
              ),),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 100,
                  height: 35,
                  child:
                  ElevatedButton(
                      style:
                      ElevatedButton.styleFrom(
                          primary: Colors.white,
                          side: BorderSide(width:1, color:ColorStyle.mainColor),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.all(0)
                      ),
                      onPressed: () {

                      },
                      child: Text("메인으로", style: TextStyle(fontSize: 12, color: ColorStyle.mainColor),)),
                ),
                SizedBox(width: 5,),
                Container(
                  width: 100,
                  height: 35,
                  child:
                  ElevatedButton(
                      style:
                      ElevatedButton.styleFrom(
                          primary: ColorStyle.mainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          padding: EdgeInsets.all(0)
                      ),
                      onPressed: (){
                        print("야호");
                      },
                      child: Text("예약현황", style: TextStyle(fontSize: 12),)),
                ),
              ],
            ),
          )

        ],
      ),
    );
  }
}
