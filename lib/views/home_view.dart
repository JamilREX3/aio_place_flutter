import 'package:aio_place/component/category_card.dart';
import 'package:aio_place/controllers/home_controller.dart';
import 'package:aio_place/views/all_category_view.dart';
import 'package:aio_place/views/product_details_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: GetBuilder<HomeController>(
        initState: (_){
          Get.find<HomeController>().homeControllerInitialize();
        },
        builder: (controller) => Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            const Text(
              'Top rated products',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            controller.top6ProductsByRating.isNotEmpty?CarouselSlider.builder(
              options: CarouselOptions(
                autoPlay: true,
              ),
              itemCount: controller.top6ProductsByRating.length,
              itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                  InkWell(onTap: (){
                    Get.to(Get.to(ProductsDetailsView(productId: controller.top6ProductsByRating[itemIndex].id!)));
                  },child: Container(margin: EdgeInsets.symmetric(horizontal: 20),child: ClipRRect(borderRadius: BorderRadius.circular(20) , child: CachedNetworkImage(imageUrl: controller.top6ProductsByRating[itemIndex].imageCover!,fit: BoxFit.cover,)))),
            ):SizedBox(),



            SizedBox(height: 20),
            const Text(
              'Top Categories',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 10),
            // top categories
            GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 6),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.top6Categories.length + 1,
              itemBuilder: (context, index) {
                if (index != controller.top6Categories.length) {
                  return CategoryCard(categoryModel: controller.top6Categories[index]);
                } else {
                  return GestureDetector(
                    onTap: (){
                      Get.to(const AllCategoryView());
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(10),
                        color: Get.isDarkMode ? Colors.black12 : Colors.white,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 35,
                            color: Theme.of(context).primaryColor,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            'more',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
            const Text(
              'Top sold products',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 16),
            controller.top6ProductsBySold.isNotEmpty? CarouselSlider.builder(
              options: CarouselOptions(
                autoPlay: true,
              ),
              itemCount: controller.top6ProductsBySold.length,
              itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                  InkWell(onTap: (){
                    Get.to(ProductsDetailsView(productId: controller.top6ProductsBySold[itemIndex].id!));
                  },child: Container(margin: const EdgeInsets.symmetric(horizontal: 20),child: ClipRRect(borderRadius: BorderRadius.circular(20) , child: CachedNetworkImage(imageUrl: controller.top6ProductsBySold[itemIndex].imageCover!,fit: BoxFit.cover,)))),
            ):const SizedBox(),
            const SizedBox(height: 150),
          ],
        )),
      ),
    );
  }
}
