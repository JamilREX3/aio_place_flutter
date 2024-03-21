// import 'dart:ui';
// import 'package:aio_place/controllers/global_controller.dart';
// import 'package:aio_place/models/product_model.dart';
// import 'package:aio_place/models/review_model.dart';
// import 'package:aio_place/models/sub_category_model.dart';
// import 'package:aio_place/utils/api_request.dart';
// import 'package:aio_place/utils/custom_colors_utils.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
//
// import '../component/custom_snacbar.dart';
//
// class ProductDetailsController extends GetxController {
//   var loading = false.obs;
//   List<Color> availableColors = [];
//   List<String> availableColorsStrings = [];
//   String categoryAndSubsCategoriesStrings = '';
//   RxList<ReviewModel> reviewsList = RxList<ReviewModel>();
//   Rx<ReviewModel> myReview = ReviewModel().obs;
//   ProductModel productModel = ProductModel();
//   final int _reviewsPerPage = 3;
//   RxInt reviewsPage = 0
//       .obs; // Make this public by removing the underscore at the beginning of its name.
//   RxBool hasMoreReviews = true
//       .obs; // Make this public by removing the underscore at the beginning of its name.
//   TextEditingController myReviewTextEditingController = TextEditingController();
//   double? myRating;
//
//   makeCatAndSubCatsStrings() {
//     categoryAndSubsCategoriesStrings = productModel.category!.name!;
//     if (productModel.subcategories != null &&
//         productModel.subcategories!.isNotEmpty) {
//       categoryAndSubsCategoriesStrings = '$categoryAndSubsCategoriesStrings > ';
//       for (SubCategoryModel subcategory in productModel.subcategories) {
//         categoryAndSubsCategoriesStrings =
//             '$categoryAndSubsCategoriesStrings ${subcategory.name} ';
//       }
//     }
//   }
//
//   bool _validateFields() {
//     if (myReviewTextEditingController.text.isEmpty ||
//         myReviewTextEditingController.text.isEmpty) {
//       CustomSnackbar.show(
//           title: 'Error', description: 'Please insert a comment');
//       return false;
//     }
//     if (myRating == null) {
//       CustomSnackbar.show(
//           title: 'Error', description: 'Please rate form stars');
//       return false;
//     }
//     return true;
//   }
//
//   createComment() async {
//     if (_validateFields()) {
//       var response = await ApiRequest().post(
//         path: '/products/${productModel.id}/reviews',
//         body: {
//           'title' : myReviewTextEditingController.text,
//           'ratings' : myRating,
//         }
//       );
//       if(response.statusCode.toString().startsWith(RegExp(r'2'))){
//         initProductDetails(productModel.id!);
//       }
//     }
//   }
//
//   updateComment()async{
//     if(_validateFields()) {
//       var response = await ApiRequest().put(path: '/reviews/${myReview.value.sId}',body: {
//         'title' : myReviewTextEditingController.text,
//         'ratings' : myRating,
//       });
//       if(response.statusCode.toString().startsWith(RegExp(r'2'))){
//         initProductDetails(productModel.id!);
//       }
//     }
//   }
//
//   Future<void>getMyReview(String productId) async {
//     String myId = Get.find<GlobalController>().userModel.value.id!;
//     print('MyId = $myId');
//     var response = await ApiRequest().get(path: '/reviews?product=$productId&user=$myId');
//     if (response.statusCode == 200) {
//       if (ReviewModelReq.fromJson(response.data).reviewsList!.isNotEmpty) {
//         myReview.value = ReviewModelReq.fromJson(response.data).reviewsList![0];
//         myReviewTextEditingController.text = myReview.value.title!;
//         myRating = myReview.value.ratings!.toDouble();
//         print('MyReview = ${myReview.value.title}');
//       }
//     }
//   }
//
//   Future<void>getReviews(String productId, String decOrInc) async {
//     if (decOrInc == 'inc') {
//       int newPage = reviewsPage.value + 1;
//       if (hasMoreReviews.value) {
//         final response = await ApiRequest().get(
//           path: '/products/$productId/reviews?sort=-updatedAt',
//           query: {
//             'limit': _reviewsPerPage,
//             'page': newPage,
//           },
//         );
//         List<ReviewModel> tempReviewList =
//             ReviewModelReq.fromJson(response.data).reviewsList!;
//         if (tempReviewList.length < _reviewsPerPage) {
//           hasMoreReviews.value = false;
//         }
//         if(ReviewModelReq.fromJson(response.data).reviewsList!.isEmpty && reviewsPage.value!=0){
//         }else{
//           reviewsList.value = ReviewModelReq.fromJson(response.data).reviewsList!;
//           reviewsPage.value++;
//         }
//
//
//       }
//     } else if (decOrInc == 'dec') {
//       if (reviewsPage.value > 1) {
//         int newPage = reviewsPage.value - 1;
//         final response = await ApiRequest().get(
//           path: '/products/$productId/reviews?sort=-updatedAt',
//           query: {
//             'limit': _reviewsPerPage,
//             'page': newPage,
//           },
//         );
//         hasMoreReviews.value = true;
//         reviewsList.value = ReviewModelReq.fromJson(response.data).reviewsList!;
//         reviewsPage.value--;
//       }
//     }
//     update();
//   }
//
//   Future<void>getProductsDetails(String productId) async {
//     loading.value = true;
//     var response = await ApiRequest().get(path: '/products/$productId');
//     if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
//       print('**************');
//       print(response.data);
//       productModel = ProductModel.fromJson(response.data['data']);
//       makeCatAndSubCatsStrings();
//       if (productModel.colors != null && productModel.colors!.isNotEmpty) {
//         availableColors =
//             CustomColorsUtils().getColorsFromStrings(productModel.colors!);
//         availableColorsStrings = productModel.colors!;
//         print(availableColors.length);
//       }
//       loading.value = false;
//     }
//   }
//
//
//   initProductDetails(String productId)async{
//     hasMoreReviews.value = true;
//     reviewsPage.value = 0;
//     await Future.wait([
//     getProductsDetails(productId),
//     getReviews(productId, 'inc'),
//     getMyReview(productId),
//     ]);
//   }
//
//
// }


