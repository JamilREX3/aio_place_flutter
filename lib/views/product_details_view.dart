import 'package:aio_place/component/customTextField.dart';
import 'package:aio_place/component/review_card.dart';
import 'package:aio_place/controllers/product_details_controller.dart';
import 'package:aio_place/views/add_to_cart_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../component/confirm_delete_dialog1.dart';

class ProductsDetailsView extends StatelessWidget {
  final String productId;

  const ProductsDetailsView({Key? key, required this.productId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProductDetailsController());
    return GetBuilder<ProductDetailsController>(
      initState: (_) {
        Get.find<ProductDetailsController>().initProductDetails(productId);
      },
      builder: (controller) => Scaffold(
        body: Obx(() => controller.loading.value == false
            ? Stack(
              children: [
                SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                            imageUrl: controller.productModel.value.imageCover!,
                            fit: BoxFit.fitWidth),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                controller.productModel.value.title ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w900, fontSize: 24),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                controller.categoryAndSubsCategoriesStrings,
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w900),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  controller.productModel.value
                                              .priceAfterDiscount ==
                                          null
                                      ? Text(
                                          '${controller.productModel.value.price.toString()} \$',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w900,
                                              fontSize: 18))
                                      : Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              controller.productModel.value.price
                                                  .toString(),
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.red,
                                                  fontSize: 12,
                                                  fontStyle: FontStyle.italic,
                                                  decoration:
                                                      TextDecoration.lineThrough,
                                                  decorationColor: Colors.red),
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              '${controller.productModel.value.priceAfterDiscount.toString()} \$',
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 18),
                                            ),
                                          ],
                                        ),
                                  const Expanded(child: SizedBox()),
                                  controller.productModel.value.brand?.name != null
                                      ? Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 8),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Theme.of(context).primaryColor,
                                          ),
                                          child: Text(
                                            controller
                                                .productModel.value.brand.name,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w900),
                                          ))
                                      : const SizedBox(),
                                ],
                              ),
                              const SizedBox(height: 30),
                              Container(
                                alignment: Alignment.centerRight,
                                height: 50,
                                child: ListView.separated(
                                  itemCount: controller.availableColors.length,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Column(children: [
                                      Container(
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color: Theme.of(context).brightness ==
                                                      Brightness.light
                                                  ? Colors.grey.withOpacity(0.5)
                                                  : Colors.white.withOpacity(0.5),
                                              spreadRadius: 0.1,
                                              blurRadius: 2,
                                              offset: const Offset(0, 0.5),
                                            ),
                                          ],
                                          shape: BoxShape.circle,
                                          color: controller.availableColors[index],
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        controller.availableColorsStrings[index],
                                        style: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w900),
                                      )
                                    ]);
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const SizedBox(width: 10);
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text('Description',
                                  style: TextStyle(fontWeight: FontWeight.w900)),
                              Text(controller.productModel.value.description ?? ''),
                              const SizedBox(height: 24),
                              controller.productModel.value.sizes != null &&
                                      controller
                                          .productModel.value.sizes!.isNotEmpty
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                          const Text('Sizes',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w900)),
                                          Text(controller.productModel.value.sizes!
                                              .join(' , ')),
                                        ])
                                  : const SizedBox(),
                              const SizedBox(height: 24),
                              Row(
                                children: [
                                  const Text(
                                    'Reviews',
                                    style: TextStyle(fontWeight: FontWeight.w900),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.yellow.shade700,
                                    ),
                                    //color: Colors.yellow.shade700,
                                    child: Row(
                                      children: [
                                        Text(
                                          controller
                                                  .productModel.value.ratingsAverage
                                                  ?.toStringAsFixed(1) ??
                                              '0',
                                          style:
                                              const TextStyle(color: Colors.white),
                                        ),
                                        const SizedBox(width: 4),
                                        const Icon(
                                          Icons.star_rounded,
                                          color: Colors.white,
                                          size: 15,
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              controller.myReview.value.createdAt == null
                                  ? Container(
                                      margin: const EdgeInsets.symmetric(vertical: 10),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 16),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.withOpacity(0.5)),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              RatingBar.builder(
                                                itemSize: 20,
                                                initialRating: 1,
                                                minRating: 1,
                                                maxRating: 5,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4.0),
                                                itemBuilder: (context, _) =>
                                                    const Icon(
                                                  Icons.star,
                                                  color: Colors.amber,
                                                ),
                                                onRatingUpdate: (rating) {
                                                  controller.myRating = rating;
                                                },
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          CustomTextFormField(
                                            controller: controller
                                                .myReviewTextEditingController,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 0, horizontal: 15),
                                          ),
                                          const SizedBox(height: 10),
                                          ElevatedButton(
                                              onPressed: () {
                                                controller.createComment();
                                              },
                                              child: const Text('comment'))
                                        ],
                                      ),
                                    )
                                  : Container(
                                      margin:
                                          const EdgeInsets.symmetric(vertical: 10),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 16),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.withOpacity(0.5)),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Stack(
                                        children: [
                                          Positioned(
                                              top: -14,
                                              right: -12,
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.delete_rounded,
                                                  size: 20,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                                onPressed: () {
                                                  Get.dialog(ConfirmDeleteDialog(title: 'Delete comment', content: 'Are you sure that you want to delete your comment',confirmString: 'Delete', onDelete: ()async{
                                                    controller.deleteMyComment();
                                                  }));
                                                },
                                              )),
                                          Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  RatingBar.builder(
                                                    itemSize: 20,
                                                    initialRating: controller
                                                        .myReview.value.ratings!
                                                        .toDouble(),
                                                    minRating: 1,
                                                    maxRating: 5,
                                                    direction: Axis.horizontal,
                                                    allowHalfRating: true,
                                                    itemCount: 5,
                                                    itemPadding:
                                                        const EdgeInsets.symmetric(
                                                            horizontal: 4.0),
                                                    itemBuilder: (context, _) =>
                                                        const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    onRatingUpdate: (rating) {
                                                      controller.myRating = rating;
                                                    },
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 18),
                                              CustomTextFormField(
                                                controller: controller
                                                    .myReviewTextEditingController,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 0,
                                                        horizontal: 15),
                                              ),
                                              const SizedBox(height: 10),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    controller.updateComment();
                                                  },
                                                  child:
                                                      const Text('update comment'))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                              controller.reviewsList.isNotEmpty
                                  ? ListView.separated(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: controller.reviewsList.length,
                                      itemBuilder: (context, index) {
                                        return ReviewCard(
                                            reviewModel:
                                                controller.reviewsList[index]);
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const SizedBox(height: 7);
                                      },
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                        controller.reviewsList.isNotEmpty
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                      onPressed: () {
                                        controller.getReviews(productId, 'dec');
                                      },
                                      style: ButtonStyle(
                                        padding: MaterialStateProperty.all(
                                          const EdgeInsets.symmetric(
                                              vertical: 0, horizontal: 0),
                                        ),
                                      ),
                                      child: const Text('< Prev')),
                                  const SizedBox(width: 10),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      padding: MaterialStateProperty.all(
                                        const EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 0),
                                      ),
                                    ),
                                    onPressed: () async {
                                      controller.getReviews(productId, 'inc');
                                    },
                                    child: const Text('Next >'),
                                  ),
                                  const SizedBox(width: 16),
                                ],
                              )
                            : const SizedBox(),
                        const SizedBox(height:100,),

                      ],
                    ),
                  ),
                Positioned(
                  bottom: 0,
                  child: InkWell(
                    onTap: (){
                      Get.dialog(AddToCartView(productId: controller.productModel.value.id!,));
                    },
                    child: Container(
                      width: Get.width,
                      height: 55,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text('Add to Cart' , style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 22
                          ),),
                          Row(
                            children: [
                              Text(controller.productModel.value.priceAfterDiscount?.toStringAsFixed(2)??controller.productModel.value.price!.toStringAsFixed(2),style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                  fontSize: 22
                              )),
                              const SizedBox(width: 8),
                              const Icon(Icons.shopping_cart_rounded,color: Colors.white,),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
            : const Center(child: CircularProgressIndicator())),
      ),
    );
  }
}