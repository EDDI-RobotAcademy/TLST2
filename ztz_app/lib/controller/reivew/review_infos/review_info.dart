import 'package:get/get.dart';

class ReviewInfo extends GetxController{
  static late var productReviews = [];
  static late var memberReviews = [].obs;
  static late var reviewAverageAndCnt = [];

  static RxBool reviewRegister = false.obs;
  static RxBool reviewDelete = false.obs;
  static late var reviewAverage = 0.0;
  static late var reviewCnt = 0;

  void setReviewAve(){
    if(reviewAverageAndCnt[0]['average'] != "NaN"){
      reviewAverage = reviewAverageAndCnt[0]['average'];
      reviewCnt = reviewAverageAndCnt[0]['reviewCnt'];
    }
  }

  void resetReviewAve(){
    reviewAverage = 0.0;
    reviewCnt = 0;
  }
}