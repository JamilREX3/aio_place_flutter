import 'package:aio_place/models/brand_model.dart';
import 'package:aio_place/models/category_model.dart';
import 'package:aio_place/models/sub_category_model.dart';

class ProductModelReq {
  int? results;
  PaginationResult? paginationResult;
  List<ProductModel>? productsList;

  ProductModelReq({this.results, this.paginationResult, this.productsList});

  ProductModelReq.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    paginationResult = json['paginationResult'] != null
        ? PaginationResult.fromJson(json['paginationResult'])
        : null;
    if (json['data'] != null) {
      productsList = <ProductModel>[];
      json['data'].forEach((v) {
        productsList!.add(ProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results;
    if (paginationResult != null) {
      data['paginationResult'] = paginationResult!.toJson();
    }
    if (productsList != null) {
      data['data'] = productsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaginationResult {
  int? currentpage;
  int? limit;
  int? numberOfPages;
  int? next;

  PaginationResult(
      {this.currentpage, this.limit, this.numberOfPages, this.next});

  PaginationResult.fromJson(Map<String, dynamic> json) {
    currentpage = json['currentpage'];
    limit = json['limit'];
    numberOfPages = json['numberOfPages'];
    next = json['next'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentpage'] = currentpage;
    data['limit'] = limit;
    data['numberOfPages'] = numberOfPages;
    data['next'] = next;
    return data;
  }
}

class ProductModel {
  String? sId;
  String? title;
  String? slug;
  String? description;
  int? quantity;
  int? sold;
  num? price;
  num? priceAfterDiscount;
  List<String>? colors;
  List<String>? sizes;
  List<String>? images;
  CategoryModel? category;
  dynamic subcategories;
  int? ratingsQuantity;
  String? createdAt;
  String? updatedAt;
  String? imageCover;
  String? id;
  dynamic brand;
  bool? isInWishList;
  num? ratingsAverage;

  ProductModel(
      {this.sId,
      this.title,
      this.slug,
      this.description,
      this.quantity,
      this.sold,
      this.price,
      this.priceAfterDiscount,
      this.colors,
      this.sizes,
      this.images,
      this.category,
      this.subcategories,
      this.ratingsQuantity,
      this.createdAt,
      this.updatedAt,
      this.imageCover,
      this.id,
      this.isInWishList,
      this.ratingsAverage,
      this.brand});

  ProductModel.fromJson(Map<String, dynamic> json) {
    print(json['brand']);
    sId = json['_id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    quantity = json['quantity'];
    sold = json['sold'];
    price = json['price'];
    priceAfterDiscount = json['priceAfterDiscount'];
    if (json['colors'] != null) {
      colors = json['colors'].cast<String>();
    }
    if (json['sizes'] != null) {
      sizes = json['sizes'].cast<String>();
    }
    if(json['images']!=null){
      images = json['images'].cast<String>();
    }


    category = json['category'] != null
        ? CategoryModel.fromJson(json['category'])
        : null;
    // Check if subcategories is not empty before attempting to cast it
    if (json['subcategories'] != null &&
        (json['subcategories'] as List).isNotEmpty) {
      if (json['subcategories'][0] is Map) {
        subcategories = List<SubCategoryModel>.from(
            json['subcategories'].map((x) => SubCategoryModel.fromJson(x)));
      } else if (json['subcategories'][0] is String) {
        subcategories = List<String>.from(json['subcategories']);
      }
    }
    ratingsQuantity = json['ratingsQuantity'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    imageCover = json['imageCover'];
    id = json['id'];

    if (json['brand'] != null) {
      if (json['brand'] is Map) {
        brand = BrandModel.fromJson(json['brand']);
      } else if (json['brand'] is String) {
        brand = json['brand'];
      }
    }
    isInWishList = json['isInWishList'];
    ratingsAverage = json['ratingsAverage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['slug'] = slug;
    data['description'] = description;
    data['quantity'] = quantity;
    data['sold'] = sold;
    data['price'] = price;
    data['priceAfterDiscount'] = priceAfterDiscount;
    data['colors'] = colors;
    data['sizes'] = sizes;
    data['images'] = images;
    if (category != null) {
      data['category'] = category!.toJson();
    }
    data['subcategories'] = subcategories;
    data['ratingsQuantity'] = ratingsQuantity;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['imageCover'] = imageCover;
    data['id'] = id;
    if (brand != null) {
      data['brand'] = brand!.toJson();
    }
    data['isInWishList'] = isInWishList;
    data['ratingsAverage'] = ratingsAverage;
    return data;
  }
}
