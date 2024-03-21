import 'package:aio_place/component/sub_categories_bottom_sheet.dart';
import 'package:aio_place/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';



class CategoryCard extends StatelessWidget {
  final CategoryModel categoryModel;


  const CategoryCard({
    Key? key,
    required this.categoryModel,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){

        Get.bottomSheet(SubCategoriesBottomSheet(categoryModel: categoryModel));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Get.isDarkMode ? Colors.grey.shade900 : Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            categoryModel.image != null
                ? SvgPicture.network(
                categoryModel.image!,
                width: 42,
                height: 42,
                colorFilter: ColorFilter.mode(
                    Theme.of(context).primaryColor, BlendMode.srcIn))
                : const SizedBox(
              height: 42,
              width: 42,
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              categoryModel.name!,
              style:
              TextStyle(color: Theme.of(context).primaryColor),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}