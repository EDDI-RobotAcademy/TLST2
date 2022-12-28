import 'package:flutter/material.dart';

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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border:Border.all(
            width:1,
            color: Colors.black
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(3)
          )
        ),
        width: 160,
        padding: const EdgeInsets.all(3),
        margin: const EdgeInsets.all(3),
        child: Column(
          children: [
            const SizedBox(
              width: double.infinity,
              child: Image(image: AssetImage("assets/images/item1.jpg")),
            ),
            Text("$brand" , style: smallGrayTextStyle()),
            Text("$title" , style: productTextStyle()),
            Text("$price won" , style: productTextStyle()),
          ],
        ),
      ),
    );
  }
}