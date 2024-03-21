import 'package:aio_place/controllers/filter_controller.dart';
import 'package:aio_place/models/brand_model.dart';
import 'package:aio_place/models/category_model.dart';
import 'package:aio_place/models/sub_category_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterView extends StatelessWidget {
  const FilterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(FilterController());
    return Material(
      color: Colors.transparent,
      child: GetBuilder<FilterController>(
        initState: (_) {
          Get.find<FilterController>().loading.value = true;
          Get.find<FilterController>().fetchCategories();
          Get.find<FilterController>().fetchBrands();
          Get.find<FilterController>().loading.value = false;
        },
        builder: (controller) => Obx(
          () => controller.loading.value == true
              ? Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).dialogBackgroundColor,
                      borderRadius: BorderRadius.circular(20)),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 120),
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).dialogBackgroundColor,
                      borderRadius: BorderRadius.circular(20)),
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 120),
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Text(
                        'Filtration',
                        style: GoogleFonts.lobsterTwo(
                            fontStyle: FontStyle.italic, fontSize: 24),
                      )),
                      const SizedBox(height: 24),
                      // category
                      Row(
                        children: [
                          const Text(
                            'Category',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(width: 6),
                          controller.categoriesList.isNotEmpty
                              ? Expanded(
                                  child: DropdownButtonFormField<CategoryModel>(
                                    isDense: true,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 0),
                                    decoration: InputDecoration(
                                      //  labelText: widget.labelText,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(27),
                                        borderSide: const BorderSide(
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      //filled: true,
                                      contentPadding: const EdgeInsets.only(
                                          left: 10,
                                          top: 0,
                                          bottom: 0,
                                          right: 6),
                                      fillColor: Colors.white24,
                                    ),
                                    value:
                                        controller.selectedCategoryModel?.value,
                                    onChanged: (CategoryModel? newValue) async {
                                      controller.loading.value = true;
                                      controller.selectedCategoryModel =
                                          Rx<CategoryModel>(newValue!);
                                      controller.update();
                                      //await controller.fetchCategories();
                                      await controller
                                          .getSizesForSpecificCategory();
                                      await controller.fetchSubCategories();
                                      await controller.fetchBrands();
                                      controller.loading.value = false;
                                      controller.update();
                                    },
                                    items: controller.categoriesList
                                        .map<DropdownMenuItem<CategoryModel>>(
                                            (CategoryModel value) {
                                      return DropdownMenuItem<CategoryModel>(
                                        value: value,
                                        child: Text(value.name!),
                                      );
                                    }).toList(),
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                      const SizedBox(height: 16),
                      controller.selectedCategoryModel != null &&
                              controller.subCategoriesList.isNotEmpty
                          ? Row(
                              children: [
                                const Text(
                                  'Sub category',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child:
                                      DropdownButtonFormField<SubCategoryModel>(
                                    isDense: true,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 0),
                                    decoration: InputDecoration(
                                      //  labelText: widget.labelText,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(27),
                                        borderSide: const BorderSide(
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      //filled: true,
                                      contentPadding: const EdgeInsets.only(
                                          left: 10,
                                          top: 0,
                                          bottom: 0,
                                          right: 6),
                                      fillColor: Colors.white24,
                                    ),
                                    value: controller
                                        .selectedSubCategoryModel?.value,
                                    onChanged:
                                        (SubCategoryModel? newValue) async {
                                      controller.selectedSubCategoryModel =
                                          Rx<SubCategoryModel>(newValue!);
                                      controller.update();
                                    },
                                    items: controller.subCategoriesList.map<
                                            DropdownMenuItem<SubCategoryModel>>(
                                        (SubCategoryModel value) {
                                      return DropdownMenuItem<SubCategoryModel>(
                                        value: value,
                                        child: Text(value.name!),
                                      );
                                    }).toList(),
                                  ),
                                )
                              ],
                            )
                          : SizedBox(),
                      const SizedBox(height: 16),
                      // brand
                      Row(
                        children: [
                          const Text(
                            'Brand',
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(width: 6),
                          controller.brandsList.isNotEmpty
                              ? Expanded(
                                  child: DropdownButtonFormField<BrandModel>(
                                    isDense: true,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 0),
                                    decoration: InputDecoration(
                                      //  labelText: widget.labelText,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(27),
                                        borderSide: const BorderSide(
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      //filled: true,
                                      contentPadding: const EdgeInsets.only(
                                          left: 10,
                                          top: 0,
                                          bottom: 0,
                                          right: 6),
                                      fillColor: Colors.white24,
                                    ),
                                    value: controller.selectedBrandModel?.value,
                                    onChanged: (BrandModel? newValue) async {
                                      controller.selectedBrandModel =
                                          Rx<BrandModel>(newValue!);
                                      controller.update();
                                    },
                                    items: controller.brandsList
                                        .map<DropdownMenuItem<BrandModel>>(
                                            (BrandModel value) {
                                      return DropdownMenuItem<BrandModel>(
                                        value: value,
                                        child: Text(value.name!),
                                      );
                                    }).toList(),
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // sizes
                      controller.sizes.isNotEmpty
                          ? Row(
                              children: [
                                const Text(
                                  'Size',
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: DropdownButtonFormField<String>(
                                    isDense: true,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 0),
                                    decoration: InputDecoration(
                                      //  labelText: widget.labelText,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(27),
                                        borderSide: const BorderSide(
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      //filled: true,
                                      contentPadding: const EdgeInsets.only(
                                          left: 10,
                                          top: 0,
                                          bottom: 0,
                                          right: 6),
                                      fillColor: Colors.white24,
                                    ),
                                    value: controller.selectedSize?.value,
                                    onChanged: (String? newValue) async {
                                      controller.selectedSize =
                                          Rx<String>(newValue!);
                                      controller.update();
                                    },
                                    items: controller.sizes
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            )
                          : SizedBox(),

                      //sorting
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(Icons.sort_rounded),
                          const SizedBox(width: 6),
                          Expanded(
                            child: DropdownButtonFormField<String>(
                              isDense: true,
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 0),
                              decoration: InputDecoration(
                                //  labelText: widget.labelText,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(27),
                                  borderSide: const BorderSide(
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                //filled: true,
                                contentPadding: const EdgeInsets.only(
                                    left: 10, top: 0, bottom: 0, right: 6),
                                fillColor: Colors.white24,
                              ),
                              value: controller.selectedSort.value,
                              onChanged: (String? newValue) async {
                                controller.selectedSort = Rx<String>(newValue!);
                                controller.update();
                              },
                              items: controller.sortOptionsList
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),

                      const Expanded(child: SizedBox()),

                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              controller.apply();
                            },
                            child: Text('Apply'),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 80, vertical: 12),
                            )),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
