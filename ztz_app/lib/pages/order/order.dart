
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ztz_app/components/order/select_box.dart';


import '../../components/order/order_items_list_builder.dart';
import '../../utility/text_styles.dart';

class OrderPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black87),
          centerTitle: true,
          title: const Text(
              '주문서',
              style: TextStyle(color: Colors.black87)
          ),
          backgroundColor: Colors.white,
          shadowColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(13, 10, 15, 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  OrderItemsList(),
                  Container(
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
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children:[
                          Text("주문자 정보", style: productInCartPriceTextStyle()),
                          Text("홍길동,010-0000-0001", style: smallOrderTextStyle()),
                        ]
                    ),
                  ),  // 내정보
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.symmetric(vertical:8, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xffd5e3d8),
                        width: 1,
                      ),
                    ),
                    child:Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("배송지 정보", style: productInCartPriceTextStyle()),
                            TextButton(
                              child: Text("배송지 변경", style: smallOrderTextStyle()),
                              onPressed: (){},
                            )
                          ],
                        ),
                        Text(
                            "서울시 마포구 성산2동 주소 이하 서울시 마포구 성산2동 주소 이하 서울시 마포구 성산2동 주소 이하 "),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          color: Colors.black12,
                          margin: EdgeInsets.fromLTRB(0, 16, 0, 20),
                        ),
                        MessageSelectBox()

                      ],
                    )
                  ),  //배송지
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.symmetric(vertical:8, horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: const Color(0xffd5e3d8),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                        Text("결제 방법", style: productInCartPriceTextStyle()),
                        TextButton(
                            child: Text("이니시스", style: smallOrderTextStyle()),
                            onPressed: (){},
                        )
                      ]
                    ),
                  ),  //결제방법
                  Container(
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
                                        "won",
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
                                    " won",
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
                                    "0 won",
                                    style: productInCartPriceTextStyle()
                                ),

                              ]
                          ),
                        ],
                      )
                  ),  //금액정보
                  SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 54,
                    child: ElevatedButton(
                      child: Text( "주문하기",
                              style: buttonTextStyle()),
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
                  )   // 버튼
                ],
              ),
            )
        )
    );
  }


}
