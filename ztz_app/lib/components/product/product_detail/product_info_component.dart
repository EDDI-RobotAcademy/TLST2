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

  late var productImagesName;

  @override
  void initState() {
    productImagesName = ProductInfo.productImagesName;
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
            child : Text("์ํ์ ๋ณด" , style: lageBlackTextStyle(),),
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
                      child: Text("๐ฆ ํฌ์ฅํ์"),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 50),
                      child: Text("๋์ฅ (์ข์ดํฌ์ฅ)"),
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
                      child: Text("โ ํ๋งค ๋จ์"),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 50),
                      child: Text("1๋ณ"),
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
                      child: Text("โ ์๋ด์ฌํญ"),
                    ),
                    Container(
                      width: size.width - (size.width/3),
                      padding: EdgeInsets.only(left: 50),
                      child: Text("์์ฝ์ฌ์ ๋ฏผ๊ฐํ ๋ถ์ด๋ ์์ฐ๋ถ์ ์ญ์ทจ๋ ๊ถํ์ง ์์ต๋๋ค."),
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
                      child: Text("๐ถ ์ค๋/์ฉ๋"),
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
                      child: Text("๐ ์ ํต๊ธฐํ\n     (์๋น๊ธฐํ)"),
                    ),
                    Container(
                      width: size.width - (size.width/3),
                      padding: EdgeInsets.only(left: 45),
                      child: Text("์๋ น์ผ ํฌํจ ์ต์95์ผ์ด์ ๋จ์ ์ ํ์ ๋ณด๋ด ๋๋ฆฝ๋๋ค."),
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
                  child: Text("๐ซ", style: TextStyle(fontSize: 25),)
                ),
                Container(
                    width: 260,
                    padding: EdgeInsets.only(left: 10),
                    child: Text("๋ฏธ์ฑ๋์๋ ๊ตฌ๋งคํ  ์ ์์ผ๋ฉฐ, ๊ตฌ๋งค๋ฅผ ์ํด "
                        "๋ง 19์ธ ์ด์ ์ฑ์ธ์ธ์ฆ์ด ํ์ํฉ๋๋ค",style: TextStyle(fontFamily: "NanumSquareNeo-eHv"),)
                ),
              ],
            ),
          ),
          SizedBox(height: 30,),
          Text(ProductInfo.description),
            for(int i= 0; i< productImagesName.length ; i++)
            Image(image: AssetImage("assets/images/uploadImg/${productImagesName[i]}"),)


        ],
      ),
    );
  }
}