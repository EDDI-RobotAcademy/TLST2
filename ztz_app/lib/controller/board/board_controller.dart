import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ztz_app/controller/board/board_infos/board_info.dart';
import 'package:ztz_app/controller/board/board_infos/register_question_info.dart';

class BoardController {
  static const httpUri = '192.168.200.168:7777';

  requestRegisterQuestionToSpring(
      RegisterQuestionInfo registerQuestionInfo) async {
    var data = {
      'title': registerQuestionInfo.title,
      'content': registerQuestionInfo.content,
      'memberId': registerQuestionInfo.memberId,
      'categoryType': registerQuestionInfo.categoryType,
      'privateCheck' : registerQuestionInfo.privateCheck
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

  requestMemberQuestionBoardListFromSpring(token) async {
    var data = {'token': token};
    var body = json.encode(data);
    try {
      var memberQuestionBoardResponse = await http.post(
        Uri.http(httpUri, 'ztz/boards/question/list/member'),
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (memberQuestionBoardResponse.statusCode == 200) {
        debugPrint("memberQuestionBoard 결과: " +
            utf8.decode(memberQuestionBoardResponse.bodyBytes).toString());
        BoardInfo.memberQuestionList =
            jsonDecode(utf8.decode(memberQuestionBoardResponse.bodyBytes));
      } else {
        debugPrint("memberQuestionBoard 통신 오류" +
            memberQuestionBoardResponse.statusCode.toString());
      }
    } catch (e) {
      debugPrint("memberQuestionBoard 오류 발생" + e.toString());
    }
  }

  requestDeleteQuestionToSpring(questionNo) async {
    try {
      var deleteQuestionResponse = await http.delete(
        Uri.http(httpUri, 'ztz/boards/question/$questionNo'),
        headers: {"Content-Type": "application/json"},
      );
      if (deleteQuestionResponse.statusCode == 200) {
        debugPrint("질문 삭제 성공");
        BoardInfo.deleteQuestionResult = true;
      } else {
        debugPrint(
            "질문 삭제 통신 오류" + deleteQuestionResponse.statusCode.toString());
      }
    } catch (e) {
      debugPrint("질문 삭제 오류 발생 " + e.toString());
    }
  }

  requestQuestionBoardFromSpring(questionNo) async {
    try {
      var questionResponse = await http.get(
        Uri.http(httpUri, 'ztz/boards/question/$questionNo'),
        headers: {"Content-Type": "application/json"},
      );
      if (questionResponse.statusCode == 200) {
        var result = {};
        result = jsonDecode(utf8.decode(questionResponse.bodyBytes));
        BoardInfo.questionBoard = result;
        debugPrint("questionBoard 결과 : "
            + utf8.decode(questionResponse.bodyBytes).toString());
      } else {
        debugPrint("questionBoard 통신 오류"
            + questionResponse.statusCode.toString());
      }
    } catch (e) {
      debugPrint("questionBoard 오류 발생 " + e.toString());
    }
  }

  requestModifyQuestionToSpring(questionNo,
      RegisterQuestionInfo registerQuestionInfo) async {
    try {
      var data = {
        'title': registerQuestionInfo.title,
        // 'writer': registerQuestionInfo.writer,
        'content': registerQuestionInfo.content,
        'memberId': registerQuestionInfo.memberId,
        'categoryType': registerQuestionInfo.categoryType,
        'privateCheck': registerQuestionInfo.privateCheck
      };
      var body = json.encode(data);
      debugPrint(body);

      var modifyQuestionResponse = await http.put(
        Uri.http(httpUri, 'ztz/boards/question/$questionNo'),
        headers: {"Content-Type": "application/json"},
        body: body,
      );
      if (modifyQuestionResponse.statusCode == 200) {
        debugPrint("question 수정 성공");
        BoardInfo.modifyQuestionResult = true;
      } else {
        debugPrint(
            "question 수정 통신 오류" + modifyQuestionResponse.statusCode.toString());
      }
    } catch (e) {
      debugPrint("question 수정 오류 발생" + e.toString());
    }
  }
  requestAllQuestionBoardListFromSpring() async {
    try {
      var questionBoardListResponse = await http.get(
        Uri.http(httpUri, 'ztz/boards/question/list'),
        headers: {"Content-Type": "application/json"},
      );
      if (questionBoardListResponse.statusCode == 200) {
        debugPrint("memberQuestionBoard 결과: " +
            utf8.decode(questionBoardListResponse.bodyBytes).toString());
        BoardInfo.memberQuestionList =
            jsonDecode(utf8.decode(questionBoardListResponse.bodyBytes));
      } else {
        debugPrint("memberQuestionBoard 통신 오류" +
            questionBoardListResponse.statusCode.toString());
      }
    } catch (e) {
      debugPrint("questionBoard 오류 발생 " + e.toString());
    }
  }
}
