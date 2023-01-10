import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ztz_app/components/main_page_components/todays_recommend_component.dart';
import 'package:ztz_app/pages/product/product_list_page.dart';
import 'package:ztz_app/utility/colors.dart';

import '../../pages/tour/foundry_page.dart';
import '../../utility/text_styles.dart';
import 'main_foundry_list_component.dart';


class MainComponent extends StatefulWidget {
  const MainComponent({Key?key}) : super (key: key);

  @override
  _MainComponent createState() =>_MainComponent();
}

class _MainComponent extends State<MainComponent>{
  static final signInStorage = new FlutterSecureStorage();

  var subMenuList = [
  {'title': "전통주", 'image': "assets/images/banner/submenu1.png", 'page': ProductListPage( drinkItemIndex: 0)},
  {'title': "이달의 술", 'image': "assets/images/banner/submenu2.png", 'page': ProductListPage( drinkItemIndex: 0)},
  {'title': "양조장", 'image': "assets/images/banner/submenu3.png", 'page': FoundryPage()},
  {'title': "베스트", 'image': "assets/images/banner/submenu4.png", 'page': ProductListPage( drinkItemIndex: 0)},
  {'title': "좋아요", 'image': "assets/images/banner/submenu5.png", 'page': ProductListPage( drinkItemIndex: 0)},
  ];

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          subMenuIcon(),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top:20 , bottom: 12,left: 3),
            child: Text("👍 오늘의 추천 ZTZ",style: productTitleTextStyle(),textAlign: TextAlign.left,),
          ),
          ToDaysRecommendComponent(),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top:30 , bottom: 12,left: 3),
            child: Text("🏫 TOUR + EXPERIENCE", style: productTitleTextStyle(),textAlign: TextAlign.left,),
          ),
          MainFoundryListComponent(),
        ],
      ),
    );
  }

  Widget subMenuIcon(){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child:
        Row(
          children: [
            for (int i = 0; i < subMenuList.length; i++)
            Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 5, right:5),
                    decoration: BoxDecoration(
                        color: ColorStyle.termGray,
                        borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: [
                        IconButton(
                          icon: Image.asset(subMenuList[i]['image'].toString()),
                          iconSize: 50,
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => subMenuList[i]['page'] as Widget ));
                          },
                        ),
                      ],
                    )
                ),
                SizedBox(height: 7),
                Text(subMenuList[i]['title'].toString() , style: TextStyle( fontWeight: FontWeight.w700 , fontSize: 15)),
              ],
            ),
          ],
        ),
    );
  }
}