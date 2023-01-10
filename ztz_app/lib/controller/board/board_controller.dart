import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ztz_app/controller/board/board_infos/register_question_info.dart';

class BoardController {
  static const httpUri = '172.30.1.54:7777';

  requestRegisterQuestionToSpring(
      RegisterQuestionInfo registerQuestionInfo) async {
    var data = {
      'title': registerQuestionInfo.title,
      'writer': registerQuestionInfo.writer,
      'content': registerQuestionInfo.content,
      'memberId': registerQuestionInfo.memberId,
      'categoryType': registerQuestionInfo.categoryType
    };
    var body = json.encode(data);
    debugPrint(body);

    try {
      var registerQuestionResponse = await http.post(
        Uri.http(httpUri, 'ztz/boards/question/register'),
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (registerQuestionResponse.statusCode == 200) {
        debugPrint("질문 등록 성공");
        RegisterQuestionInfo.registerQuestionResult = true;
      }
    } catch (e) {
      debugPrint("질문 등록 오류 발생 : " + e.toString());
    }
  }
}