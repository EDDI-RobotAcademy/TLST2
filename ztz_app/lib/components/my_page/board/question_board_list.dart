import 'package:flutter/material.dart';
import 'package:ztz_app/components/my_page/board/modify_question_form.dart';
import 'package:ztz_app/controller/account/sign_up_infos/account_state.dart';
import 'package:ztz_app/controller/board/board_controller.dart';
import 'package:ztz_app/controller/board/board_infos/board_info.dart';
import 'package:ztz_app/pages/my_page/board/question_board_page.dart';

class QuestionBoardList extends StatefulWidget {
  const QuestionBoardList({Key? key}) : super(key: key);

  @override
  State<QuestionBoardList> createState() => _QuestionBoardListState();
}

class _QuestionBoardListState extends State<QuestionBoardList> {
  String token = AccountState.accountGet.token.value;
  var memberQuestionList = [];

  @override
  void initState() {
    getMemberQuestionList();
    super.initState();
  }

  void getMemberQuestionList() async {
    await BoardController().requestMemberQuestionBoardListFromSpring(token);
    setState(() {
      memberQuestionList = BoardInfo.memberQuestionList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: memberQuestionList.length == 0
          ? showNoQuestionList()
          : showQuestionList(),
    );
  }

  Widget showNoQuestionList() {
    return Center(
      child: Text(
        "등록된 1:1문의가 없습니다.",
        style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
      ),
    );
  }

  Widget showQuestionList() {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: List.generate(
            memberQuestionList.length,
            (index) => ExpansionTile(
                  textColor: Color(0xff205C37),
                  title: Text(memberQuestionList[index]['title']),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      memberQuestionList[index]['createDateTime'],
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(color: Colors.grey.shade100),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // 카테고리
                          Container(
                              margin: EdgeInsets.only(bottom: 15),
                              child: Text(
                                memberQuestionList[index]['boardCategory']['categoryType'] == "ORDER_PAYMENT"? "주문/결제문의"
                                    : memberQuestionList[index]['boardCategory']['categoryType'] == "PRODUCT"? "상품문의"
                                    : memberQuestionList[index]['boardCategory']['categoryType'] == "DELIVERY"? "배송문의"
                                    : memberQuestionList[index]['boardCategory']['categoryType'] == "RETURN_CHANGE"? "반품/교환문의"
                                    : memberQuestionList[index]['boardCategory']['categoryType'] == "TOUR"? "양조장문의"
                                    : memberQuestionList[index]['boardCategory']['categoryType'] == "OTHER"? "기타문의" : "카테고리오류",
                                style: TextStyle(fontSize: 14, color: Colors.grey),
                              )),
                          Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(right: 5),
                                    child: Image.asset(
                                        "assets/images/letter-q.png",
                                        width: 25,
                                        height: 25,
                                        fit: BoxFit.fill)),
                                SizedBox(width: 10),
                                Container(
                                  width: size.width - 120,
                                  child: Text(
                                    memberQuestionList[index]['content'],
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                SizedBox(width: size.width - 180),
                                TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ModifyQuestionForm(
                                                    memberQuestionList[index]
                                                        ['questionNo'])),
                                      );
                                    },
                                    child: Text(
                                      "수정",
                                      style: TextStyle(
                                          color: Colors.grey.shade700),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      deleteQuestionFunction(
                                        memberQuestionList[index]['questionNo'],
                                      );
                                    },
                                    child: Text("삭제",
                                        style: TextStyle(
                                            color: Colors.grey.shade700)))
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
      ),
    );
  }

  void deleteQuestionFunction(questionNo) async {
    await BoardController().requestDeleteQuestionToSpring(questionNo);
    if (BoardInfo.deleteQuestionResult) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => QuestionBoardPage()),
      ).then((value) => setState(() {}));
    } else {
      showSnackBar("삭제에 실패했습니다. 다시 시도해주세요.");
    }
  }

  void showSnackBar(String text) {
    final snackBar = SnackBar(
      content: Text(text),
      action: SnackBarAction(
        label: '확인',
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
