import 'package:get/get.dart';

class ProductInfo extends GetxController{
  static late var productList = [];
  static late var product = {};

  static late String productName;
  static late String productBrand;
  static late String subTitle;
  static late String thumbnailFileName;
  static late String description;
  static late int productPrice;
  static late int deliveryFee;
  static late var taste = [];
  static late var productImagesName = [];

  void setProductDetailINfo(){
    productName = product['name'];
    productBrand = product['brand'];
    subTitle = product['productInfo']['subTitle'];
    thumbnailFileName = product['productInfo']['thumbnailFileName'];
    description = product['productInfo']['description'];
    productPrice = product['price'];
    deliveryFee = product['deliveryFee'];
    taste = product['productInfo']['taste'];
    productImagesName = product['productInfo']['productImagesName'];
  }
}