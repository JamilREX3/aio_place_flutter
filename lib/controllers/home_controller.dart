

import 'package:aio_place/models/category_model.dart';
import 'package:aio_place/models/product_model.dart';
import 'package:get/get.dart';

import '../utils/api_request.dart';

class HomeController extends GetxController {

  var loading = false.obs;
  RxList<CategoryModel> top6Categories = RxList();
  RxList<ProductModel> top6ProductsBySold = RxList();
  RxList<ProductModel> top6ProductsByRating = RxList();

  Future<void>getTop6Categories()async{
    var response = await ApiRequest().get(path: '/categories/top6' , authRequire: false);
    if(response.statusCode.toString().startsWith(RegExp(r'2'))){
      top6Categories.value = RxList(CategoryModelReq.fromJson(response.data).categoriesList!);
    }
  }
  Future<void>getTop6ProductsBySold()async{
    var response = await ApiRequest().get(path: '/products?sort=-sold&limit=6');
    if(response.statusCode.toString().startsWith(RegExp(r'2'))){
      top6ProductsBySold.value = RxList(ProductModelReq.fromJson(response.data).productsList!);
    }
  }
  Future<void>getTop6ProductsByRating()async{
    var response = await ApiRequest().get(path: '/products?sort=-ratingsAverage&limit=6');
    if(response.statusCode.toString().startsWith(RegExp(r'2'))){
      top6ProductsByRating.value = RxList(ProductModelReq.fromJson(response.data).productsList!);
    }
  }





  homeControllerInitialize()async{
    loading.value =true;
    print('getttttttttttting home');
    await Future.wait([getTop6Categories() , getTop6ProductsBySold() , getTop6ProductsByRating()]);
    loading.value =false;
  }
  // @override
  // void onInit() {
  //   super.onInit();
  //   homeControllerInitialize();
  // }
}