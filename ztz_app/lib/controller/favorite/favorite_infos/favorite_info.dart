
import 'package:get/get.dart';

class FavoriteInfo extends GetxController{
  static late var favoriteStatus = {};
  static late int favoriteNum;
  static late bool productFavoriteFlag;

  static late var myFavoriteList = [];


  void setFavoriteInfo(){
    favoriteNum = favoriteStatus['favoriteNum'];
    productFavoriteFlag = favoriteStatus['productFavoriteFlag'];
  }
}