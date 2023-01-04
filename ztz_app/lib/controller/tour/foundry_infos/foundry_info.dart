import 'package:get/get.dart';

class FoundryInfo extends GetxController{
  static late var foundryList = [];
  static late var selectedFoundry = {};
  static late int reservationInfo;

  static late String foundryName;
  static late String foundryAddress;
  static late String foundryTel;
  static late double foundryLat;
  static late double foundryLng;
  static late int foundryMinMember;
  static late int foundryDurationOfTime;
  static late int foundryPrice;
  static late String foundryContent;
  static late String foundryImgName;

  void setFoundryDetailInfo(){
    foundryName = selectedFoundry['name'];
    foundryAddress = selectedFoundry['address'];
    foundryTel = selectedFoundry['tel'];
    foundryLat = selectedFoundry['mapPoint']['lat'];
    foundryLng = selectedFoundry['mapPoint']['lng'];
    foundryMinMember = selectedFoundry['minMember'];
    foundryDurationOfTime = selectedFoundry['durationOfTime'];
    foundryPrice = selectedFoundry['price'];
    foundryContent = selectedFoundry['content'];
    foundryImgName = selectedFoundry['imgName'];
  }
}