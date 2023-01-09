import 'package:get/get.dart';
import 'package:ztz_app/controller/order/api/order_service_api.dart';


class CartController extends GetxController{
  static late var reactiveCartList = [].obs;
  static RxBool obsCartStatus = false.obs;


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

}
