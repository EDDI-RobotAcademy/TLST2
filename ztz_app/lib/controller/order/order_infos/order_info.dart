import 'package:get/get.dart';

class OrderInfo extends GetxController {
  static late var paymentList = [].obs;
  static late var orderInfoList = [].obs;
  static late int salesAmount = 0;

  static late var writableOrderInfoList = [].obs;
  static RxBool refundResult = false.obs;
}