import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ztz_app/pages/product/best/best_list_page.dart';
import 'package:ztz_app/pages/product/month/month_list_page.dart';
import 'package:ztz_app/pages/tour/foundry_page.dart';

import '../../pages/product/product_list_page.dart';

class CategoryForm extends StatefulWidget {
  const CategoryForm({Key? key}) : super(key: key);

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: _buildCategory());
  }

  Widget _buildCategory() {
    return Column(
      children: <Widget>[
        ExpansionTile(
          title: Row(
            children: [
              Icon(Icons.liquor),
              SizedBox(width: 15),
              Text('전통주'),
            ],
          ),
          iconColor: Colors.grey,
          textColor: Color(0xff205C37),
          children: <Widget>[_drinksSubCategory()],
        ),
        ListTile(
          title: Row(
            children: [
              Icon(Icons.sell_outlined),
              SizedBox(width: 15),
              Text('이달의 술'),
            ],
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const MonthListPage()));
          },
        ),
        ListTile(
          title: Row(
            children: [
              Icon(Icons.star),
              SizedBox(width: 15),
              Text('베스트'),
            ],
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const BestListPage()));
          },
        ),
        ListTile(
          title: Row(
            children: [
              Icon(Icons.favorite_border),
              SizedBox(width: 15),
              Text('좋아요'),
            ],
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            // 좋아요 페이지로 이동
          },
        ),
        ListTile(
          title: Row(
            children: [
              Icon(Icons.storefront),
              SizedBox(width: 15),
              Text('양조장'),
            ],
          ),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FoundryPage())
            );
          },
        ),
      ],
    );
  }

  // 전통주 서브 카테고리
  Widget _drinksSubCategory() {
    return Column(
      children: [
        _drinkItems(
            '전체보기',
            ProductListPage(
              drinkItemIndex: 0,
            )),
        _drinkItems(
            '소주증류주',
            ProductListPage(
              drinkItemIndex: 1,
            )),
        _drinkItems(
            '리큐르',
            ProductListPage(
              drinkItemIndex: 2,
            )),
        _drinkItems(
            '막걸리',
            ProductListPage(
              drinkItemIndex: 3,
            )),
        _drinkItems(
            '소주증류주',
            ProductListPage(
              drinkItemIndex: 4,
            )),
        _drinkItems(
            '리큐르',
            ProductListPage(
              drinkItemIndex: 5,
            )),
        _drinkItems(
            '막걸리',
            ProductListPage(
              drinkItemIndex: 6,
            )),
      ],
    );
  }

  // 서브타이틀, 위젯 이름
  ListTile _drinkItems(String title, Widget linkedPage) {
    return ListTile(
        title: Text(title),
        tileColor: Colors.grey[100],
        onTap: () {
          Get.to(
              linkedPage, //next page class
              duration: Duration(milliseconds: 500), //duration of transitions, default 1 sec
              transition: Transition.rightToLeft,//transition effect
              popGesture : true // 슬라이드로 뒤로가기
          );
        });
  }
}
