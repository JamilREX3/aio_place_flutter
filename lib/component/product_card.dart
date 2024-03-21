import 'dart:ui';
import 'package:aio_place/models/product_model.dart';
import 'package:aio_place/views/product_details_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:like_button/like_button.dart';

import '../views/add_to_cart_view.dart';


class ProductCard extends StatelessWidget {
  final ProductModel productModel;
  Future<bool?> Function(bool)? onTapLike;

  ProductCard({Key? key, required this.productModel , this.onTapLike}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('${productModel.title} : ${productModel.isInWishList}');
    return GestureDetector(
      onTap: (){
        Get.to(ProductsDetailsView(productId: productModel.id.toString()));
      },
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(10),
          color: Get.isDarkMode ? Colors.grey.withOpacity(0.15) : Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: Get.height * 0.15,
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: CachedNetworkImage(
                        imageUrl: productModel.imageCover!,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      height: Get.height * 0.15,
                      child: CachedNetworkImage(
                        imageUrl: productModel.imageCover!,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),

                ],
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                productModel.title ?? '',
                style: const TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: productModel.priceAfterDiscount == null
                  ? Row(
                      children: [
                        Text(
                          productModel.price.toString(),
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const Icon(
                          Icons.attach_money_rounded,
                          size: 15,
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productModel.price.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.red,
                              fontSize: 12),
                        ),
                        Row(
                          children: [
                            Text(
                              productModel.priceAfterDiscount.toString(),
                              style: const TextStyle(fontWeight: FontWeight.w900),
                            ),
                            const Icon(
                              Icons.attach_money_rounded,
                              size: 16,
                            ),
                          ],
                        ),
                      ],
                    ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                LikeButton(
                  size: 20,
                  isLiked: productModel.isInWishList,
                  onTap: onTapLike,
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            InkWell(
              onTap: (){
                Get.dialog(AddToCartView(productId: productModel.id!,));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor,
                ),
                padding: const EdgeInsets.symmetric(vertical: 10),

                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Add to cart' , style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
            ),
            //SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
