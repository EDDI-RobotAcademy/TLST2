import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ztz_app/components/my_page/favorite/my_favorite_product_card.dart';
import 'package:ztz_app/controller/account/sign_up_infos/account_state.dart';
import 'package:ztz_app/controller/favorite/favorite_controller.dart';
import '../../../controller/favorite/favorite_infos/favorite_info.dart';
import '../../../controller/product/product_controller.dart';
import '../../../controller/product/product_infos/product_info.dart';
import '../../../controller/reivew/review_controller.dart';
import '../../../pages/product/product_detail_page.dart';
import '../../../utility/colors.dart';

class MyFavoriteProductComponent extends StatefulWidget {
  const MyFavoriteProductComponent({Key? key,

  }) : super(key: key);

  @override
  State<MyFavoriteProductComponent> createState() => _MyFavoriteProductComponent();
}

class _MyFavoriteProductComponent extends State<MyFavoriteProductComponent> {

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setMyFavoriteList();
  }

  void setMyFavoriteList() async {
    await FavoriteController().requestMyFavoriteToSpring(AccountState.accountGet.token.value);
    setState(() {
      isLoading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: !isLoading
          ? const Padding(
        // 로딩시 나오는 동그라미 동글동글
        padding: EdgeInsets.all(100),
        child: Center(
          child: CircularProgressIndicator(
            color: ColorStyle.mainColor,
          ),
        ),
      )
          : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 15),
                child:
                  Text("전체 ${FavoriteInfo.myFavoriteList.length}개", style: TextStyle(fontSize: 17),),
              ),
              Column(
                  children:
                  List.generate(
                    FavoriteInfo.myFavoriteList.length,
                    (index) => Padding(
                    padding: EdgeInsets.zero,
                    child: MyFavoriteProductCard(
                    productNo: FavoriteInfo.myFavoriteList[index]['product']['productNo'],
                    brand: FavoriteInfo.myFavoriteList[index]['product']['brand'],
                    price: FavoriteInfo.myFavoriteList[index]['product']['price'],
                    onTap: () {
                    selectProductCard(index);
                    },
                    title: FavoriteInfo.myFavoriteList[index]['product']['name'],
                    image: FavoriteInfo.myFavoriteList[index]['product']['productInfo']['thumbnailFileName'],
                    monthCheck: FavoriteInfo.myFavoriteList[index]['product']['monthAlcoholCheck'],
                    ),
                )
        ),
      ),
            ],
          ),
      )
    );
  }
  selectProductCard(index) async {
    await ProductController().requestProductDetailToSpring(ProductInfo.productList[index]['productNo']);
    await ReviewController().requestReviewAverageToSpring(ProductInfo.productList[index]['productNo']);
    await ReviewController().requestProductReviewToSpring(ProductInfo.productList[index]['productNo']);
    Get.to(
        ProductDetailPage(productNo: ProductInfo.productList[index]['productNo'],), //next page class
        duration: Duration(milliseconds: 500), //duration of transitions, default 1 sec
        transition: Transition.rightToLeft,//transition effect
        popGesture : true // 슬라이드로 뒤로가기
    );
  }
}
