import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:ztz_app/controller/product/product_infos/product_info.dart';

class ProductController{
  static const httpUri = '192.168.0.8:7777';
  requestAllProductToSpring(keyword) async{
    var data = {'keyword' : keyword};
    try{
      var requestProductListResponse = await http.post(
        Uri.http(httpUri,'ztz/products/list/flutter' , data),
        headers: {"Content-Type": "application/json"},
      );

      debugPrint(requestProductListResponse.statusCode.toString());
      if(requestProductListResponse.statusCode == 200){

        if(keyword == ""){
          debugPrint("모든 상품 조회 결과 : " + utf8.decode(requestProductListResponse.bodyBytes).toString());
          ProductInfo.productList.clear();
          ProductInfo.productList = jsonDecode(utf8.decode(requestProductListResponse.bodyBytes));
        }else{
          debugPrint("검색 키워드 : " + keyword);
          debugPrint("검색 결과 : " + utf8.decode(requestProductListResponse.bodyBytes).toString());
          ProductInfo.searchedProductList.clear();
          ProductInfo.searchedProductList = jsonDecode(utf8.decode(requestProductListResponse.bodyBytes));
        }

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

  requestProductByAlcoholType(alcoholType) async {
    try{
      var requestProductResponse = await http.post(
        Uri.http(httpUri, 'ztz/products/alcoholList/flutter/$alcoholType'),
        headers: {"Content-Type": "application/json"},
      );
      if(requestProductResponse.statusCode == 200){
        debugPrint("알코올 타입으로 조회 결과 : " + utf8.decode(requestProductResponse.bodyBytes).toString());
        ProductInfo.productList.clear();
        ProductInfo.productList = jsonDecode(utf8.decode(requestProductResponse.bodyBytes));
      }else{
        debugPrint("통신 오류 " + requestProductResponse.statusCode.toString());
      }

    }catch(e){
      debugPrint("오류 발생 " + e.toString());
    }
  }

  requestProductByLocal(localName) async {
    try{
      var requestProductResponse = await http.get(
        Uri.http(httpUri, 'ztz/products/list/flutter/$localName'),
        headers: {"Content-Type": "application/json"},
      );
      if(requestProductResponse.statusCode == 200){
        debugPrint("지역 으로 요청 결과 : " + utf8.decode(requestProductResponse.bodyBytes).toString());
        ProductInfo.productList.clear();
        ProductInfo.productList = jsonDecode(utf8.decode(requestProductResponse.bodyBytes));
      }else{
        debugPrint("통신 오류 " + requestProductResponse.statusCode.toString());
      }
    }catch(e){
      debugPrint("오류 발생 " + e.toString());
    }
  }

  requestProductByLocalAndAlcoholType(alcoholType , localName) async {
    var data = {'alcoholType' : alcoholType , 'localName' : localName};
    var body = json.encode(data);
    try{
      var requestProductResponse = await http.post(
        Uri.http(httpUri, 'ztz/products/list/by-local-type/flutter'),
        headers: {"Content-Type": "application/json"},
        body: body
      );
      if(requestProductResponse.statusCode == 200){
        debugPrint("지역과 타입으로 요청 결과 : " + utf8.decode(requestProductResponse.bodyBytes).toString());
        ProductInfo.productList.clear();
        ProductInfo.productList = jsonDecode(utf8.decode(requestProductResponse.bodyBytes));
      }else{
        debugPrint("통신 오류 " + requestProductResponse.statusCode.toString());
      }
    }catch(e){
      debugPrint("오류 발생 " + e.toString());
    }
  }

  requestMonthProductFromSpring() async {
    try {
      var monthProductResponse = await http.get(
        Uri.http(httpUri, 'ztz/products/monthAlcohol/list'),
        headers: {"Content-Type": "application/json"},
      );
      if (monthProductResponse.statusCode == 200) {
        debugPrint("이달의 술 결과: " + utf8.decode(monthProductResponse.bodyBytes).toString());
        ProductInfo.productList.clear();
        ProductInfo.productList = jsonDecode(utf8.decode(monthProductResponse.bodyBytes));
      } else {
        debugPrint("이달의 술 통신 오류 " + monthProductResponse.statusCode.toString());
      }
    } catch(e) {
      debugPrint("이달의 술 오류 발생 " + e.toString());
    }
  }

  requestMonthProductByLocal(localName) async {
    try{
      var requestProductResponse = await http.get(
        Uri.http(httpUri, 'ztz/products/list/month/$localName'),
        headers: {"Content-Type": "application/json"},
      );
      if(requestProductResponse.statusCode == 200){
        debugPrint("이달의 술 지역 요청 결과 : " + utf8.decode(requestProductResponse.bodyBytes).toString());
        ProductInfo.productList.clear();
        ProductInfo.productList = jsonDecode(utf8.decode(requestProductResponse.bodyBytes));
      }else{
        debugPrint("이달의 술 지역 통신 오류 " + requestProductResponse.statusCode.toString());
      }
    }catch(e){
      debugPrint("이달의 술 지역 오류 발생 " + e.toString());
    }
  }
  requestRecommendProductFromSpring() async {
    try {
      var requestProductResponse = await http.post(
        Uri.http(httpUri, 'ztz/products/list/view/recommend'),
        headers: {"Content-Type": "application/json"},
      );
      if (requestProductResponse.statusCode == 200) {
        debugPrint("추천 상품 요청 결과 : " + utf8.decode(requestProductResponse.bodyBytes).toString());
        ProductInfo.recommendProductList.clear();
        ProductInfo.recommendProductList = jsonDecode(utf8.decode(requestProductResponse.bodyBytes));
      } else {
        debugPrint("추천 상품 통신 오류 " + requestProductResponse.statusCode.toString());
      }
    } catch(e) {
      debugPrint("추천 상품 오류 발생 " + e.toString());
    }

  }

  requestBestProductFromSpring() async {
    try {
      var requestProductResponse = await http.post(
        Uri.http(httpUri, 'ztz/products/list/view'),
        headers: {"Content-Type": "application/json"},
      );
      if (requestProductResponse.statusCode == 200) {
        debugPrint("베스트 상품 요청 결과 : " + utf8.decode(requestProductResponse.bodyBytes).toString());
        ProductInfo.bestProductList.clear();
        ProductInfo.bestProductList = jsonDecode(utf8.decode(requestProductResponse.bodyBytes));
      } else {
        debugPrint("베스트 상품 통신 오류 " + requestProductResponse.statusCode.toString());
      }
    } catch(e) {
      debugPrint("베스트 상품 오류 발생 " + e.toString());
    }
  }

  requestBestProductByAlcoholType(alcoholType) async {
    try{
      var requestProductResponse = await http.post(
        Uri.http(httpUri, 'ztz/products/alcoholList/best/$alcoholType'),
        headers: {"Content-Type": "application/json"},
      );
      if(requestProductResponse.statusCode == 200){
        debugPrint("베스트 알코올 타입 결과 : " + utf8.decode(requestProductResponse.bodyBytes).toString());
        ProductInfo.bestProductList.clear();
        ProductInfo.bestProductList = jsonDecode(utf8.decode(requestProductResponse.bodyBytes));
      }else{
        debugPrint("베스트 알코올 타입 통신 오류 " + requestProductResponse.statusCode.toString());
      }

    }catch(e){
      debugPrint("베스트 알코올 타입 오류 발생 " + e.toString());
    }
  }

  requestBestProductByLocal(localName) async {
    try{
      var requestProductResponse = await http.get(
        Uri.http(httpUri, 'ztz/products/list/best/$localName'),
        headers: {"Content-Type": "application/json"},
      );
      if(requestProductResponse.statusCode == 200){
        debugPrint("베스트 지역 요청 결과 : " + utf8.decode(requestProductResponse.bodyBytes).toString());
        ProductInfo.bestProductList.clear();
        ProductInfo.bestProductList = jsonDecode(utf8.decode(requestProductResponse.bodyBytes));
      }else{
        debugPrint("베스트 지역 통신 오류 " + requestProductResponse.statusCode.toString());
      }
    }catch(e){
      debugPrint("베스트 지역 오류 발생 " + e.toString());
    }
  }

  requestBestProductByLocalAndAlcoholType(alcoholType , localName) async {
    var data = {'alcoholType' : alcoholType , 'localName' : localName};
    var body = json.encode(data);
    try{
      var requestProductResponse = await http.post(
          Uri.http(httpUri, 'ztz/products/list/best/by-local-type'),
          headers: {"Content-Type": "application/json"},
          body: body
      );
      if(requestProductResponse.statusCode == 200){
        debugPrint("베스트 지역과 타입 결과 : " + utf8.decode(requestProductResponse.bodyBytes).toString());
        ProductInfo.bestProductList.clear();
        ProductInfo.bestProductList = jsonDecode(utf8.decode(requestProductResponse.bodyBytes));
      }else{
        debugPrint("베스트 지역과 타입 통신 오류 " + requestProductResponse.statusCode.toString());
      }
    }catch(e){
      debugPrint("베스트 지역과 타입 오류 발생 " + e.toString());
    }
  }

  requestFavoriteProductFromSpring() async {
    try {
      var requestProductResponse = await http.post(
        Uri.http(httpUri, 'ztz/products/list/favorite'),
        headers: {"Content-Type": "application/json"},
      );
      if (requestProductResponse.statusCode == 200) {
        debugPrint("좋아요 상품 요청 결과 : " + utf8.decode(requestProductResponse.bodyBytes).toString());
        ProductInfo.favoriteProductList.clear();
        ProductInfo.favoriteProductList = jsonDecode(utf8.decode(requestProductResponse.bodyBytes));
      } else {
        debugPrint("좋아요 상품 통신 오류 " + requestProductResponse.statusCode.toString());
      }
    } catch(e) {
      debugPrint("좋아요 상품 오류 발생 " + e.toString());
    }
  }

  requestFavoriteProductByAlcoholType(alcoholType) async {
    try{
      var requestProductResponse = await http.post(
        Uri.http(httpUri, 'ztz/products/alcoholList/favorite/$alcoholType'),
        headers: {"Content-Type": "application/json"},
      );
      if(requestProductResponse.statusCode == 200){
        debugPrint("좋아요 알코올 타입 결과 : " + utf8.decode(requestProductResponse.bodyBytes).toString());
        ProductInfo.favoriteProductList.clear();
        ProductInfo.favoriteProductList = jsonDecode(utf8.decode(requestProductResponse.bodyBytes));
      }else{
        debugPrint("좋아요 알코올 타입 통신 오류 " + requestProductResponse.statusCode.toString());
      }

    }catch(e){
      debugPrint("좋아요 알코올 타입 오류 발생 " + e.toString());
    }
  }

  requestFavoriteProductByLocal(localName) async {
    try{
      var requestProductResponse = await http.get(
        Uri.http(httpUri, 'ztz/products/list/favorite/$localName'),
        headers: {"Content-Type": "application/json"},
      );
      if(requestProductResponse.statusCode == 200){
        debugPrint("좋아요 지역 요청 결과 : " + utf8.decode(requestProductResponse.bodyBytes).toString());
        ProductInfo.favoriteProductList.clear();
        ProductInfo.favoriteProductList = jsonDecode(utf8.decode(requestProductResponse.bodyBytes));
      }else{
        debugPrint("좋아요 지역 통신 오류 " + requestProductResponse.statusCode.toString());
      }
    }catch(e){
      debugPrint("좋아요 지역 오류 발생 " + e.toString());
    }
  }

  requestFavoriteProductByLocalAndAlcoholType(alcoholType , localName) async {
    var data = {'alcoholType' : alcoholType , 'localName' : localName};
    var body = json.encode(data);
    try{
      var requestProductResponse = await http.post(
          Uri.http(httpUri, 'ztz/products/list/favorite/by-local-type'),
          headers: {"Content-Type": "application/json"},
          body: body
      );
      if(requestProductResponse.statusCode == 200){
        debugPrint("좋아요 지역과 타입 결과 : " + utf8.decode(requestProductResponse.bodyBytes).toString());
        ProductInfo.favoriteProductList.clear();
        ProductInfo.favoriteProductList = jsonDecode(utf8.decode(requestProductResponse.bodyBytes));
      }else{
        debugPrint("좋아요 지역과 타입 통신 오류 " + requestProductResponse.statusCode.toString());
      }
    }catch(e){
      debugPrint("좋아요 지역과 타입 오류 발생 " + e.toString());
    }
  }

  requestNextPageProduct(keyword , productNo) async {
    var data = {'keyword' : keyword ,'productNo' : productNo.toString()};
    try{
      var requestProductListResponse = await http.post(
        Uri.http(httpUri,'ztz/products/list/next/flutter' , data),
        headers: {"Content-Type": "application/json"},
      );

      debugPrint(requestProductListResponse.statusCode.toString());
      if(requestProductListResponse.statusCode == 200){

        if(keyword == ""){
          debugPrint("추가 페이지 조회 결과 : " + utf8.decode(requestProductListResponse.bodyBytes).toString());
          ProductInfo.productList += jsonDecode(utf8.decode(requestProductListResponse.bodyBytes));
        }else{
          debugPrint("검색 키워드 : " + keyword);
          debugPrint("검색 결과 : " + utf8.decode(requestProductListResponse.bodyBytes).toString());
          ProductInfo.searchedProductList += jsonDecode(utf8.decode(requestProductListResponse.bodyBytes));
        }

      }
    }catch(e){
      debugPrint("오류 발생 " + e.toString());
    }
  }

  requestNextPageLocalProduct(localName , productNo) async {
    var data = {'productNo' : productNo.toString()};

    try{
      var requestProductListResponse = await http.post(
        Uri.http(httpUri,'ztz/products/list/next/flutter/$localName' , data),
        headers: {"Content-Type": "application/json"},
      );

      if(requestProductListResponse.statusCode == 200){
        debugPrint("추가 페이지 조회 결과 : " + utf8.decode(requestProductListResponse.bodyBytes).toString());
        ProductInfo.productList += jsonDecode(utf8.decode(requestProductListResponse.bodyBytes));
      }else{
        debugPrint("통신 오류" + requestProductListResponse.statusCode.toString());
      }


    }catch(e){
      debugPrint("오류 발생 " + e.toString());
    }
  }

  requestNextPageAlcoholTypeProduct(alcoholType , productNo) async {
    var data = {'productNo' : productNo.toString()};

    try{
      var requestProductListResponse = await http.post(
        Uri.http(httpUri,'ztz/products/alcoholList/next/flutter/$alcoholType' , data),
        headers: {"Content-Type": "application/json"},
      );

      if(requestProductListResponse.statusCode == 200){
        debugPrint("추가 페이지 조회 결과 : " + utf8.decode(requestProductListResponse.bodyBytes).toString());
        ProductInfo.productList += jsonDecode(utf8.decode(requestProductListResponse.bodyBytes));
      }else{
        debugPrint("통신 오류" + requestProductListResponse.statusCode.toString());
      }

    }catch(e){
      debugPrint("오류 발생 " + e.toString());
    }
  }

  requestNextPageAlcoholTypeAndLocalProduct(alcoholType,localName , productNo) async {
    var data = {'productNo' : productNo.toString() , 'localName' : localName , 'alcoholType' : alcoholType};

    try{
      var requestProductListResponse = await http.post(
        Uri.http(httpUri,'ztz/products/list/by-local-type/next/flutter' , data),
        headers: {"Content-Type": "application/json"},
      );

      if(requestProductListResponse.statusCode == 200){
        debugPrint("추가 페이지 조회 결과 : " + utf8.decode(requestProductListResponse.bodyBytes).toString());
        ProductInfo.productList += jsonDecode(utf8.decode(requestProductListResponse.bodyBytes));
      }else{
        debugPrint("통신 오류" + requestProductListResponse.statusCode.toString());
      }

    }catch(e){
      debugPrint("오류 발생 " + e.toString());
    }
  }
}