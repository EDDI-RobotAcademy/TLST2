import 'package:flutter/material.dart';
import 'package:ztz_app/pages/account/signup_page.dart';

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
            // 이달의 술 페이지로 이동
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
            // 양조장 페이지로 이동
          },
        ),
      ],
    );
  }

  // 전통주 서브 카테고리
  Widget _drinksSubCategory() {
    return Column(
      children: [
        //추후 각각의 페이지 추가 예정
        _drinkItems('전체보기', SignUpPage()),
        _drinkItems('소주증류주', SignUpPage()),
        _drinkItems('리큐르', SignUpPage()),
        _drinkItems('막걸리', SignUpPage()),
        _drinkItems('약주청주', SignUpPage()),
        _drinkItems('과실주', SignUpPage()),
        _drinkItems('기타주류', SignUpPage()),
      ],
    );
  }

  // 서브타이틀, 위젯 이름
  ListTile _drinkItems(String title, Widget linkedPage) {
    return ListTile(
        title: Text(title),
        tileColor: Colors.grey[100],
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => linkedPage));
        });
  }
}
