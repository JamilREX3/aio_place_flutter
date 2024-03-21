import 'package:aio_place/controllers/products_list_controller.dart';
import 'package:aio_place/models/category_model.dart';
import 'package:aio_place/models/sub_category_model.dart';
import 'package:aio_place/utils/enum_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../component/product_card.dart';
import '../utils/api_request.dart';


class ProductListView extends StatelessWidget {

  final CategoryModel? categoryModel;
  final SubCategoryModel? subCategoryModel;


  const ProductListView({Key? key , this.categoryModel , this.subCategoryModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProductListController());
    return GetBuilder<ProductListController>(
      initState: (_){
        var controller = Get.find<ProductListController>();
       controller.fetchProducts(category: categoryModel!.id , subCategory: subCategoryModel?.id);
      },
      builder: (controller)=>Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Products',style: GoogleFonts.lobsterTwo(fontSize: 35,fontStyle: FontStyle.italic),),
        ),
        body: Obx(() => controller.currentState.value==CurrentState.loading?const Center(child: CircularProgressIndicator()):GridView.builder(
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
        )),
      )
    );
  }
}
