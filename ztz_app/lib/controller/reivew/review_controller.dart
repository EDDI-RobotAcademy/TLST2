import 'dart:convert';

import 'package:http_parser/http_parser.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:ztz_app/controller/reivew/review_infos/review_info.dart';

class ReviewController {
  static const httpUri = '192.168.0.8:7777';

  requestProductReviewToSpring(productNo) async {
    try {
      var reviewResponse = await http.post(
        Uri.http(httpUri, 'ztz/products/review/read/$productNo'),
        headers: {"Content-Type": "application/json"},
      );
      if (reviewResponse.statusCode == 200) {
        debugPrint("결과 : " + utf8.decode(reviewResponse.bodyBytes).toString());
        ReviewInfo.productReviews =
            jsonDecode(utf8.decode(reviewResponse.bodyBytes));
      } else {
        debugPrint("통신 오류" + reviewResponse.statusCode.toString());
      }
    } catch (e) {
      debugPrint("오류 발생 " + e.toString());
    }
  }

  requestReviewAverageToSpring(productNo) async {
    try {
      var reviewResponse = await http.post(
        Uri.http(httpUri, 'ztz/products/review/read/average/$productNo'),
        headers: {"Content-Type": "application/json"},
      );
      if (reviewResponse.statusCode == 200) {
        debugPrint("결과 : " + utf8.decode(reviewResponse.bodyBytes).toString());
        ReviewInfo.reviewAverageAndCnt.clear();
        ReviewInfo.reviewAverageAndCnt =
            jsonDecode(utf8.decode(reviewResponse.bodyBytes));
      } else {
        debugPrint("통신 오류" + reviewResponse.statusCode.toString());
      }
    } catch (e) {
      debugPrint("오류 발생 " + e.toString());
    }
  }

  requestMyPageReviewToSpring(memberId) async {
    try {
      var reviewResponse = await http.post(
        Uri.http(httpUri, 'ztz/products/review/read/myPage/$memberId'),
        headers: {"Content-Type": "application/json"},
      );
      if (reviewResponse.statusCode == 200) {
        debugPrint("결과 : " + utf8.decode(reviewResponse.bodyBytes).toString());
        var tmpMemberReview = [];
        tmpMemberReview = jsonDecode(utf8.decode(reviewResponse.bodyBytes));
        ReviewInfo.memberReviews.clear();
        ReviewInfo.memberReviews = tmpMemberReview.obs;
      } else {
        debugPrint("통신 오류" + reviewResponse.statusCode.toString());
      }
    } catch (e) {
      debugPrint("오류 발생 " + e.toString());
    }
  }

  registerNonImageReview(memberId, productNo, rate, content , orderId) async {
    var data = {
      'memberId': memberId,
      'productNo': productNo,
      'rate': rate,
      'content': content,
      'orderId': orderId
    };
    var body = json.encode(data);

    try {
      var registerReviewResponse = await http.post(
          Uri.http(httpUri, 'ztz/products/review/register'),
          headers: {"Content-Type": "application/json"},
          body: body);
      if (registerReviewResponse.statusCode == 200) {
        ReviewInfo.reviewRegister = true.obs;
      } else {
        debugPrint("통신 오류" + registerReviewResponse.statusCode.toString());
      }
    } catch (e) {
      debugPrint("오류" + e.toString());
    }
  }

  registerImageReview(XFile sendImage, memberId, productNo, rate, content ,orderId ) async {
    var dio = Dio();
    final MultipartFile image = MultipartFile.fromFileSync(sendImage.path,
        contentType: MediaType('image', 'jpg'));

    var _formData = FormData.fromMap({
      'image': image,
      'info': MultipartFile.fromString(jsonEncode({
        'memberId': memberId,
        'productNo': productNo,
        'rate': rate,
        'content': content,
        'orderId': orderId
      }),
          contentType: MediaType.parse('application/json'))
    });

    try {
      var registerReviewResponse = await dio.post(
          'http://192.168.0.8:7777/ztz/products/review/registerWithImg',
          data: _formData);
      if (registerReviewResponse.statusCode == 200) {
        ReviewInfo.reviewRegister = true.obs;
      } else {
        debugPrint("통신 오류" + registerReviewResponse.statusCode.toString());
      }
    } catch (e) {
      debugPrint("오류" + e.toString());
    }
  }

  requestDeleteReview(reviewNo) async {
    try {
      var reviewResponse = await http.delete(
        Uri.http(httpUri, 'ztz/products/review/delete/$reviewNo'),
        headers: {"Content-Type": "application/json"},
      );
      if (reviewResponse.statusCode == 200) {
        debugPrint("결과 : " + utf8.decode(reviewResponse.bodyBytes).toString());
        ReviewInfo.reviewDelete = true.obs;
      } else {
        debugPrint("통신 오류" + reviewResponse.statusCode.toString());
      }
    } catch (e) {
      debugPrint("오류 발생 " + e.toString());
    }
  }

  requestModifyImgReview(XFile sendImage, memberId, productNo, rate, content, reviewNo ,orderId) async {
    var dio = Dio();
    final MultipartFile image = MultipartFile.fromFileSync(sendImage.path,
        contentType: MediaType('image', 'jpg'));
    debugPrint('reviewNo -' + reviewNo.toString());
    var _formData = FormData.fromMap({
      'image': image,
      'info': MultipartFile.fromString(jsonEncode({
        'memberId': memberId,
        'productNo': productNo,
        'rate': rate,
        'content': content,
        'orderId': orderId
      }),
          contentType: MediaType.parse('application/json'))
    });

    try {
      var registerReviewResponse = await dio.put(
          'http://192.168.0.8:7777/ztz/products/review/modifyWithImg/$reviewNo',
          data: _formData);
      if (registerReviewResponse.statusCode == 200) {
        ReviewInfo.reviewRegister = true.obs;
      } else {
        debugPrint("통신 오류" + registerReviewResponse.statusCode.toString());
      }
    } catch (e) {
      debugPrint("오류" + e.toString());
    }
  }

  requestModifyNonImgReview(memberId, productNo, rate, content, reviewNo, orderId) async {
    var data = {
      'memberId': memberId,
      'productNo': productNo,
      'rate': rate,
      'content': content,
      'orderId': orderId
    };
    var body = json.encode(data);

    try {
      var registerReviewResponse = await http.put(
          Uri.http(httpUri, 'ztz/products/review/modify/$reviewNo'),
          headers: {"Content-Type": "application/json"},
          body: body);
      if (registerReviewResponse.statusCode == 200) {
        ReviewInfo.reviewRegister = true.obs;
      } else {
        debugPrint("통신 오류" + registerReviewResponse.statusCode.toString());
      }
    } catch (e) {
      debugPrint("오류" + e.toString());
    }
  }
}
