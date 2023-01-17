import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:ztz_app/controller/search/search_controller.dart';
import 'package:ztz_app/controller/search/search_info/search_info.dart';


class SearchService {
  static const String httpUri = '192.168.200.175:7777';

  static fetchItems() async {
    var response = await http.get(
      Uri.http(httpUri, '/ztz/search/selected-keywords-list',),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(utf8.decode(response.bodyBytes));
      SearchController.reactiveKeywordList.clear();
      SearchController.reactiveKeywordList.value = jsonData;
      print("api" + jsonData.toString());
    }
  }

  requestPopularSearchKeyword() async {
    try{
      var keywordResponse = await http.post(
        Uri.http(httpUri,'/ztz/search/read/top/ten'),
        headers: {"Content-Type": "application/json"},
      );

      if(keywordResponse.statusCode == 200){
        var result = [];
        result = jsonDecode(utf8.decode(keywordResponse.bodyBytes));
        SearchInfo.popularSearchKeyword = result.obs;
        debugPrint("인기순위" + SearchInfo.popularSearchKeyword.toString());

      }else{
        debugPrint("인기순위 통신 오류" + keywordResponse.statusCode.toString());
      }
    }catch(e){
      debugPrint("오류 발생 " + e.toString());
    }
  }

}