import 'package:flutter/material.dart';
import 'package:ztz_app/components/layout/white_menu_app_bar.dart';
import 'package:ztz_app/components/my_page/board/question_board_list.dart';
import 'package:ztz_app/components/my_page/board/register_question_form.dart';
import 'package:ztz_app/utility/button_style.dart';
import 'package:ztz_app/utility/text_styles.dart';

class QuestionBoardPage extends StatelessWidget {
  const QuestionBoardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WhiteMenuAppBar(title: "1:1 문의"),
      body: QuestionBoardList(),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        child: ElevatedButton(
          style: defaultElevatedButtonStyle(380, 55),
          child: Text(
            '1:1 문의',
            style: whiteBoldTextStyle(16),
          ),
          onPressed: () {
            //상품문의 작성 컴포넌트
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegisterQuestionForm()));
          },
        ),
      ),
    );
  }
}
