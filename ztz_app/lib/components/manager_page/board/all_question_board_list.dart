import 'package:flutter/material.dart';
import 'package:ztz_app/controller/account/sign_up_infos/account_state.dart';
import 'package:ztz_app/controller/board/board_controller.dart';
import 'package:ztz_app/controller/board/board_infos/board_info.dart';
import 'package:ztz_app/controller/board/comment_controller.dart';
import 'package:ztz_app/controller/board/comment_infos/comment_info.dart';

class AllQuestionBoardList extends StatefulWidget {
  const AllQuestionBoardList({Key? key}) : super(key: key);

  @override
  State<AllQuestionBoardList> createState() => _AllQuestionBoardListState();
}

class _AllQuestionBoardListState extends State<AllQuestionBoardList> {
  String token = AccountState.accountGet.token.value;
  var memberQuestionList = [];
  var comment = {};
  var selected;

  @override
  void initState() {
    getMemberQuestionList();
    super.initState();
  }

  void getMemberQuestionList() async {
    await BoardController().requestAllQuestionBoardListFromSpring();
    setState(() {
      memberQuestionList = BoardInfo.memberQuestionList;
    });
  }

  void getCommentList(questionNo) async {
    await CommentController().requestCommentListFromSpring(questionNo);
    setState(() {
      comment = CommentInfo.comment;
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
        children: [
          ListView.builder(
              key: Key('builder ${selected.toString()}'),
              shrinkWrap: true,
              itemCount: memberQuestionList.length,
              itemBuilder: (context, index) {
                return ExpansionTile(
                  key: Key(index.toString()),
                  initiallyExpanded: index == selected,
                  textColor: Color(0xff205C37),
                  title: Text(memberQuestionList[index]['title']),
                  subtitle: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      memberQuestionList[index]['createDateTime'],
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  onExpansionChanged: ((newState) {
                    if (newState) {
                      getCommentList(memberQuestionList[index]['questionNo']);
                      setState(() {
                        Duration(seconds: 20000);
                        selected = index;
                      });
                    } else {
                      setState(() {
                        selected = -1;
                      });
                    }
                  }),
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
                            child: findCategoryName(index),
                          ),
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
                          // deleteAndModifyButton(index),
                          // commentList.length == 0
                          comment.isEmpty
                              ? Text("", style: TextStyle() ,textAlign: TextAlign.right,)
                              : showComment(),
                        ],
                      ),
                    )
                  ],
                );
              })
        ],
      ),
    );
  }

  Widget showComment() {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(right: 5),
              child: Image.asset("assets/images/letter-a.png",
                  width: 25, height: 25, fit: BoxFit.fill)),
          SizedBox(width: 10),
          Column(
            children: [
              Container(
                width: size.width - 120,
                child: Text(
                  // commentList[0]['comment'],
                  comment['comment'],
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                width: size.width - 120,
                child: Text(
                  comment['regDate'],
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget findCategoryName(index) {
    return Text(
      memberQuestionList[index]['boardCategory']['categoryType'] ==
              "ORDER_PAYMENT"
          ? "주문/결제문의"
          : memberQuestionList[index]['boardCategory']['categoryType'] ==
                  "PRODUCT"
              ? "상품문의"
              : memberQuestionList[index]['boardCategory']['categoryType'] ==
                      "DELIVERY"
                  ? "배송문의"
                  : memberQuestionList[index]['boardCategory']
                              ['categoryType'] ==
                          "RETURN_CHANGE"
                      ? "반품/교환문의"
                      : memberQuestionList[index]['boardCategory']
                                  ['categoryType'] ==
                              "TOUR"
                          ? "양조장문의"
                          : memberQuestionList[index]['boardCategory']
                                      ['categoryType'] ==
                                  "OTHER"
                              ? "기타문의"
                              : "카테고리오류",
      style: TextStyle(fontSize: 14, color: Colors.grey),
    );
  }
  
}
