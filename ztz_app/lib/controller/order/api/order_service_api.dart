import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ztz_app/controller/order/cart_controller.dart';



class OrderService {
  static const String httpUri = '192.168.200.175:7777';

  static fetchItems(String token) async {
    var response = await http.get(
      Uri.http(httpUri, '/ztz/order/myCart',),
      headers: {
        "Token": token,
        "Content-Type": "application/json"
      },
    );

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(utf8.decode(response.bodyBytes));
      CartController.reactiveCartList.clear();
      CartController.reactiveCartList.value = jsonData;
    }
  }

  static requestDeleteItem(int itemNo, token) async {

    try{
      var reqChangeStatus = await http.delete(
        Uri.http(httpUri, '/ztz/order/$itemNo'),
        headers: {
          "Token": token,
          "Content-Type": "application/json"
        },
      );

      if (reqChangeStatus.statusCode == 200) {
        var jsonData = jsonDecode(utf8.decode(reqChangeStatus.bodyBytes));
        print("통신 delete res : " + jsonData.toString());
        return jsonData;
      }

    }catch (e){
      print(e.toString());
    }
  }
  static requestChangeItemInfo(int itemNo, int count, int totalPrice) async {

    var data = {'itemNo': itemNo, 'count': count, 'selectedProductAmount': totalPrice };
    var body = json.encode(data);

    var req = await http.post(
      Uri.http(httpUri, '/ztz/order/testChange'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (req.statusCode == 200) {
      var jsonData = jsonDecode(utf8.decode(req.bodyBytes));
      return jsonData;
    }

  }
  static requestSelectItems(List itemsNoList) async {

    var data = {'selection': itemsNoList };
    var body = json.encode(data);

    var req = await http.post(
      Uri.http(httpUri, '/ztz/order/select'),
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (req.statusCode == 200) {
      var jsonData = jsonDecode(utf8.decode(req.bodyBytes));
      CartController.totalAmount.value = 0;
      CartController.totalAmount.value = jsonData;
      return jsonData;
    }

  }
}