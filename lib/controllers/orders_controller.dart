

import 'package:aio_place/models/order_model.dart';
import 'package:aio_place/utils/api_request.dart';
import 'package:aio_place/utils/enum_state.dart';
import 'package:get/get.dart';



class OrdersController extends GetxController {

  Rx<CurrentState> currentState = CurrentState.loading.obs;
  RxList<OrderModel> ordersList = RxList<OrderModel>();

  getOrders()async{
    currentState.value = CurrentState.loading;
    var response = await ApiRequest().get(path: '/orders');
    if(response.statusCode.toString().startsWith(RegExp(r'2'))){
      ordersList.value = OrderModelReq.fromJson(response.data).ordersList!;
    }else{
      ordersList.value = [];
    }
    if(ordersList.isNotEmpty){
      currentState.value=CurrentState.full;
    }else{
      currentState.value=CurrentState.empty;
    }
  }


}