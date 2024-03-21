import 'package:aio_place/models/cart_model.dart';
import 'package:aio_place/utils/api_request.dart';
import 'package:get/get.dart';
import '../utils/enum_state.dart';

class CartController extends GetxController {
  Rx<CurrentState> currentState = CurrentState.loading.obs;
  Rx<CartModel> cartModel = CartModel().obs;
  var totalCartPrice = 0.0.obs;
  var totalPriceAfterDiscount = 0.0.obs;

  getCart() async {
    print('gettttttttttttttttting cart');
    currentState.value = CurrentState.loading;
    var response = await ApiRequest().get(path: '/cart', showSnackBar: false);
    if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
      cartModel.value = CartModelReq.fromJson(response.data).cartModel!;
      totalCartPrice.value = CartModelReq.fromJson(response.data)
          .cartModel!
          .totalCartPrice!
          .toDouble();
      if (cartModel.value.totalPriceAfterDiscount != null) {
        totalPriceAfterDiscount.value =
            cartModel.value.totalPriceAfterDiscount!.toDouble();
      }
      currentState.value = CurrentState.full;
    } else {
      currentState.value = CurrentState.empty;
    }
  }

  changeQuantityOfItem(String incOrDec, CartItems cartItem) async {
    var response;
    if (incOrDec == 'Inc') {
      currentState.value = CurrentState.loading;
      response = await ApiRequest().put(path: '/cart/changeQuantity', body: {
        'itemId': cartItem.sId,
        'quantity': cartItem.quantity! + 1,
      });
      initCartController();
    } else {
      if (cartItem.quantity! > 1) {
        currentState.value = CurrentState.loading;
        response = await ApiRequest().put(path: '/cart/changeQuantity', body: {
          'itemId': cartItem.sId,
          'quantity': cartItem.quantity! - 1,
        });
        initCartController();
      }
    }
  }

  deleteItem(CartItems cartItem) async {
    currentState.value = CurrentState.loading;
    await ApiRequest().delete(path: '/cart/${cartItem.sId}');
    initCartController();
  }

  clearCart() async {
    currentState.value = CurrentState.loading;
    await ApiRequest().delete(path: '/cart');
    initCartController();
  }

  initCartController() {
    getCart();
  }
}
