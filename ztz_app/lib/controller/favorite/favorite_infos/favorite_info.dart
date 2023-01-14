
import 'package:get/get.dart';

class FavoriteInfo extends GetxController{
  static late var favoriteStatus = {};
  static late int favoriteNum;
  static late bool productFavoriteFlag;


  void setFavoriteInfo(){
    favoriteNum = favoriteStatus['favoriteNum'];
    productFavoriteFlag = favoriteStatus['productFavoriteFlag'];
  }
}