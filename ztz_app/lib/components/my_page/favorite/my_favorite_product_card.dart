import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../../../controller/account/sign_up_infos/account_state.dart';
import '../../../controller/favorite/favorite_controller.dart';
import '../../../controller/order/cart_controller.dart';
import '../../../pages/my_page/favorite_product/my_favorite_product_page.dart';
import '../../../pages/order/cart.dart';
import '../../../utility/colors.dart';
import '../../../utility/text_styles.dart';

  class MyFavoriteProductCard extends StatefulWidget{
  const MyFavoriteProductCard({Key? key,
  //required this.변수명 -> ProductCard 위젯을 호출 시 사용하기 위한 파라미터. 해당 파라미터값 넣어서 호출해야함
  required this.productNo,
  required this.image,
  required this.title,
  required this.brand,
  required this.onTap,
  required this.price,
  required this.monthCheck}) : super(key: key);

  @override
  State<MyFavoriteProductCard> createState() => _MyFavoriteProductCard();


  final String image, title, brand;
  final int productNo,price;
  final VoidCallback onTap;
  final bool monthCheck;
}
  class _MyFavoriteProductCard extends State<MyFavoriteProductCard> {

    @override
    void initState() {
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    var numberFormat = NumberFormat('###,###,###,###');
    Size size = MediaQuery
        .of(context)
        .size;
    return GestureDetector(
        onTap: widget.onTap,
        child: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: const Color(0xffd5e3d8),
                width: 1,
              ),
            ),

            child: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 110,
                    height: 130,
                    padding: EdgeInsets.only(top: 8),
                    margin: EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset("assets/images/uploadImg/${widget.image}",
                        fit: BoxFit.fitHeight),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(height: 8),
                      Text(
                        "${widget.brand}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "${widget.title}",
                        style: TextStyle(fontSize: 17),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          widget.monthCheck ? Text(" 10% ",
                              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 15,))
                              : Text(""),
                          Text(numberFormat.format(widget.price) + "원",
                              style: xMediumBlackTextStyle()),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xff205C37),
                                ),
                                onPressed:() async{
                                  CartController().reqAddItem(widget.productNo, 1);
                                  Get.to(() => Cart());
                                  },

                                child: const Text("장바구니")),
                          ),

                          SizedBox(width: 15),
                          Container(
                            width: 100,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  side: BorderSide(width:1, color:ColorStyle.mainColor)
                                ),
                                onPressed:() async{
                                  await FavoriteController().requestFavoriteStatusToSpring(
                                      AccountState.memberInfo['id'],
                                      widget.productNo,
                                      "favoriteLike");
                                  debugPrint("좋아요 해제한 상품번호:" + widget.productNo.toString());
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => MyFavoriteProductPage()),
                                  ).then((value) => setState(() {}));
                                },
                                child: const Text("찜 해제",  style: TextStyle( color: ColorStyle.mainColor),)),
                          ),

                        ],
                      ),
                    ],
                  )
                ],
              ),
            )

        )
    );
  }
}
