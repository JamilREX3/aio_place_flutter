import 'package:aio_place/component/cart_item_card.dart';
import 'package:aio_place/controllers/cart_controller.dart';
import 'package:aio_place/utils/enum_state.dart';
import 'package:aio_place/views/cart/apply_copun_dialog.dart';
import 'package:aio_place/views/cart/make_order_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(CartController());
    return GetBuilder<CartController>(
      initState: (_) {
        Get.find<CartController>().getCart();
      },
      builder: (controller) => Obx(
        () => controller.currentState.value == CurrentState.full
            ? SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text('Total price : '),
                          Text(
                            controller.totalCartPrice.value.toStringAsFixed(2),
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      controller.cartModel.value.totalPriceAfterDiscount != null
                          ? Row(
                              children: [
                                const Text('Price after discount : '),
                                Text(
                                    controller.totalPriceAfterDiscount.value
                                        .toStringAsFixed(2),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800)),
                              ],
                            )
                          : const SizedBox(),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.clearCart();
                            },
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.indigo.shade900,
                                      Colors.indigo.shade500,
                                      // Colors.green.shade300,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.delete_outline_rounded,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text('Clear cart',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12)),
                                  ],
                                )),
                          ),
                          const Expanded(child: SizedBox()),
                          InkWell(
                            onTap: () {
                              Get.dialog(MakeOrderView(
                                  cartId: controller.cartModel.value.sId ?? '',
                                  finalPrice: controller.cartModel.value
                                          .totalPriceAfterDiscount
                                          ?.toDouble() ??
                                      controller.cartModel.value.totalCartPrice!
                                          .toDouble()));
                            },
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.indigo.shade900,
                                      Colors.indigo.shade500,
                                      // Colors.green.shade300,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.payment_rounded,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text('Make order',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12)),
                                  ],
                                )),
                          ),
                          const Expanded(child: SizedBox()),
                          InkWell(
                            onTap: () {
                              Get.dialog(const ApplyCouponDialog());
                            },
                            child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.indigo.shade900,
                                      Colors.indigo.shade500,
                                      // Colors.green.shade300,
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.redeem_rounded,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text('Apply coupon',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 12)),
                                  ],
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.cartModel.value.cartItems!.length,
                        itemBuilder: (context, index) {
                          return CartItemCard(
                            cartItem:
                                controller.cartModel.value.cartItems![index],
                            addPiece: () {
                              controller.changeQuantityOfItem('Inc',
                                  controller.cartModel.value.cartItems![index]);
                            },
                            removePiece: () {
                              controller.changeQuantityOfItem('Dec',
                                  controller.cartModel.value.cartItems![index]);
                            },
                            deleteItem: () {
                              controller.deleteItem(
                                  controller.cartModel.value.cartItems![index]);
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              )
            : controller.currentState.value == CurrentState.loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/svgs/emptyCart.svg',
                          width: Get.width * 0.6,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Empty Cart',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
