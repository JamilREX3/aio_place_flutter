import 'package:aio_place/controllers/cart_controller.dart';
import 'package:aio_place/utils/enum_state.dart';
import 'package:get/get.dart';
import '../component/custom_snacbar.dart';
import '../models/address_model.dart';
import '../utils/api_request.dart';

class MakeOrderController extends GetxController {
  Rx<CurrentState> currentState = CurrentState.loading.obs;
  RxList<AddressModel> addressList = RxList<AddressModel>();
  AddressModel? selectedAddress;

  Future<void> getUserAddresses() async {
    currentState.value = CurrentState.loading;
    var response = await ApiRequest().get(path: '/addresses');
    if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
      var addressModelReq = AddressModelReq.fromJson(response.data);
      addressList.value = addressModelReq.addressList ?? [];
      currentState.value = CurrentState.full;
    }else{
      currentState.value = CurrentState.empty;
    }
  }
  _validate(){
    if(selectedAddress==null){
      CustomSnackbar.show(
          title: 'Error', description: 'Please fill the Shipping address');
      return false;
    }
    return true;
  }

  makeOrder(String cartId)async{
    if(_validate()){
      currentState.value = CurrentState.loading;
      var response = await ApiRequest().post(path: '/orders/$cartId',
      body: {
        'shippingAddress':{
          'details' : selectedAddress?.alias,
          'phone':selectedAddress?.phone,
          'city':selectedAddress?.city,
          'postalCode':selectedAddress?.postalCode
        }
      },
      );
      if(response.statusCode.toString().startsWith(RegExp(r'2'))){
        if(Get.isDialogOpen==true){
          Get.back();
        }
        Get.find<CartController>().initCartController();
      }else{
        currentState.value = CurrentState.full;
      }

    }
  }
}