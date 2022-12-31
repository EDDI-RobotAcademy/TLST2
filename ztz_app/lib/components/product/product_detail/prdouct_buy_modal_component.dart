import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ztz_app/utility/colors.dart';

import '../../../controller/product/product_infos/product_info.dart';
import '../../../utility/button_style.dart';
import '../../../utility/text_styles.dart';

class ProductBuyModalComponent extends StatefulWidget{
  const ProductBuyModalComponent({Key? key}) : super(key: key);

  @override
  State<ProductBuyModalComponent> createState() => _ProductBuyModalComponent();
}

class _ProductBuyModalComponent extends State<ProductBuyModalComponent>{

  late final String image, productName , subTitle;
  late final int productPrice;
  var numberFormat = NumberFormat('###,###,###,###');

  int selectedAmount = 1;
  @override
  initState(){
    super.initState();
    image = ProductInfo.thumbnailFileName;
    productName = ProductInfo.productName;
    subTitle = ProductInfo.subTitle;
    productPrice = ProductInfo.productPrice;
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 20
            ),
            SizedBox(
              width: 40,
              child: Divider(height: 3, thickness: 3,color: Colors.grey),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, left: 20),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black,width: 0.1)
                    ),
                    width: 70,
                    child: Image(image: AssetImage("assets/images/uploadImg/${image}"),),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10,bottom: 5),
                          width: 100,
                          child: Text(productName,textAlign: TextAlign.left,style: defaultTextStyle(),),
                        ),
                        Text(subTitle,style: mediumGrayTextStyle(),),
                        Container(
                            padding: EdgeInsets.only(top: 10,bottom: 10),
                            width: 100,
                            child: Text(ProductInfo.taste.toString(),textAlign: TextAlign.left,style: xSmallPinkTextStyle(),)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(thickness: 1),
            Container(
              padding: EdgeInsets.only(left: 15),
              width: size.width,
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 10,bottom: 10),
                      width:size.width ,
                      child: Row(
                        children: [
                          Text("🚛 배송비",textAlign: TextAlign.left,style: MediumBlackTextStyle()),
                          SizedBox(width: size.width-(size.width/1.7),),
                          Text("ztz는 모든 배송비가 무료!",textAlign: TextAlign.right,style: MediumBlackTextStyle())
                        ],
                      )
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 10,bottom: 10),
                      width:size.width ,
                      child: Row(
                        children: [
                          Text("🎁 상품가격",textAlign: TextAlign.left,style: MediumBlackTextStyle()),
                          SizedBox(width: size.width-(size.width/2.4),),
                          Text(numberFormat.format(productPrice)+"원",textAlign: TextAlign.right,style: MediumBlackTextStyle())
                        ],
                      )
                  ),
                  Container(
                      padding: EdgeInsets.only(top: 10,bottom: 10),
                      width:size.width ,
                      child: Row(
                        children: [
                          Container(
                              padding: EdgeInsets.only(right: size.width-(size.width/2.3)),
                              child: Text("✔수량",textAlign: TextAlign.left,style: MediumBlackTextStyle(),)
                          ),
                          amountOfProduct()
                        ],
                      )),
                ],
              ),
            ),
            Divider(thickness: 1),
            Container(
                padding: EdgeInsets.only(left: 15,top: 5,bottom: 5),
                width: size.width,
                child: Row(
                  children: [
                    Text("총 결제금액" ,style: lageBlackTextStyle(),),
                    Container(
                        padding: EdgeInsets.only(left: size.width-(size.width/1.8)),
                        child: Text(numberFormat.format(productPrice * selectedAmount) +"원",style: lageBlackTextStyle()
                        )
                    ),
                  ],
                )
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Row(
                children: [
                  ElevatedButton(onPressed: (){}, child: Text("장바구니",style: xMediumWhiteTextStyle(),),style: defaultElevatedButtonStyle((size.width/2)-10,50),),
                  SizedBox(width: 10,),
                  ElevatedButton(onPressed: (){}, child: Text("결제하기",style: xMediumWhiteTextStyle()),style: defaultElevatedButtonStyle((size.width/2)-10,50)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget amountOfProduct(){
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black54),
          borderRadius: BorderRadius.circular(4)
      ),
      child: Row(
        children: [
          InkWell(
            child: selectedAmount==0 ? Icon(Icons.remove,color: ColorStyle.textGray,):Icon(Icons.remove),
            onTap: (){
              if(selectedAmount!=0){
                setState((){
                  selectedAmount--;
                });
              }
            },
          ),
          SizedBox(
            width: 30,
            child: Text(selectedAmount.toString(),textAlign: TextAlign.center,),
          ),
          InkWell(
            child: Icon(Icons.add),
              onTap: (){
                setState((){
                  selectedAmount++;
                });
              }
          ),
        ],
      ),
    );
  }
}