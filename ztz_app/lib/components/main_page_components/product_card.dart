import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../utility/text_styles.dart';

class ProductCard extends StatelessWidget{
  const ProductCard({Key? key,
    required this.image,
    required this.title,
    required this.brand,
    required this.onTap,
    required this.price,}) : super(key: key);

  final String image, title, brand;
  final int price;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    var numberFormat = NumberFormat('###,###,###,###');
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(3),
        margin: const EdgeInsets.all(3),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: Image(image: AssetImage("assets/images/uploadImg/${image}")),
            ),
            SizedBox(height: 3,),
            Text("$brand" , style: smallGrayTextStyle()),
            SizedBox(height: 3,),
            Text("$title" , style: productTextStyle()),
            SizedBox(height: 5,),
            Text(numberFormat.format(price)+"원" , style: xMediumBlackTextStyle()),
          ],
        ),
      ),
    );
  }
}