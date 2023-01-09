import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utility/colors.dart';
import '../../../utility/text_styles.dart';

class OrderListAppbar extends StatefulWidget implements PreferredSizeWidget {
  OrderListAppbar({Key? key, required this.controller}) : super(key: key);

  final TabController controller;
  @override
  State<OrderListAppbar> createState() => _OrderListAppbar();

  @override
  Size get preferredSize => Size.fromHeight(100);
}

class _OrderListAppbar extends State<OrderListAppbar>  with TickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          )),
      elevation: 0,
      backgroundColor: Colors.white,
      title: Text(
        "주문 내역",
        style: xMediumBlackTextStyle(),
      ),
      centerTitle: true,
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.shopping_cart_outlined,
              color: Colors.black,
            ))
      ],
      bottom: TabBar(
          controller: widget.controller,
          labelPadding: EdgeInsets.all(3),
          indicatorColor: Colors.white,
          isScrollable: true,
          labelColor: ColorStyle.mainColor,
          unselectedLabelColor: ColorStyle.textGray,
          tabs: <Tab>[
            Tab(
              child: Container(
                height: 37,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                        color: widget.controller.index == 0
                            ? ColorStyle.mainColor
                            : ColorStyle.textGray,
                        width: 1)),
                child: Align(
                  alignment: Alignment.center,
                  child: Text("전체"),
                ),
              ),
            ),
            Tab(
              child: Container(
                height: 37,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                        color: widget.controller.index == 1
                            ? ColorStyle.mainColor
                            : ColorStyle.textGray,
                        width: 1)),
                child: Align(
                  alignment: Alignment.center,
                  child: Text("3개월"),
                ),
              ),
            ),
            Tab(
              child: Container(
                height: 37,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                        color: widget.controller.index == 2
                            ? ColorStyle.mainColor
                            : ColorStyle.textGray,
                        width: 1)),
                child: Align(
                  alignment: Alignment.center,
                  child: Text("6개월"),
                ),
              ),
            ),
            Tab(
              child: Container(
                height: 37,
                width: 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                        color: widget.controller.index == 3
                            ? ColorStyle.mainColor
                            : ColorStyle.textGray,
                        width: 1)),
                child: Align(
                  alignment: Alignment.center,
                  child: Text("1년"),
                ),
              ),
            ),
          ]),
    );
  }
}
