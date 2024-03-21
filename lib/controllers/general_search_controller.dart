

import 'package:aio_place/models/product_model.dart';
import 'package:aio_place/utils/api_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/enum_state.dart';



class GeneralSearchController extends GetxController {
  final TextEditingController searchTextController = TextEditingController();
  RxList<ProductModel> productsList = RxList();
  Rx<CurrentState> currentState = CurrentState.init.obs;




  String makePath(){
    String path = '/products?';
    if(searchTextController.text.isNotEmpty){
      path = '${path}keyword=${searchTextController.text}&';
    }
    print(path);
    return path;
  }
  fetchProducts({String? pathParam})async{
    currentState.value = CurrentState.loading;
    String path;
    if(pathParam==null){
      path = makePath();
    }else{
      path = pathParam;
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