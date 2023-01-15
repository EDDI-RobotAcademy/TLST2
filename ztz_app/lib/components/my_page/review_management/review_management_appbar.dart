import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utility/colors.dart';
import '../../../utility/text_styles.dart';

class ReviewManagementAppbar extends StatefulWidget implements PreferredSizeWidget{
  const ReviewManagementAppbar ({Key?key}) : super (key: key);

  @override
  Size get preferredSize => Size.fromHeight(90);

  @override
  State<ReviewManagementAppbar> createState() => _ReviewManagementAppbar();
}

class _ReviewManagementAppbar extends State<ReviewManagementAppbar>{
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
        child: Text("상품 리뷰",style: xMediumBlackTextStyle(),),
      ),
        bottom: const TabBar(
            indicatorColor: ColorStyle.mainColor,
            indicatorPadding: EdgeInsets.only(left: 5,right: 5),
            labelColor: ColorStyle.mainColor,
            unselectedLabelColor: Colors.grey,
            tabs: <Tab>[
              Tab(
                child: Text("작성 가능 후기",),
              ),
              Tab(
                child: Text("작성한 후기"),
              ),
            ]
        )
    );
  }
}