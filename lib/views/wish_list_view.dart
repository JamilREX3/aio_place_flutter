import 'package:aio_place/controllers/wish_list_controller.dart';
import 'package:aio_place/utils/enum_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../component/product_card.dart';
import '../utils/api_request.dart';


class WishListView extends StatelessWidget {
  const WishListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(WishListController());
    return GetBuilder<WishListController>(
      initState: (_){
        Get.find<WishListController>().getWishListProducts();
      },
      builder:(controller)=> Obx(() => controller.currentState.value==CurrentState.loading?const Center(child: CircularProgressIndicator()):controller.currentState.value==CurrentState.empty?Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 164),
            SvgPicture.asset(
              'assets/svgs/emptyWishList.svg',
              width: Get.width * 0.8,
            ),
            const SizedBox(height: 28),
            const Text(
              'Empty wish list',
              style:
              TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
            ),

          ],
        ),
      ):GridView.builder(
        padding:
        const EdgeInsets.only(left: 10, right: 10, bottom: 100),
        itemCount: controller.wishListProducts.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            childAspectRatio: 0.55,
            mainAxisSpacing: 20),
        itemBuilder: (context, index) {
          var productModel = controller.wishListProducts[index];
          return ProductCard(
            onTapLike: (value)async{
              controller.currentState.value=CurrentState.loading;
              print('removing.....');
              var response = await ApiRequest().delete(path: '/wishlist/${productModel.sId}');
              productModel.isInWishList=!value;
              controller.getWishListProducts();
              return !value;
            },
              productModel: productModel);
        },
      )),
    );
  }
}
