import 'package:flutter/material.dart';

import '../../controller/order/order_controller.dart';
import '../../utility/text_styles.dart';

class MessageSelectBox extends StatefulWidget {
  const MessageSelectBox({Key? key}) : super(key: key);

  @override
  State<MessageSelectBox> createState() => _MessageSelectBoxState();
}

class _MessageSelectBoxState extends State<MessageSelectBox> {
  TextEditingController categoryController = TextEditingController();
  var selectedMessage = '';

  void showModal(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0)),
        ),
        context: context,
        builder: (context) {
          return Container(
              padding: EdgeInsets.all(8),
              height: 350,
              alignment: Alignment.center,
              child: ListView.builder(
                  itemCount: OrderController.deliveryMessage.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(OrderController.deliveryMessage[index]),
                      onTap: () {
                        setState(() {
                          selectedMessage = OrderController.deliveryMessage[index];
                          categoryController.text = selectedMessage;
                        });
                        Navigator.of(context).pop();
                      },
                    );
                  }));
        });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("배송 메시지", style: productInCartPriceTextStyle()),
            SizedBox(height: 15),
            TextFormField(
              style: smallOrderTextStyle(),
              readOnly: true,
              controller: categoryController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide:BorderSide(color: Colors.black26, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                  ),
                  suffixIcon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                  hintText: "유형을 선택해주세요"),
              onTap: () {
                showModal(context);
              },
            ),
            SizedBox(height: 20)
          ],
        )
    );
  }


}
