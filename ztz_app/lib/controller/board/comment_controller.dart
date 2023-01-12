import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ztz_app/controller/board/comment_infos/comment_info.dart';

class CommentController {
  static const httpUri = '172.30.1.54:7777';

  requestCommentListFromSpring(questionNo) async {
    try {
      var commentListResponse = await http.get(
          Uri.http(httpUri, "ztz/boards/question/comment/read/$questionNo"),
          headers: {"Content-Type": "application/json"});
      if (commentListResponse.statusCode == 200) {
        try {
          var result = {};
          result = jsonDecode(utf8.decode(commentListResponse.bodyBytes));
          CommentInfo.comment = result;
          debugPrint("commentList 결과 : " +
              utf8.decode(commentListResponse.bodyBytes).toString());
        } on FormatException catch (e) {
          // questionBoard에 comment가 null일때
          CommentInfo.comment = {};
        }
      } else {
        debugPrint(
            "commentList 통신 오류" + commentListResponse.statusCode.toString());
      }
    } catch (e) {
      debugPrint("commentList 오류 발생" + e.toString());
    }
  }
}
