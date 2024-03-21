import 'package:aio_place/component/category_card.dart';
import 'package:aio_place/controllers/all_category_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AllCategoryView extends StatefulWidget {
  const AllCategoryView({Key? key}) : super(key: key);

  @override
  _AllCategoryViewState createState() => _AllCategoryViewState();
}

class _AllCategoryViewState extends State<AllCategoryView> {
  // final ScrollController _scrollController = ScrollController();
  final AllCategoryController _allCategoryController =
  Get.put(AllCategoryController());

  // @override
  // void initState() {
  //   super.initState();
  //   _scrollController.addListener(_onScroll);
  // }
  //
  // @override
  // void dispose() {
  //   _scrollController.dispose();
  //   super.dispose();
  // }
  //
  // void _onScroll() {
  //   print(_scrollController.position.pixels);
  //   if (_scrollController.position.pixels ==
  //       _scrollController.position.maxScrollExtent) {
  //     // Load more categories when user scrolls to bottom
  //     _allCategoryController.loadMoreCategories();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Categories',
          style: GoogleFonts.lobsterTwo(
              fontSize: 35, fontStyle: FontStyle.italic),
        ),
      ),
      body:  Obx(()=>GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3
            ,
            crossAxisSpacing: 5,
            mainAxisSpacing: 6),
        //shrinkWrap: true,
        //physics: const NeverScrollableScrollPhysics(),
        itemCount: _allCategoryController.categories.length,
        itemBuilder: (context, index) {
          if (index == _allCategoryController.categories.length - 1) {
            _allCategoryController.fetchMore();
          }
          return CategoryCard(categoryModel: _allCategoryController.categories[index]);
        },
      )),
    );
  }
}