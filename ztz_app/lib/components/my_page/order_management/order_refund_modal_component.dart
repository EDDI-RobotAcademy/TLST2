import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ztz_app/utility/button_style.dart';

import '../../../controller/order/order_controller.dart';
import '../../../controller/order/order_infos/order_info.dart';
import '../../../pages/home_page.dart';
import '../../../pages/my_page/order_management/order_detail_page.dart';
import '../../../utility/text_field_decoration.dart';
import '../../../utility/text_styles.dart';

class OrderRefundModalComponent extends StatefulWidget{
  const OrderRefundModalComponent({Key?key , required this.refundPaymentId , required this.paymentState}) : super (key:key);

  final int refundPaymentId;
  final String paymentState;
  @override
  State<OrderRefundModalComponent> createState() => _OrderRefundModalComponent();
}

class _OrderRefundModalComponent extends State<OrderRefundModalComponent>{

  List<String> dropdownList = ['단순 변심', '다른 제품 구매', '더 나은 제품 발견' , '제품 파손' , '유통기한 초과', '제품 변질' , '기타'];
  String selectedDropdown = '단순 변심';

  late int refundPaymentId;
  late TextEditingController etcController = TextEditingController();
  FocusNode etcFocus = FocusNode();

  @override
  void initState(){
    super.initState();
    refundPaymentId = widget.refundPaymentId;
  }

  void requestRefund() async {
    await OrderController().requestRefundOrder(refundPaymentId,selectedDropdown == '기타'?etcController.text : selectedDropdown);
    debugPrint("요청 결과 = " + OrderInfo.refundResult.toString());
    if(OrderInfo.refundResult == true.obs){
      showSuccessRefund();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(25),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("환불 사유 선택" , style: MediumBlackTextStyle(),),
                SizedBox(width: size.width/2.8,),
                DropdownButton(
                  style: MediumBlackTextStyle(),
                  underline : Container(),
                  value: selectedDropdown,
                  items: dropdownList.map((String item) {
                    return DropdownMenuItem<String>(
                      child: Text('$item'),
                      value: item,
                    );
                  }).toList(),
                  onChanged: (dynamic value) {
                    setState(() {
                      selectedDropdown = value;
                    });
                  },
                ),
              ],
            ),
            selectedDropdown == '기타'? TextFormField(
              controller: etcController,
              decoration: textFieldDecoration("기타 📑"),
              keyboardType : TextInputType.text,
              focusNode: etcFocus,

            ): const SizedBox(),
            ElevatedButton(
              style: defaultElevatedButtonStyle(size.width-30, 30),
                onPressed: (){
                  requestRefund();
              },
            child: Text("환불하기"))
          ],
        ),
      ),
    );
  }

  void showSuccessRefund(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("환불 처리 완료"),
          content: new Text("환불이 정상적으로 처리 되었습니다!\n더 나은 서비스로 보답 하겠습니다\n갑사합니다!"),
          actions: <Widget>[
            FlatButton(
              child: const Text("확인"),
              onPressed: () {
                OrderInfo.refundResult = false.obs;
                Navigator.pushAndRemoveUntil(context,  MaterialPageRoute(builder: (context) => HomePage()), (route) => false);
                // Replacement(context, MaterialPageRoute(builder: (context) => HomePage() ));
              },
            ),
          ],
        );
      },
    );
  }
}