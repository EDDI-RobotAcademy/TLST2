import 'package:get/get.dart';
import 'package:ztz_app/controller/order/api/order_service_api.dart';


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
        print(reactiveCartList.value.toString());
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
    await OrderService.fetchItems("f63c1741-bbd2-4aed-8e11-4a961c00a551");
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
  reqDeleteItem(int itemNo, String token) async {
    var res = await OrderService.requestDeleteItem(itemNo, token);
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
  delete(int index, int itemNo, token) {
    selectedProduct.remove(reactiveCartList[index]['itemNo'].toString());
    checkStatusMap.remove(reactiveCartList[index]['itemNo'].toString());
    reactiveCartList.removeAt(index);
    reqDeleteItem(itemNo, token);
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
