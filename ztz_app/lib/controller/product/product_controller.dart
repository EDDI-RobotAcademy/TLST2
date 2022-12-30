import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ztz_app/controller/product/product_infos/product_info.dart';

class ProductController extends GetxController{
  static const httpUri = '192.168.0.8:7777';
  requestAllProductToSpring(keyword) async{
    var data = {'keyword' : keyword};
    var body = json.encode(data);
    try{
      var requestProductListResponse = await http.post(
        Uri.http(httpUri,'ztz/products/list'),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      debugPrint(requestProductListResponse.statusCode.toString());
      if(requestProductListResponse.statusCode == 200){
        debugPrint("결과 : " + utf8.decode(requestProductListResponse.bodyBytes).toString());
        ProductInfo.productList = jsonDecode(utf8.decode(requestProductListResponse.bodyBytes));
      }
    }catch(e){
      debugPrint("오류 발생 " + e.toString());
    }
  }

  requestProductDetailToSpring(productNo) async {
    try{
      var requestProductResponse = await http.post(
        Uri.http(httpUri, 'ztz/products/list/product/$productNo'),
        headers: {"Content-Type": "application/json"},
      );
      if(requestProductResponse.statusCode == 200){
        debugPrint("결과 : " + utf8.decode(requestProductResponse.bodyBytes).toString());
        ProductInfo.product = jsonDecode(utf8.decode(requestProductResponse.bodyBytes));
      }else{
        debugPrint("통신 오류 " + requestProductResponse.statusCode.toString());
      }
    }catch(e){
      debugPrint("오류 발생 " + e.toString());
    }
  }
}