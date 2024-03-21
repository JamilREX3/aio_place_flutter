

import 'package:aio_place/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../component/custom_snacbar.dart';
import '../utils/api_request.dart';
import '../utils/custom_colors_utils.dart';

class AddToCartController extends GetxController {
  var loading  = false.obs;
  ProductModel productModel = ProductModel();
  List<Color> availableColors = [];
  List<String> availableColorsStrings = [];
  List<String> availableSizes = [];
  String? selectedSize;
  String? selectedColor;
  RxInt selectedQuantity = 1.obs;
  RxDouble totalPrice = 0.0.obs;

  Future<void> getProductsDetails(String productId) async {
    loading.value = true;
    final response = await ApiRequest().get(path: '/products/$productId');
    if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
      final product = ProductModel.fromJson(response.data['data']);
      productModel = product;
      if (product.colors != null && product.colors!.isNotEmpty) {
        availableColors =
            CustomColorsUtils().getColorsFromStrings(product.colors!);
        availableColorsStrings = product.colors!;
      }
      if(product.sizes!=null && product.sizes!.isNotEmpty){
        availableSizes = product.sizes!;
      }
      calcTotalPrice();
      print('available sizes: $availableSizes');
      loading.value = false;
    }
    print('sssssssssssss : ${productModel.title}');
    update();
  }

  calcTotalPrice(){
    totalPrice.value = (productModel.priceAfterDiscount?.toDouble()??productModel.price!.toDouble())*selectedQuantity.value;
  }

  changeQuantity(String decOrInc){
    if(decOrInc=='Inc'){
      selectedQuantity.value++;
      calcTotalPrice();
    }else{
      if(selectedQuantity.value>1){
        selectedQuantity.value--;
        calcTotalPrice();
      }
    }
  }

  Map makeTheBodyRequest(){
    Map body={};
    body.addAll({'productId' : productModel.id , 'quantity' : selectedQuantity.value});
    if(selectedSize!=null){
      body.addAll({'size' : selectedSize});
    }
    if(selectedColor!=null){
      body.addAll({'color' : selectedColor});
    }
    print(body);
    return body;
  }



  addToCart()async{
    loading.value = true;
    if(_validate()){
      var bodyOfTheReq = makeTheBodyRequest();
      var response = await ApiRequest().post(path: '/cart',body: bodyOfTheReq);
      if(response.statusCode.toString().startsWith(RegExp(r'2'))){
        if(Get.isDialogOpen==true){
          print('9999999999999990');
          Get.closeAllSnackbars();
          Get.back();
        }
        CustomSnackbar.show(title: 'Done' , description: 'Item added to cart successfully' ,colorText: Colors.white , backgroundColor: Colors.indigo);

      }

    }
    loading.value=false;
  }


  _validate(){
    if(productModel.sizes!=null && productModel.sizes!.isNotEmpty){
      if(selectedSize==null){
              CustomSnackbar.show(
          title: 'Error', description: 'Please choose a size');
        return false;
      }
    }
    if(productModel.colors!=null && productModel.colors!.isNotEmpty){
      if(selectedColor==null){
        CustomSnackbar.show(
            title: 'Error', description: 'Please choose a color');
        return false;
      }
    }
    return true;
  }

}