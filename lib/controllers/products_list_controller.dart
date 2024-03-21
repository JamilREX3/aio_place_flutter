import 'package:aio_place/utils/api_request.dart';
import 'package:get/get.dart';

import '../models/product_model.dart';
import '../utils/enum_state.dart';

class ProductListController extends GetxController{
  RxList<ProductModel> productsList = RxList();
  Rx<CurrentState> currentState = CurrentState.init.obs;
  fetchProducts({String? category , String? subCategory})async{
    currentState.value = CurrentState.loading;
    String path = '/products?';
    if(category!=null && category.isNotEmpty){
      path += 'category=$category&';
    }
    if(subCategory != null && subCategory.isNotEmpty){
      path+='subcategories=$subCategory&';
    }
    print(path);
    var response = await ApiRequest().get(path: path);
    if(response.statusCode.toString().startsWith(RegExp(r'2')) && ProductModelReq.fromJson(response.data).productsList!.isNotEmpty){
      productsList = RxList(ProductModelReq.fromJson(response.data).productsList!);
      currentState.value = CurrentState.full;
    }else{
      currentState.value = CurrentState.empty;
    }
    print(response.statusCode);
    print(response.data);
    print(productsList.length);
  }
}