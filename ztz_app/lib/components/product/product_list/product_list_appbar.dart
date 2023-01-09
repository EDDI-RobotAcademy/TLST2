import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ztz_app/utility/colors.dart';

import '../../../utility/text_styles.dart';

class ProductListAppbar extends StatelessWidget implements PreferredSizeWidget{
  ProductListAppbar({Key?key}) :super(key:key);

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
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          child: Text("상품 정보",style: xMediumBlackTextStyle(),),
        ),
        bottom: const TabBar(
            isScrollable : true,
            indicatorColor: ColorStyle.mainColor,
            indicatorSize : TabBarIndicatorSize.label,
            labelColor: ColorStyle.mainColor,
            unselectedLabelColor: Colors.grey,
            tabs: <Tab>[
              Tab(
                child: Text("전체보기",),
              ),
              Tab(
                child: Text("소주증류주"),
              ),
              Tab(
                child: Text("리큐르"),
              ),
              Tab(
                child: Text("막걸리"),
              ),
              Tab(
                child: Text("약주청주"),
              ),
              Tab(
                child: Text("과실주"),
              ),
              Tab(
                child: Text("기타주류"),
              ),
            ]
        )
    );
  }

}