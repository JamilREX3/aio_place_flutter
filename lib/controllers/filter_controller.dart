import 'package:aio_place/constants.dart';
import 'package:aio_place/controllers/general_search_controller.dart';
import 'package:aio_place/models/brand_model.dart';
import 'package:aio_place/models/category_model.dart';
import 'package:aio_place/models/sub_category_model.dart';
import 'package:aio_place/utils/api_request.dart';
import 'package:aio_place/views/general_search_view.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  var loading = false.obs;

  RxList<CategoryModel> categoriesList = RxList();
  RxList<SubCategoryModel> subCategoriesList = RxList();
  RxList<BrandModel> brandsList = RxList();
  RxList<String> sizes = RxList();
  List<String> sortOptionsList = [
    'name (A-Z)',
    'name (Z-A)',
    'price (low > high)',
    'price (high > low)',
    'top rated',
    'top sold'
  ];
  Rx<CategoryModel>? selectedCategoryModel;
  Rx<SubCategoryModel>? selectedSubCategoryModel;
  Rx<BrandModel>? selectedBrandModel;
  Rx<String>? selectedSize;
  Rx<String> selectedSort = Rx<String>('name (A-Z)');

  Future<void> fetchCategories() async {
    var response = await ApiRequest().get(path: '/categories');
    if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
      categoriesList.value =
          RxList(CategoryModelReq.fromJson(response.data).categoriesList!);
    }
    update();
  }

  String makeSortString(value) {
    switch (value) {
      case 'name (A-Z)':
        return 'title';
      case 'name (Z-A)':
        return '-title';
      case 'price (low > high)':
        return 'price';
      case 'price (high > low)':
        return '-price';
      case 'top rated':
        return '-ratingsAverage';
      case 'top sold':
        return '-sold';
      default:
        return '';
    }
  }

  Future<void> fetchSubCategories() async {
    subCategoriesList.value = [];
    selectedSubCategoryModel = null;
    if (selectedCategoryModel != null) {
      var response = await ApiRequest().get(
          path: '/categories/${selectedCategoryModel!.value.id}/subcategories');
      if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
        subCategoriesList.value =
            RxList(SubCategoryReq.fromJson(response.data).subCategoriesList!);
      }
    }
    update();
  }

  Future<void> fetchBrands() async {
    brandsList.value = [];
    selectedBrandModel = null;
    if (selectedCategoryModel != null) {
      var response = await ApiRequest()
          .get(path: '/brands?categories=${selectedCategoryModel!.value.id}');
      if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
        brandsList.value =
            RxList(BrandModelReq.fromJson(response.data).brandsList!);
      }
    } else {
      var response = await ApiRequest().get(path: '/brands');
      if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
        brandsList.value =
            RxList(BrandModelReq.fromJson(response.data).brandsList!);
      }
    }
    update();
  }

  Future<void> getSizesForSpecificCategory() async {
    if (selectedCategoryModel != null) {
      sizes.value = [];
      var response = await ApiRequest().get(
          path: '/products/sizes/${selectedCategoryModel!.value.id}',
          showSnackBar: false);
      if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
        print('6666666666666666');
        print(response.data['data']);
        sizes = RxList(response.data['data'].cast<String>());
      }
    }
    update();
  }


  String makeNewUrl() {
    String keyword = Get.find<GeneralSearchController>().searchTextController.text;
    String newUrl = "/products?";
    if(keyword.isNotEmpty){
      newUrl += "keyword=$keyword&";
    }
    if (selectedSort.value.isNotEmpty) {
      newUrl += "sort=${makeSortString(selectedSort.value)}&";
    }
    if (selectedCategoryModel?.value.id!=null) {
      newUrl += "category=${selectedCategoryModel!.value.id}&";
    }
    if (selectedSubCategoryModel != null) {
      newUrl += "subcategories=${selectedSubCategoryModel!.value.id}&";
    }
    if (selectedBrandModel != null) {
      newUrl += "brand=${selectedBrandModel!.value.id}";
    }
    return newUrl;
  }

  apply() {
    Get.find<GeneralSearchController>().fetchProducts(pathParam: makeNewUrl());
    if(Get.isDialogOpen==true){
      Get.back();
    }
  }

  initFilterController() async {
    // selectedSort?.value = sortOptionsList[0];
    await fetchCategories();
  }
}
