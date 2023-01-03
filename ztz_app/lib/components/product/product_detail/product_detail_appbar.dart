import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ztz_app/utility/colors.dart';

import '../../../controller/product/product_infos/product_info.dart';
import '../../../utility/text_styles.dart';

class ProductDetailAppbar extends StatelessWidget implements PreferredSizeWidget{
  ProductDetailAppbar({Key?key, required this.reviewCnt , required this.productName}) :super(key:key);

  final int reviewCnt;
  final String productName;
  final numberFormat = NumberFormat('###,###,###,###');
  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(90);

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 1,
        actions: [
        Padding(
          padding: const EdgeInsets.only(top:6),
          child: IconButton(onPressed: (){
            //장바구니 라우터 연결
            }, icon: Icon(Icons.shopping_cart_outlined,color: Colors.black,)),
        )
      ],
      leading: InkWell(
        onTap: (){
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 13,bottom: 10),
          child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.black,),
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      title: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(ProductInfo.productName,style: xMediumBlackTextStyle(),),
      ),
      bottom: TabBar(
          indicatorColor: ColorStyle.mainColor,
          indicatorSize : TabBarIndicatorSize.label,
          labelColor: ColorStyle.mainColor,
          unselectedLabelColor: Colors.grey,
          tabs: <Tab>[
            const Tab(
              child: Text("상품 설명",),
            ),
            Tab(
              child: Text("리뷰 " + numberFormat.format(reviewCnt)),
            ),
          ]
      )
    );
  }

}