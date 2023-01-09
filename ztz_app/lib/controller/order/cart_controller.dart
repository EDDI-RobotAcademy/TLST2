import 'package:get/get.dart';
import 'package:ztz_app/controller/order/api/order_service_api.dart';


class CartController extends GetxController{
  static late var reactiveCartList = [].obs;
  static RxBool obsCartStatus = false.obs;
  static var checkStatusMap = <String, bool>{ }.obs;

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

  }



  Future<void> fetchData() async{
    await OrderService.fetchItems("6688e783-7d19-4edf-a967-0e09aeb1e56b");
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
}
