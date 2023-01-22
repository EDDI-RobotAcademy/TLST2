import 'package:flutter/material.dart';
import 'package:ztz_app/components/layout/white_menu_app_bar.dart';

import '../../../components/manager_page/board/all_question_board_list.dart';

class AllQuestionBoardPage extends StatelessWidget {
  const AllQuestionBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WhiteMenuAppBar(title: "1:1 문의"),
      body: AllQuestionBoardList(),
    );
  }
}
