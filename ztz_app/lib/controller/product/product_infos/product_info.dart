import 'package:get/get.dart';

class ProductInfo extends GetxController{
  static late var productList = [];
  static late var product = {}; // 컨트롤러에서 받은 DB 값을 저장하고
  static late var bestProductList = [];
  static late var searchedProductList = [];
  static late var recommendProductList = [];
  static late var favoriteProductList = [];

  static late int productNo;
  static late String productName;
  static late String productBrand;
  static late String subTitle;
  static late String thumbnailFileName;
  static late String description;
  static late int productPrice;
  static late int deliveryFee;
  static late bool monthCheck;
  static late var taste = [];
  static late var productImagesName = [];

  void setProductDetailINfo(){
    productNo = product['productNo'];
    productName = product['name'];
    productBrand = product['brand'];
    subTitle = product['productInfo']['subTitle'];
    thumbnailFileName = product['productInfo']['thumbnailFileName'];
    description = product['productInfo']['description'];
    productPrice = product['price'];
    deliveryFee = product['deliveryFee'];
    taste = product['productInfo']['taste'];
    productImagesName = product['productInfo']['productImagesName'];
    monthCheck = product['monthAlcoholCheck'];
  }
}