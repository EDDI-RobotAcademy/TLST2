import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ztz_app/controller/search/search_controller.dart';


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

}