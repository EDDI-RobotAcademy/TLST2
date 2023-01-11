import 'package:flutter/material.dart';
import 'package:ztz_app/components/layout/white_menu_app_bar.dart';
import 'package:ztz_app/controller/account/sign_up_infos/account_state.dart';
import 'package:ztz_app/controller/board/board_controller.dart';
import 'package:ztz_app/controller/board/board_infos/board_info.dart';
import 'package:ztz_app/controller/board/board_infos/register_question_info.dart';
import 'package:ztz_app/pages/my_page/board/question_board_page.dart';
import 'package:ztz_app/utility/button_style.dart';
import 'package:ztz_app/utility/text_field_decoration.dart';
import 'package:ztz_app/utility/text_styles.dart';

class ModifyQuestionForm extends StatefulWidget {
  const ModifyQuestionForm(this.questionNo, {Key? key}) : super(key: key);

  final int questionNo;

  @override
  State<ModifyQuestionForm> createState() => _ModifyQuestionFormState();
}

class _ModifyQuestionFormState extends State<ModifyQuestionForm> {
  int memberId = AccountState.memberInfo['id'];
  String writer = AccountState.memberInfo['username'];
  String selectedCategory = '';
  String title = '';
  String content = '';

  List<String> categoryList = [
    '주문/결제문의',
    '상품문의',
    '배송문의',
    '반품/교환문의',
    '양조장문의',
    '기타문의'
  ];

  TextEditingController categoryController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void initState() {
    getQuestionBoard(widget.questionNo);
    super.initState();
  }

  @override
  void dispose() {
    categoryController.dispose();
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void getQuestionBoard(questionNo) async {
    await BoardController().requestQuestionBoardFromSpring(questionNo);
    setState(() {
      selectedCategory = findSelectedCategory();
      title = BoardInfo.questionBoard['title'];
      content = BoardInfo.questionBoard['content'];
    });
  }

  String findSelectedCategory() {
    String inputCategory =
        BoardInfo.questionBoard['boardCategory']['categoryType'].toString();
    String selectedCategory = "";
    switch (inputCategory) {
      case "ORDER_PAYMENT":
        selectedCategory = "주문/결제문의";
        break;
      case "PRODUCT":
        selectedCategory = "상품문의";
        break;
      case "DELIVERY":
        selectedCategory = "배송문의";
        break;
      case "RETURN_CHANGE":
        selectedCategory = "반품/교환문의";
        break;
      case "TOUR":
        selectedCategory = "양조장문의";
        break;
      case "OTHER":
        selectedCategory = "기타문의";
        break;
    }
    return selectedCategory;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: WhiteMenuAppBar(title: "1:1문의 수정"),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(child: Text("문의 유형"), height: 28),
                TextFormField(
                  readOnly: true,
                  controller: categoryController..text = selectedCategory,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.black, width: 2.0)),
                      suffixIcon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      hintText: "유형을 선택해주세요"),
                  onTap: () {
                    showModal(context);
                  },
                ),
                SizedBox(height: 30),
                SizedBox(child: Text("문의 내용"), height: 28),
                TextFormField(
                    controller: titleController..text = title,
                    decoration: textFieldDecoration("제목을 입력해주세요")),
                SizedBox(height: 10),
                TextFormField(
                    minLines: 6,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    controller: contentController..text = content,
                    decoration: textFieldDecoration("문의하실 내용을 입력해주세요")),
                SizedBox(height: 20),
                SizedBox(
                  child: Text(
                    "상품과 무관한 내용이거나 음란 및 불법적인 내용은 통보없이 삭제될 수 있습니다.",
                    style: TextStyle(color: Colors.grey.shade600),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  style: defaultElevatedButtonStyle(380, 55),
                  child: Text(
                    "등록하기",
                    style: whiteTextStyle(16),
                  ),
                  onPressed: () {
                    if (selectedCategory == '') {
                      showTextDialog("문의 유형을 선택해주세요");
                    } else if (titleController.text == '') {
                      showTextDialog("제목을 입력해주세요");
                    } else if (contentController.text == '') {
                      showTextDialog("내용을 입력해주세요");
                    } else {
                      //문의 수정
                      modifyQuestionFunction();
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }

  void modifyQuestionFunction() async {
    RegisterQuestionInfo registerQuestionInfo = RegisterQuestionInfo(
        titleController.text,
        writer,
        contentController.text,
        memberId,
        selectedCategory);
    await BoardController()
        .requestModifyQuestionToSpring(widget.questionNo, registerQuestionInfo);
    if (BoardInfo.modifyQuestionResult) {
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => QuestionBoardPage()),
      ).then((value) => setState(() {}));
    } else {
      showTextDialog("수정을 실패했습니다.");
    }
  }


  void showModal(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0), topLeft: Radius.circular(20.0)),
        ),
        context: context,
        builder: (context) {
          return Container(
              padding: EdgeInsets.all(8),
              height: 350,
              alignment: Alignment.center,
              child: ListView.builder(
                  itemCount: categoryList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(categoryList[index]),
                      onTap: () {
                        setState(() {
                          selectedCategory = categoryList[index];
                          categoryController.text = selectedCategory;
                        });
                        Navigator.of(context).pop();
                      },
                    );
                  }));
        });
  }

  void showTextDialog(String content) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(content),
            actions: <Widget>[
              TextButton(
                child: Text(
                  "확인",
                  style: blackTextStyle(14),
                ),
                onPressed: () => Navigator.pop(context),
              )
            ],
          );
        });
  }
}
