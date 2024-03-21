

import 'package:get/get.dart';

import '../models/category_model.dart';
import '../utils/api_request.dart';

class AllCategoryController extends GetxController {

  RxList<CategoryModel> categories = RxList();
  var isLoading = false.obs;
  var page = 1.obs;
  var hasMore = true.obs;

  void fetchMore() async {
    if(isLoading.value || !hasMore.value) return;
    print('fetching more : page : $page');
    isLoading.value = true;
    // Call your API here
    var response = await ApiRequest().get(
      path: '/categories',
      authRequire: false,
      query: {'page': page.value, 'limit': 10},
    );
    // Add fetched items to the list
    List<CategoryModel> temp = CategoryModelReq.fromJson(response.data).categoriesList!;
    categories.addAll(temp);
    hasMore.value = temp.length==10;
    page.value++;
    isLoading.value = false;
  }


  @override
  void onInit() {
    super.onInit();
    fetchMore();
  }
}