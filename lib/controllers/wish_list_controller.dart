

import 'package:aio_place/models/product_model.dart';
import 'package:aio_place/utils/api_request.dart';
import 'package:aio_place/utils/enum_state.dart';
import 'package:get/get.dart';

class WishListController extends GetxController {
  
  Rx<CurrentState> currentState = CurrentState.loading.obs;
  RxList<ProductModel> wishListProducts = RxList();
  getWishListProducts()async{
    currentState.value = CurrentState.loading;
    wishListProducts.clear();
    var response = await ApiRequest().get(path: '/wishlist');
    if(response.statusCode.toString().startsWith(RegExp(r'2')) && ProductModelReq.fromJson(response.data).productsList!.isNotEmpty){
      wishListProducts = RxList(ProductModelReq.fromJson(response.data).productsList!);
      currentState.value = CurrentState.full;
      print('full');
    }else{
      print('empty');
      currentState.value = CurrentState.empty;
    }
  }


}