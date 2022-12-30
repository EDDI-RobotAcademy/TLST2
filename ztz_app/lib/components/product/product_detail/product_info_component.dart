import 'package:flutter/cupertino.dart';
import 'package:ztz_app/utility/colors.dart';

import '../../../controller/product/product_infos/product_info.dart';
import '../../../utility/text_styles.dart';

class ProductInfoComponent extends StatefulWidget{
  const ProductInfoComponent ({Key?key}) : super(key: key);

  @override
  _ProductInfoComponent createState() => _ProductInfoComponent();
}

class _ProductInfoComponent extends State<ProductInfoComponent>{


  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose(){
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.only(left:15),
            width:size.width,
            child : Text("상품정보" , style: lageBlackTextStyle(),),
          ),
          Container(
            padding: EdgeInsets.only(top: 15),
            width: size.width,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding : EdgeInsets.only(left: 15),
                      child: Text("📦 포장타입"),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 50),
                      child: Text("냉장 (종이포장)"),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15),
            width: size.width,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding : EdgeInsets.only(left: 15),
                      child: Text("✔ 판매 단위"),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 50),
                      child: Text("1병"),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15),
            width: size.width,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding : EdgeInsets.only(left: 15),
                      child: Text("✔ 안내사항"),
                    ),
                    Container(
                      width: size.width - (size.width/3),
                      padding: EdgeInsets.only(left: 50),
                      child: Text("알코올에 민감한 분이나 임산부의 섭취는 권하지 않습니다."),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15),
            width: size.width,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding : EdgeInsets.only(left: 15),
                      child: Text("🍶 중량/용량"),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 45),
                      child: Text("330mL"),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15),
            width: size.width,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      padding : EdgeInsets.only(left: 15),
                      child: Text("🕒 유통기한\n     (소비기한)"),
                    ),
                    Container(
                      width: size.width - (size.width/3),
                      padding: EdgeInsets.only(left: 45),
                      child: Text("수령일 포함 최소95일이상 남은 제품을 보내 드립니다."),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(10),
            color: ColorStyle.termGray,
            width: size.width,
            height: 70,
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 25),
                  child: Text("🚫", style: TextStyle(fontSize: 25),)
                ),
                Container(
                    width: 260,
                    padding: EdgeInsets.only(left: 10),
                    child: Text("미성년자는 구매할 수 없으며, 구매를 위해 "
                        "만 19세 이상 성인인증이 필요합니다",style: TextStyle(fontFamily: "NanumSquareNeo-eHv"),)
                ),
              ],
            ),
          ),
          SizedBox(height: 30,),
          Text(ProductInfo.description),
          Image(image: AssetImage("assets/images/hongju1.jpg"),)
        ],
      ),
    );
  }
}