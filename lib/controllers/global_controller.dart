import 'package:aio_place/views/cart/cart_view.dart';
import 'package:aio_place/views/home_view.dart';
import 'package:aio_place/views/orders_view.dart';
import 'package:aio_place/views/wish_list_view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../views/general_search_view.dart';

class GlobalController extends GetxController {

  var index = 0.obs;
  final Rx<UserModel> userModel;
  var title = 'Home'.obs;


  GlobalController(UserModel userModel) : userModel = userModel.obs;

  //todo make something that change index
  changeIndex(int value){
    index.value = value;
  }
  // todo make navBarTrigger
  navBarTrigger(int value){
    switch (value){
      case 0 : {
        title.value = 'Home';
      }
      case 1 :{
        title.value = 'Cart';
      }
      case 2 :{
        title.value = 'Search';
      }
      case 3 :{
        title.value = 'Wish list';
      }
      case 4 :{
        title.value = 'Orders';
      }
    }
  }

  // todo make List<Widget> screens
  List<Widget> screens = [
    const HomeView(),
    const CartView(),
    const GeneralSearchView(),
    const WishListView(),
    const OrdersView(),
  ];
}
