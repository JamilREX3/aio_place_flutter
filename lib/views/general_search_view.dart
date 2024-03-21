import 'package:aio_place/component/customTextField.dart';
import 'package:aio_place/component/product_card.dart';
import 'package:aio_place/controllers/general_search_controller.dart';
import 'package:aio_place/views/filter_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../utils/api_request.dart';
import '../utils/enum_state.dart';

class GeneralSearchView extends StatelessWidget {
  const GeneralSearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(GeneralSearchController());
    return GetBuilder<GeneralSearchController>(
      builder: (controller) => Column(
        children: [
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: CustomTextFormField(
                    contentPadding: const EdgeInsets.all(0),
                    prefixIcon: Icons.search_rounded,
                    controller: controller.searchTextController,
                    onFieldSubmitted: (value) {
                      controller.fetchProducts();
                    },
                  ),
                ),
              ),
              Transform.flip(
                  flipX: true,
                  child: IconButton(
                      onPressed: () {
                        if(controller.searchTextController.text.isNotEmpty){
                          Get.dialog(FilterView());
                        }

                      },
                      icon: const Icon(Icons.sort_rounded))),
            ],
          ),
          const SizedBox(height: 16),
          Obx(
            () => switch (controller.currentState.value) {
              CurrentState.init => Column(
                  children: [
                    const SizedBox(height: 75),
                    SvgPicture.asset(
                      'assets/svgs/noResults.svg',
                      width: Get.width * 0.6,
                    ),
                  ],
                ),
              CurrentState.loading => Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.3,
                    ),
                    const CircularProgressIndicator(),
                  ],
                ),
              CurrentState.empty => Column(
                  children: [
                    const SizedBox(height: 75),
                    SvgPicture.asset(
                      'assets/svgs/noResults.svg',
                      width: Get.width * 0.6,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'No results',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              CurrentState.full => Expanded(
                  child: GridView.builder(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 100),
                    itemCount: controller.productsList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            childAspectRatio: 0.55,
                            mainAxisSpacing: 20),
                    itemBuilder: (context, index) {
                      var productModel = controller.productsList[index];
                      return ProductCard(
                          onTapLike: (value) async {
                            print(value);
                            if (value == false) {
                              var response = ApiRequest().post(
                                  path: '/wishlist',
                                  body: {
                                    'productId': productModel.id,
                                  }).then(
                                  (res) => productModel.isInWishList = !value);
                            } else if (value == true) {
                              print('removing.....');
                              var response = ApiRequest()
                                  .delete(path: '/wishlist/${productModel.sId}')
                                  .then((res) =>
                                      productModel.isInWishList = !value);
                            }
                            return !value;
                          },
                          productModel: productModel);
                    },
                  ),
                ),
            },
          ),
        ],
      ),
    );
  }
}
