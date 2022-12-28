import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:ztz_app/controller/reivew/review_infos/review_info.dart';

class ReviewController{
  static const httpUri = '192.168.0.8:7777';

  requestProductReviewToSpring(productNo) async {
    try{
      var reviewResponse = await http.post(
        Uri.http(httpUri, 'ztz/products/review/read/$productNo'),
        headers: {"Content-Type": "application/json"},
      );
      if(reviewResponse.statusCode == 200){
        debugPrint("결과 : " + utf8.decode(reviewResponse.bodyBytes).toString());
        ReviewInfo.productReviews = jsonDecode(utf8.decode(reviewResponse.bodyBytes));
      }else{
        debugPrint("통신 오류" + reviewResponse.statusCode.toString());
      }
    }catch(e){
    debugPrint("오류 발생 " + e.toString());
    }
  }

  requestReviewAverageToSpring(productNo) async {
    try{
      var reviewResponse = await http.post(
        Uri.http(httpUri, 'ztz/products/review/read/average/$productNo'),
        headers: {"Content-Type": "application/json"},
      );
      if(reviewResponse.statusCode == 200){
        debugPrint("결과 : " + utf8.decode(reviewResponse.bodyBytes).toString());
        ReviewInfo.reviewAverageAndCnt = jsonDecode(utf8.decode(reviewResponse.bodyBytes));

      }else{
        debugPrint("통신 오류" + reviewResponse.statusCode.toString());
      }
    }catch(e){
      debugPrint("오류 발생 " + e.toString());
    }
  }
}