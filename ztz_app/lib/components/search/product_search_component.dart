import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ztz_app/components/search/popular_keyword_component.dart';
import 'package:ztz_app/controller/product/product_controller.dart';
import 'package:ztz_app/utility/text_styles.dart';

import '../../controller/product/product_infos/product_info.dart';
import '../../controller/reivew/review_controller.dart';
import '../../controller/search/search_controller.dart';
import '../../controller/search/search_service_api.dart';
import '../../pages/product/product_detail_page.dart';
import '../../utility/button_style.dart';
import '../../utility/colors.dart';
import '../../utility/text_field_decoration.dart';
import '../main_page_components/product_card.dart';

class ProductSearchComponent extends StatefulWidget {
  const ProductSearchComponent({Key? key}) : super(key: key);

  @override
  State<ProductSearchComponent> createState() => _ProductSearchComponent();
}

class _ProductSearchComponent extends State<ProductSearchComponent> {
  late TextEditingController searchTextController;
  List recommendKeyword = ["선물세트", "사과막걸리" , "블루문" , "달달" , "오늘의 술" ];
  List getRecommendKeyword = SearchController.reactiveKeywordList;

  late FocusNode searchTextFocus = FocusNode();
  List<String> showKeyword = [];
  List<String> searchedKeyword = [];
  bool isSearchedKeyword = false;
  bool isFocus = false;
  bool isSearch = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    setInitKeyword();
    searchTextController = TextEditingController(text: !isSearch? null:searchTextController.text);
    searchTextFocus.addListener(() {
      setState(() {
        isFocus = searchTextFocus.hasFocus;
      });
    });
  }

  @override
  void dispose(){
    setDisposeKeyword();
    super.dispose();
  }


  void setInitKeyword() async {
    await SearchService().requestPopularSearchKeyword();
    final prefs = await SharedPreferences.getInstance();
    searchedKeyword = prefs.getStringList("keywords") ?? [];
    setState(() {
      showKeyword = List.from(searchedKeyword.reversed);
      isSearchedKeyword = true;
    });
  }

  void setPreferenceKeyword() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList("keywords", showKeyword);
  }

  void setDisposeKeyword() async{
    showKeyword = List.from(showKeyword.reversed);
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList("keywords", showKeyword);
  }

  void addRecentKeyword(keyword) async {

    if(showKeyword.length == 10){
      showKeyword.removeAt(9);
    }
    showKeyword.insert(0, keyword);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          Container(
              height: 75,
              width: size.width - 10,
              padding: EdgeInsets.all(15),
              child: searchTextFormField()),
          !isSearch ? Expanded(child: nonSearchWidget()) : isFocus ? Expanded(child: nonSearchWidget()) : widgetWhenDoSearch(),
        ],
      ),
    );
  }

  Widget searchTextFormField() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: TextFormField(
        textInputAction: TextInputAction.search,
        controller: searchTextController,
        decoration: searchTextFieldDecoration("검색어를 입력하세요" , searchTextController),
        keyboardType: TextInputType.text,
        focusNode: searchTextFocus,
        onSaved: (value) {
          setState(() {
            searchTextController.text = value!;
            if(searchTextController.text.isEmpty){
              isSearch = false;
            }
          });
        },
        onFieldSubmitted: (value) {
          _searchSubmitted(searchTextController.text);
        },
      ),
    );
  }

  void _searchSubmitted(keyword) async {
    await ProductController().requestAllProductToSpring(keyword);
    addRecentKeyword(searchTextController.text);
    setPreferenceKeyword();
    setState(() {
      searchTextController.text = keyword;
      isSearch = true;
      isLoading = true;
      isFocus = false;
    });
    await SearchService().requestPopularSearchKeyword();

  }


  Widget nonSearchWidget() {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(20),
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("최근 검색어" , style: blackBoldTextStyle(16),),
            Container(
              margin: EdgeInsets.only( bottom: 20),
              height: 50,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: showKeyword.isEmpty ?null :Row(
                  children: List.generate(showKeyword.length, (index) =>
                      Container(
                        height: 30,
                        margin: const EdgeInsets.only(left: 5.0),
                        child: OutlinedButton(
                            style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              shape:MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))),
                              backgroundColor: MaterialStateProperty.all(Colors.white),
                            ),
                            onPressed: (){
                              _searchSubmitted(showKeyword[index]);
                            }, child: Text(showKeyword[index] , style: TextStyle(fontSize: 13 , color: Colors.black , fontWeight: FontWeight.w400),)),
                      )
                  ),
                ),
              ),
            ),
            Text("추천 검색어" , style: blackBoldTextStyle(16)),
            Container(
                padding: EdgeInsets.only(top: 15 , bottom: 20),
                child : Wrap(
                    direction: Axis.horizontal,
                    children: List.generate(getRecommendKeyword.length, (index) =>
                        Container(
                          height: 30,
                          margin: const EdgeInsets.only(right: 7 , bottom: 10),
                          child: ElevatedButton(
                              style: searchElevatedButtonStyle(),
                              onPressed: (){
                                _searchSubmitted(getRecommendKeyword[index]['recommendedKeyword']);
                              }, child: Text(getRecommendKeyword[index]['recommendedKeyword'] , style: TextStyle(fontSize: 13 , color: ColorStyle.mainColor, fontWeight: FontWeight.w400),)),
                        )
                    )
                )
            ),
            SizedBox(height: 20,),
            Text("인기 검색어" , style: blackBoldTextStyle(16)),
            SizedBox(height: 18,),
            PopularKeywordComponent()
          ],
        ),
      ),
    );
  }

  Widget widgetWhenDoSearch(){
    Size size = MediaQuery.of(context).size;
    if(!isLoading){
      return const Padding( // 로딩시 나오는 동그라미 동글동글
        padding: EdgeInsets.all(100),
        child: Center(
          child: CircularProgressIndicator(
            color: ColorStyle.mainColor,
          ),
        ),
      );
    }else if(ProductInfo.searchedProductList.isEmpty){
      return Container(
        child: nonProduct(),
      );
    }else{
      return Container(
        child: productList(),
      );
    }
  }

  Widget nonProduct(){
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height-300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search , size: 60,),
          SizedBox(height: 10,),
          Text("검색된 상품이 없습니다."),
        ],
      ),
    );
  }

  Widget productList(){
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        scrollDirection: Axis.vertical,
        childAspectRatio: MediaQuery.of(context).size.height / 1500,
        padding: EdgeInsets.only(right: 20),
        children: List.generate(ProductInfo.searchedProductList.length, (index) =>
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ProductCard(
                brand: ProductInfo.searchedProductList[index]['brand'],
                price: ProductInfo.searchedProductList[index]['price'],
                onTap: () {
                  selectProductCard(index);
                },
                title: ProductInfo.searchedProductList[index]['name'],
                image: ProductInfo.searchedProductList[index]['productInfo']['thumbnailFileName'],
                monthCheck: ProductInfo.searchedProductList[index]['monthAlcoholCheck'],
              ),
            )
        ),
      ),
    );
  }

  void selectProductCard(int index) async {
    await ProductController().requestProductDetailToSpring(ProductInfo.searchedProductList[index]['productNo']);
    await ReviewController().requestReviewAverageToSpring(ProductInfo.searchedProductList[index]['productNo']);
    await ReviewController().requestProductReviewToSpring(ProductInfo.searchedProductList[index]['productNo']);
    Get.to(
        ProductDetailPage(
          productNo: ProductInfo.searchedProductList[index]['productNo'],
        ),
        //next page class
        duration: Duration(milliseconds: 500),
        //duration of transitions, default 1 sec
        transition: Transition.rightToLeft,
        //transition effect
        popGesture: true // 슬라이드로 뒤로가기
    );
  }


}
