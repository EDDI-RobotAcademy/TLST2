import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'favorite_infos/favorite_info.dart';

class FavoriteController extends GetxController{
  static const httpUri = '192.168.200.168:7777';

  requestFavoriteStatusToSpring(memberId, productNo, favoriteType) async{
    
    var data = {'memberId' : memberId, 'productNo' : productNo, 'favoriteType' : favoriteType};
    var body = json.encode(data);
    try{
      var requestFavoriteResponse = await http.post(
        Uri.http(httpUri,'ztz/products/favorite/changeFavoriteStatus'),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      debugPrint(requestFavoriteResponse.statusCode.toString());
      if(requestFavoriteResponse.statusCode == 200){
        debugPrint("좋아요 결과 : " + utf8.decode(requestFavoriteResponse.bodyBytes).toString());
        FavoriteInfo.favoriteStatus = jsonDecode(utf8.decode(requestFavoriteResponse.bodyBytes));
      }
    }catch(e){
      debugPrint("오류 발생 " + e.toString());
    }
  }

  requestMyFavoriteToSpring(token) async{

    var data = {'token' : token};
    var body = json.encode(data);
    try{
      var requestFavoriteResponse = await http.post(
        Uri.http(httpUri,'ztz/products/favorite/myFavorite'),
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      debugPrint(requestFavoriteResponse.statusCode.toString());
      if(requestFavoriteResponse.statusCode == 200){
        debugPrint("나의 찜 상품 : " + utf8.decode(requestFavoriteResponse.bodyBytes).toString());
        FavoriteInfo.myFavoriteList = jsonDecode(utf8.decode(requestFavoriteResponse.bodyBytes));
      }
    }catch(e){
      debugPrint("오류 발생 " + e.toString());
    }
  }
}