import 'package:aio_place/controllers/global_controller.dart';
import 'package:aio_place/models/product_model.dart';
import 'package:aio_place/models/review_model.dart';
import 'package:aio_place/utils/api_request.dart';
import 'package:aio_place/utils/custom_colors_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../component/custom_snacbar.dart';

class ProductDetailsController extends GetxController {
  final loading = false.obs;
  final availableColors = <Color>[].obs;
  final availableColorsStrings = <String>[].obs;
  final reviewsList = <ReviewModel>[].obs;
  final myReview = ReviewModel().obs;
  final productModel = ProductModel().obs;
  final reviewsPage = 0.obs;
  final hasMoreReviews = true.obs;
  final myReviewTextEditingController = TextEditingController();
  double? myRating;

  String get categoryAndSubsCategoriesStrings =>
      _makeCatAndSubCatsStrings(productModel.value);

  bool _validateFields() {
    if (myReviewTextEditingController.text.isEmpty ||
        myReviewTextEditingController.text.isEmpty) {
      CustomSnackbar.show(
          title: 'Error', description: 'Please insert a comment');
      return false;
    }
    if (myRating == null) {
      CustomSnackbar.show(
          title: 'Error', description: 'Please rate form stars');
      return false;
    }
    return true;
  }

  void createComment() async {
    if (_validateFields()) {
      final response =
      await ApiRequest().post(path: '/products/${productModel.value.id}/reviews', body: {
        'title': myReviewTextEditingController.text,
        'ratings': myRating,
      });
      if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
        await initProductDetails(productModel.value.id!);
      }
    }
  }

  void updateComment() async {
    if (_validateFields()) {
      final response = await ApiRequest().put(
          path: '/reviews/${myReview.value.sId}',
          body: {
            'title': myReviewTextEditingController.text,
            'ratings': myRating,
          });
      if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
        await initProductDetails(productModel.value.id!);
      }
    }
  }

  Future<void> getMyReview(String productId) async {
    final myId = Get.find<GlobalController>().userModel.value.id!;
    final response = await ApiRequest().get(
        path: '/reviews?product=$productId&user=$myId');
    if (response.statusCode == 200) {
      final reviewsList =
      ReviewModelReq.fromJson(response.data).reviewsList!;
      if (reviewsList.isNotEmpty) {
        myReview.value = reviewsList[0];
        myReviewTextEditingController.text = myReview.value.title!;
        myRating = myReview.value.ratings!.toDouble();
      }else{
        myReview.value = ReviewModel();
      }
    }
  }

  Future<void> getReviews(String productId, String decOrInc) async {
    if (decOrInc == 'inc') {
      final newPage = reviewsPage.value + 1;
      if (hasMoreReviews.value) {
        final response = await ApiRequest().get(
          path: '/products/$productId/reviews?sort=-updatedAt',
          query: {
            'limit': 3,
            'page': newPage,
          },
        );
        final tempReviewList =
        ReviewModelReq.fromJson(response.data).reviewsList!;
        if (tempReviewList.length < 3) {
          hasMoreReviews.value = false;
        }
        if (tempReviewList.isNotEmpty || reviewsPage.value == 0) {
          reviewsList.value = tempReviewList;
          reviewsPage.value++;
        }
      }
    } else if (decOrInc == 'dec') {
      if (reviewsPage.value > 1) {
        final newPage = reviewsPage.value - 1;
        final response = await ApiRequest().get(
          path: '/products/$productId/reviews?sort=-updatedAt',
          query: {
            'limit': 3,
            'page': newPage,
          },
        );
        hasMoreReviews.value = true;
        reviewsList.value = ReviewModelReq.fromJson(response.data).reviewsList!;
        reviewsPage.value--;
      }
    }
    update();
  }

  Future<void> getProductsDetails(String productId) async {
    loading.value = true;
    final response = await ApiRequest().get(path: '/products/$productId');
    if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
      final product = ProductModel.fromJson(response.data['data']);
      productModel.value = product;
      if (product.colors != null && product.colors!.isNotEmpty) {
        availableColors.value =
            CustomColorsUtils().getColorsFromStrings(product.colors!);
        availableColorsStrings.value = product.colors!;
      }
      loading.value = false;
    }
  }


  Future<void> deleteMyComment()async{
    var response = await ApiRequest().delete(path: '/reviews/${myReview.value.sId}');
    if(response.statusCode.toString().startsWith(RegExp(r'2'))){
      myRating = 0;
      myReviewTextEditingController.clear();
      initProductDetails(productModel.value.id!);
    }
  }

  Future<void> initProductDetails(String productId) async {
    hasMoreReviews.value = true;
    reviewsPage.value = 0;
    await Future.wait([
      getProductsDetails(productId),
      getReviews(productId, 'inc'),
      getMyReview(productId),
    ]);
  }

  String _makeCatAndSubCatsStrings(ProductModel productModel) {
    var categoryAndSubsCategoriesStrings = productModel.category!.name!;
    if (productModel.subcategories != null &&
        productModel.subcategories!.isNotEmpty) {
      categoryAndSubsCategoriesStrings += ' > ';
      for (final subcategory in productModel.subcategories!) {
        categoryAndSubsCategoriesStrings += '${subcategory.name} ';
      }
    }
    return categoryAndSubsCategoriesStrings;
  }
}
