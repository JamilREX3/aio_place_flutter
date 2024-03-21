import 'package:aio_place/models/sub_category_model.dart';
import 'package:aio_place/utils/api_request.dart';
import 'package:aio_place/views/product_list_view.dart';
import 'package:flutter/material.dart';
import '../models/category_model.dart';
import 'package:get/get.dart';

class SubCategoriesBottomSheet extends StatefulWidget {
  final CategoryModel categoryModel;

  const SubCategoriesBottomSheet({Key? key, required this.categoryModel})
      : super(key: key);

  @override
  State<SubCategoriesBottomSheet> createState() =>
      _SubCategoriesBottomSheetState();
}

class _SubCategoriesBottomSheetState extends State<SubCategoriesBottomSheet> {
  List<SubCategoryModel> subCategoriesList = [];
  bool loading = false;

  fetchSubCategories() async {
    setState(() {
      loading = true;
    });
    ApiRequest()
        .get(path: '/categories/${widget.categoryModel.id}/subcategories')
        .then((response) {
      if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
        setState(() {
          subCategoriesList =
              SubCategoryReq.fromJson(response.data).subCategoriesList!;
          loading = false;
        });
      } else {
        setState(() {
          loading = false;
        });
      }
    });
  }

  @override
  void initState() {
    fetchSubCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: BorderRadius.circular(20)
      ),
      padding: const EdgeInsets.only(bottom: 24, top: 12),

      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: subCategoriesList.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index != subCategoriesList.length) {
            return InkWell(
              onTap: (){
                Get.to(ProductListView(categoryModel: widget.categoryModel,subCategoryModel: subCategoriesList[index],));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text(subCategoriesList[index].name ?? '',style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 17))],
                ),
              ),
            );
          } else {
            //todo add
            return InkWell(
              onTap: (){
                Get.to(ProductListView(categoryModel: widget.categoryModel));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 13),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('All products' , style: TextStyle(fontWeight: FontWeight.w600,fontSize: 17),)],
                ),
              ),
            );
          }
        }, separatorBuilder: (BuildContext context, int index) {
          return const Divider(indent: 30,endIndent: 30,height: 0,);
      },
      ),
    );
  }
}
