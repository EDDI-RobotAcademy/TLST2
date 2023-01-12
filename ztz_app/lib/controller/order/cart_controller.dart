import 'package:get/get.dart';
import 'package:ztz_app/controller/order/api/order_service_api.dart';

import '../../pages/order/order.dart';


class CartController extends GetxController{
  static late var reactiveCartList = [].obs;
  static RxBool obsCartStatus = false.obs;
  static var checkStatusMap = <String, bool>{ }.obs;
  static Set selectedProduct = {};
  static var totalAmount = 0.obs;
  static var deliveryFee = 0.obs;
  static var selectNum = 0.obs;
  static get sum => totalAmount.value + deliveryFee.value;

  @override
  void onInit() {
    super.onInit();
    fetchData();

    once(reactiveCartList,(_){
      print("첫번재 빌드");
      obsCartStatus.value = true;
    });
    debounce(reactiveCartList,(_){
      print("변화감지");
      obsCartStatus.value = false;
      if(reactiveCartList.isNotEmpty) {
        obsCartStatus.value = true;
      }
    }, time: Duration(seconds: 3));
    ever(checkStatusMap, (_){
      print("아이템 선택 감지");
      selectNum.value = 0;
      resetTotalAmount();
      checkStatusMap.forEach((key, value) {
        if(value){
          selectNum.value ++;
        }
      });
    });
    ever(totalAmount,(_){
      if(totalAmount > 50000) {
        deliveryFee.value = 0;
      } else {
        deliveryFee.value = 3000;
      }
    });

  }


  Future<void> fetchData() async{
    await OrderService.fetchItems();
  }
  reqAddItem(int productNo, int count) async {
    var res = await OrderService.requestAddToCart(productNo, count);
    if(res == 1) {
      fetchData();
    } else {
      print("add failed");
    }
  }
  reqChangeItemCount(int itemNo, int count, int totalPrice) async {
    var res = await OrderService.requestChangeItemInfo(itemNo, count, totalPrice);
    if(res == 1) {
      fetchData();
      CartController.checkStatusMap.remove(itemNo.toString());
    } else {
      print("change failed");
    }
  }
  reqDeleteItem(int itemNo) async {
    var res = await OrderService.requestDeleteItem(itemNo);
    if(res == 1) {
      fetchData();
    } else {
      print("failed");
    }
  }



  increment(int index){
    reactiveCartList[index]['count'] ++;
    int amount =
        reactiveCartList[index]['count'] * reactiveCartList[index]['product']['price'];
    reqChangeItemCount(
        reactiveCartList[index]['itemNo'],
        reactiveCartList[index]['count'],
        amount
    );
  }
  decrement(int index){
    reactiveCartList[index]['count'] --;
    int amount =
        reactiveCartList[index]['count'] * reactiveCartList[index]['product']['price'];
    reqChangeItemCount(
        reactiveCartList[index]['itemNo'],
        reactiveCartList[index]['count'],
        amount
    );
  }
  select(int index, String keyword) {
    // 먼저 맵에서 true인 itemNo들을 찾아서 리스트에 넣는다.
    // 맵을 toString하고 리스트를 to String 해서 동일한지 확인한다.
    checkStatusMap.forEach((key, value) {
      print('$key : $value');
      if(value) {
        selectedProduct.add(key);
      } else {
        selectedProduct.remove(key);
      }
      print(selectedProduct.toString());
    });
  }
  delete(int index, int itemNo) {
    selectedProduct.remove(reactiveCartList[index]['itemNo'].toString());
    checkStatusMap.remove(reactiveCartList[index]['itemNo'].toString());
    reactiveCartList.removeAt(index);
    reqDeleteItem(itemNo);
  }
  order() {
    // selectedProduct에서 선택한 아이템 번호를 찾는다.
    // 아이템 번호로 reactiveCartList에서
    // 해당 아이템의 정보와 count, selectedProductAmount, thumbnail명을 setting한다.
    // 해당 정보를 get argument로 넘긴다.
    var orderData = [];
    var priceData = [];
    if(selectedProduct.isEmpty) {
      Get.snackbar(
          'Failed',
          '선택한 상품이 없습니다.',
          snackPosition: SnackPosition.TOP);
    }

    for(String keyword in selectedProduct) {
      int selectedItem = int.parse(keyword);

      for(int i = 0; i < reactiveCartList.length; i++) {
        if(selectedItem.isEqual(reactiveCartList[i]['itemNo'])){
          var tmpData = {
            'itemNo':reactiveCartList[i]['itemNo'],
            'productName' : reactiveCartList[i]['product']['name'],
            'count': reactiveCartList[i]['count'],
            'selectedProductAmount': reactiveCartList[i]['selectedProductAmount'],
            'thumbnail': reactiveCartList[i]['product']['productInfo']['thumbnailFileName']
          };
          orderData.addAll({tmpData});
        }
      }
    }
    priceData.add(totalAmount);
    priceData.add(deliveryFee);
    priceData.add(sum);
    print(priceData.toString());

    if(!selectedProduct.isEmpty) {
      Get.to(()=> OrderPage(),arguments:[orderData, priceData]);
    } else {
        Get.snackbar(
            'Failed',
            '선택한 상품이 없습니다.',
            snackPosition: SnackPosition.TOP);
    }

  }

  //총액 구하기
  resetTotalAmount() {
    totalAmount.value = 0;
    if(checkStatusMap.containsValue(true)) {
      print("true있음.");
      findCheckItemKey();
    } else {
      print("아무것도 선택되지 않았음");
      totalAmount.value = 0;
    }
  }
  findCheckItemKey() {
    checkStatusMap.forEach((key, value) {
      if(value) {
        for (int i = 0; i < reactiveCartList.length; i++) {
          if(key == reactiveCartList[i]['itemNo'].toString()){
            totalAmount += reactiveCartList[i]['selectedProductAmount'];
          }
        }
      }
    });
  }
}
