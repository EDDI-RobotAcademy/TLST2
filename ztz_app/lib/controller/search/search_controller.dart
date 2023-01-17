import 'package:get/get.dart';
import 'package:ztz_app/controller/search/search_service_api.dart';


class SearchController extends GetxController{
  static late var reactiveKeywordList = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }


  Future<void> fetchData() async{
    await SearchService.fetchItems();

  }

}
