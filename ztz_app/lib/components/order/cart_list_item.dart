import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ztz_app/components/order/cart_list_builder.dart';
import 'package:ztz_app/controller/order/cart_controller.dart';
import '../../utility/colors.dart';

import '../../utility/text_styles.dart';


class CartListItem extends StatefulWidget {

  const CartListItem({
    Key? key,
    required this.index,
    required this.itemNo,
  }) : super(key: key);

  final int index, itemNo;

  @override
  State<CartListItem> createState() => _CartListItemState();
}

class _CartListItemState extends State<CartListItem> {
  late int index;
  late int itemNo;
  bool _isChecked = false;


  @override
  void initState() {
    super.initState();
    index = widget.index;
    itemNo = widget.itemNo;
    CartController.checkStatusMap.addAll({
      CartController.reactiveCartList[index]['itemNo'].toString() : false
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: const Color(0xffd5e3d8),
            width: 1,
          ),
        ),

        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  itemCheckBox(index),
                  IconButton(
                      padding: EdgeInsets.all(3),
                      icon: Icon(Icons.close, color: Colors.black26),
                      onPressed: (){
                        setState((){
                          CartController().delete(index, itemNo, "f63c1741-bbd2-4aed-8e11-4a961c00a551");
                          print("삭제요청 after" + itemNo.toString() );
                        });
                      }
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 100,
                      height: 120,
                      margin: EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xffd5e3d8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Image.asset("assets/images/item1.jpg", fit: BoxFit.fitHeight),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(height: 8),
                        Text(
                          CartController.reactiveCartList[index]['product']['name'],
                          style: productInCartNameTextStyle(),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        SizedBox(height: 10),
                       Text(
                          "${CartController.reactiveCartList[index]['selectedProductAmount']} won",
                          style: productInCartPriceTextStyle()
                       ),
                        SizedBox(height: 30),
                        amountOfProduct(index)
                      ],
                    )
                  ],
                ),
              )
            ]
        )
    );
  }

  Widget amountOfProduct(int index){
    return Container(
      width: 150,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black26),
          borderRadius: BorderRadius.circular(8)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: CartController.reactiveCartList[index]['count'] == 0 ?
            Icon(Icons.remove,color: ColorStyle.textGray,):Icon(Icons.remove),
            onTap: (){
              setState((){
                cancelCheckBox();
                CartController().decrement(index);
              });
            },
          ),
          SizedBox(
              width: 30,
              child: Text( '${CartController.reactiveCartList[index]['count']}' ,textAlign: TextAlign.center)
          ),
          InkWell(
              child: Icon(Icons.add),
              onTap: (){
                setState((){
                  cancelCheckBox();
                  CartController().increment(index);
                });
              }
          ),
        ],
      ),
    );
  }
  Widget itemCheckBox(int index) {
    return Checkbox(
      value: _isChecked,
      onChanged: (bool? value) {
        setState(() {
          _isChecked = value!;
          var keyword = CartController.reactiveCartList[index]['itemNo'].toString();

          if(CartController.checkStatusMap.containsKey(keyword)) {
            CartController.checkStatusMap.update( keyword , (value) => _isChecked);
          } else {
            CartController.checkStatusMap.addAll({ keyword : _isChecked});
          }

          CartController().select(index, keyword);
          // constantMap[2] = 'Helium'; // Uncommenting this causes an error
          // assert(gifts['first'] == 'partridge');
        });
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      checkColor: Colors.white,
      activeColor: Color(0xff82c299),
      materialTapTargetSize: MaterialTapTargetSize.padded,
    );
  }

  cancelCheckBox() {
    CartController.checkStatusMap.forEach((key, value) {
      value = false;
    });
    _isChecked = false;
    CartController.selectedProduct.clear();
  }
}


