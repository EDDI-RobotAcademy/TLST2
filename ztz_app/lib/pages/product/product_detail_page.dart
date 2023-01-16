import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:ztz_app/controller/favorite/favorite_controller.dart';
import 'package:ztz_app/controller/product/product_infos/product_info.dart';
import 'package:ztz_app/controller/reivew/review_infos/review_info.dart';
import 'package:ztz_app/utility/colors.dart';

import '../../components/product/product_detail/prdouct_buy_modal_component.dart';
import '../../components/product/product_detail/product_detail_appbar.dart';
import '../../components/product/product_detail/product_detail_component.dart';
import '../../components/reivew/product_review_component.dart';
import '../../controller/account/sign_up_infos/account_state.dart';
import '../../controller/favorite/favorite_infos/favorite_info.dart';
import '../../controller/product/product_infos/product_info.dart';
import '../../utility/button_style.dart';
import '../../utility/text_styles.dart';

class ProductDetailPage extends StatefulWidget{
  const ProductDetailPage({Key?key,required this.productNo}) : super (key: key);

  final int productNo;
  _ProductDetailPage createState() => _ProductDetailPage();
}
class _ProductDetailPage extends State<ProductDetailPage>{

  var isLoading = false;

  @override
  void initState() {
    callProductInfo();
    callFavoriteNumInfo();
    super.initState();
  }
  void callProductInfo() async {
    ProductInfo().setProductDetailINfo();
    ReviewInfo().setReviewAve();
  }

  void callFavoriteNumInfo() async{
    await FavoriteController().requestFavoriteStatusToSpring(
        AccountState.memberInfo['id'],
        ProductInfo.productNo,
        "favoriteCheck");
    FavoriteInfo().setFavoriteInfo();
    setState(() {
      isLoading = true;
      });
    debugPrint("좋아요 조회함 상품번호:" + ProductInfo.productNo.toString());
    debugPrint("좋아요 조회함 좋아요수는?:" + FavoriteInfo.favoriteNum.toString());
    debugPrint("좋아요 조회함 플래그는?:" + FavoriteInfo.productFavoriteFlag.toString());
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (!isLoading) { // 로딩 판단 유무
      return const Padding( // 로딩시 나오는 동그라미 동글동글
        padding: EdgeInsets.all(100),
        child: Center(
          child: CircularProgressIndicator(
            color: ColorStyle.mainColor,
          ),
        ),
      );
    } else{
      return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: ProductDetailAppbar(reviewCnt: ReviewInfo.reviewCnt, productName: ProductInfo.productName,),
            body: TabBarView(
              children: [
                SafeArea(
                    child: SingleChildScrollView(
                      child: ProductDetailComponent(productNo: widget.productNo),
                    )
                ),
                SafeArea(
                    child: SingleChildScrollView(
                        child: ProductReviewComponent()
                    )
                ),
              ],
            ),
            bottomNavigationBar: BottomAppBar(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Container(
                        width: 50,
                        height: 50,
                        padding: EdgeInsets.only(left: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: ColorStyle.textGray)
                        ),
                        child:
                        LikeButton(
                          onTap: onLikeButtonTapped,
                          likeBuilder: (bool isLiked) {
                            return FavoriteInfo.productFavoriteFlag ?
                            Icon(
                              Icons.favorite,
                              color:Colors.red,
                            ):
                            Icon(
                              Icons.favorite_border,
                              color:ColorStyle.mainColor,
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      child: ElevatedButton(
                          style:defaultElevatedButtonStyle(size.width - 80,50),
                          onPressed: (){
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context){
                                  return Container(
                                      height: 400,
                                      child: ProductBuyModalComponent()
                                  );
                                }
                            );
                          },
                          child: Text("구매하기",style: lageWhiteTextStyle(),)),
                    )
                  ],
                ),
              ),
            )
        ),
      );
    }

  }

  Future<bool> onLikeButtonTapped(bool isLiked) async{

    await AccountState.accountGet.isLoginCheck();
    if (AccountState.accountGet.isLogin.value) {
      await FavoriteController().requestFavoriteStatusToSpring(
          AccountState.memberInfo['id'],
          ProductInfo.productNo,
          "favoriteLike");
      FavoriteInfo().setFavoriteInfo();
      debugPrint("좋아요 클릭함 상품번호:" + ProductInfo.productNo.toString());
      debugPrint("좋아요 클릭함! 좋아요 수는?:" + FavoriteInfo.favoriteStatus['favoriteNum'].toString());

        return !isLiked;

    } else{
      //위젯 띄워주기
      debugPrint("로그인 상태만 좋아요 가능!");
      showFailFavorite();
      return isLiked;
    }
  }

  void showFailFavorite(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("로그인 시 가능한 서비스입니다."),
          content: new Text("로그인 후 이용해주세요."),
          actions: <Widget>[
            FlatButton(
              child: const Text("Close"),
              //경로 이동 없이 그냥 닫기
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

}