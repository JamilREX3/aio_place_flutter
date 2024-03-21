import 'package:aio_place/models/category_model.dart';

class BrandModelReq {
  int? results;
  PaginationResult? paginationResult;
  List<BrandModel>? brandsList;

  BrandModelReq({this.results, this.paginationResult, this.brandsList});

  BrandModelReq.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    paginationResult = json['paginationResult'] != null
        ? PaginationResult.fromJson(json['paginationResult'])
        : null;
    if (json['data'] != null) {
      brandsList = <BrandModel>[];
      json['data'].forEach((v) {
        brandsList!.add(BrandModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results;
    if (paginationResult != null) {
      data['paginationResult'] = paginationResult!.toJson();
    }
    if (brandsList != null) {
      data['data'] = brandsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaginationResult {
  int? currentpage;
  int? limit;
  int? numberOfPages;

  PaginationResult({this.currentpage, this.limit, this.numberOfPages});

  PaginationResult.fromJson(Map<String, dynamic> json) {
    currentpage = json['currentpage'];
    limit = json['limit'];
    numberOfPages = json['numberOfPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentpage'] = currentpage;
    data['limit'] = limit;
    data['numberOfPages'] = numberOfPages;
    return data;
  }
}

class BrandModel {
  String? id;
  String? name;
  String? slug;
  List<dynamic>? categories;
  String? createdAt;
  String? updatedAt;

  BrandModel(
      {this.id,
        this.name,
        this.slug,
        this.categories,
        this.createdAt,
        this.updatedAt});

  BrandModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    slug = json['slug'];
    if (json['categories'] != null) {
      if (json['categories'][0] is Map) {
        categories = List<CategoryModel>.from(
            json['categories'].map((x) => CategoryModel.fromJson(x))
        );
      } else if (json['categories'][0] is String) {
        categories = List<String>.from(json['categories']);
      }
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['categories'] = categories;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
