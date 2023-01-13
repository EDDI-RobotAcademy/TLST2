import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ztz_app/controller/reivew/review_controller.dart';
import 'package:ztz_app/utility/button_style.dart';

import '../../../controller/account/sign_up_infos/account_state.dart';
import '../../../controller/reivew/review_infos/review_info.dart';
import '../../../pages/my_page/my_page.dart';
import '../../../utility/text_field_decoration.dart';
import '../../../utility/text_styles.dart';

class ReviewRegisterComponent extends StatefulWidget{
  const ReviewRegisterComponent({Key?key,required this.orderId, required this.productName , required this.productId}) : super(key: key);

  final String productName;
  final int productId , orderId;
  @override
  State<ReviewRegisterComponent> createState() => _ReviewRegisterComponent();
}

class _ReviewRegisterComponent extends State<ReviewRegisterComponent>{

  IconData? _selectedIcon;
  double _selectedRating = 0.0;

  final _picker = new ImagePicker();
  XFile? imageFile;
  TextEditingController contentController = TextEditingController();

  Future imageUpload() async {
    XFile? selectImage = await _picker.pickImage(//이미지를 선택
      source: ImageSource.gallery, //위치는 갤러리 / ImageSource.camera-> 카메라로 접근// 이미지 크기 압축을 위해 퀄리티를 30으로 낮춤.
    );
    if (selectImage != null) {
      setState(() {
        imageFile = selectImage;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      color : Colors.white,
      margin: EdgeInsets.fromLTRB(10, 15, 10, 60),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: size.width -170 ,
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.productName , style: blackBoldTextStyle(15)),
              ),
              ratingStar(),
            ],
          ),
          Divider(thickness: 1,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("리뷰 작성" , style: blackBoldTextStyle(15),),
          ),
          TextFormField(
              minLines: 10,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              controller: contentController,
              decoration: textFieldDecoration("자세한후기는 다른고객의 구매에 많은 도움이되며,\n"
                  "전통주의 효능이나 효과 등에 오해소지가 있는\n"
                  "내용을 작성시 삭제 혹은 비공개 처리될 수 있습니다.")),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("사진 등록" ,  style: blackBoldTextStyle(15) ),
          ),
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(width: 1)
                ),
                child: IconButton(
                  onPressed: () {
                    imageUpload();
                  },
                  icon: Icon(Icons.add_outlined),
                ),
              ),
              SizedBox(width: 20,),
              Container(
                child: imageFile == null
                    ? null
                    : SizedBox(width: 80, height: 80,child: Image.file(File(imageFile!.path) , fit: BoxFit.fill)),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("구매한 상품이 아니거나, 타인의 사진을 캡처할 경우\n"
                "통보 없이 삭제될 수 있습니다." , style: grayLightTextStyle(10),),
          ),
          ElevatedButton(onPressed: (){
            if(imageFile != null){
              upLoadImageReview();
            }else{
              upLoadNonImageReview();
            }
          }, child: Text("등록하기"), style: defaultElevatedButtonStyle(size.width-20, 30),)
        ],
      ),
    );
  }

  void upLoadNonImageReview() async {
    debugPrint("텍스트");
    await ReviewController().registerNonImageReview(AccountState.memberInfo['id'], widget.productId, _selectedRating, contentController.text , widget.orderId);
    if(ReviewInfo.reviewRegister.value == true){
      showSuccessRegisterReview();
    }else{
      showFailRegisterReview();
    }
  }

  void upLoadImageReview() async {
    debugPrint("이미지");
    await ReviewController().registerImageReview(imageFile!, AccountState.memberInfo['id'], widget.productId, _selectedRating, contentController.text,  widget.orderId);
    if(ReviewInfo.reviewRegister.value == true){
      showSuccessRegisterReview();
    }else{
      showFailRegisterReview();
    }
  }

  Widget ratingStar(){
    return RatingBar.builder(
      initialRating: _selectedRating,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemSize: 20,
      itemPadding: const EdgeInsets.symmetric(horizontal: 1),
      itemBuilder: (context, _) => Icon(
        _selectedIcon ?? Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        setState(() {
          _selectedRating = rating;
        });
      },
    );
  }

  void showSuccessRegisterReview(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("리뷰 등록 성공!"),
          content: new Text("소중한 리뷰 감사합니다"),
          actions: <Widget>[
            FlatButton(
              child: const Text("닫기"),
              onPressed: () {
                ReviewInfo.reviewRegister = false.obs;
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => MyPage()),
                        (route) => false
                );
              },
            ),
          ],
        );
      },
    );
  }

  void showFailRegisterReview(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("리뷰 등록 실패"),
          content: new Text("죄송합니다 일시적 오류로 등록에 실패했습니다"),
          actions: <Widget>[
            FlatButton(
              child: const Text("닫기"),
              onPressed: () {
                ReviewInfo.reviewRegister = false.obs;
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => MyPage()),
                        (route) => false
                );
              },
            ),
          ],
        );
      },
    );
  }
}