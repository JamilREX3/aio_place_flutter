class CategoryModelReq {
  int? results;
  PaginationResult? paginationResult;
  List<CategoryModel>? categoriesList;

  CategoryModelReq({this.results, this.paginationResult, this.categoriesList});

  CategoryModelReq.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    paginationResult = json['paginationResult'] != null
        ? PaginationResult.fromJson(json['paginationResult'])
        : null;
    if (json['data'] != null) {
      categoriesList = <CategoryModel>[];
      json['data'].forEach((v) {
        categoriesList!.add(CategoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results;
    if (paginationResult != null) {
      data['paginationResult'] = paginationResult!.toJson();
    }
    if (categoriesList != null) {
      data['data'] = categoriesList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PaginationResult {
  int? currentPage;
  int? limit;
  int? numberOfPages;

  PaginationResult({this.currentPage, this.limit, this.numberOfPages});

  PaginationResult.fromJson(Map<String, dynamic> json) {
    currentPage = json['currentpage'];
    limit = json['limit'];
    numberOfPages = json['numberOfPages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currentpage'] = currentPage;
    data['limit'] = limit;
    data['numberOfPages'] = numberOfPages;
    return data;
  }
}

class CategoryModel {
  String? id;
  String? name;
  String? slug;
  String? createdAt;
  String? updatedAt;
  String? image;

  CategoryModel(
      {this.id,
        this.name,
        this.slug,
        this.createdAt,
        this.updatedAt,
        this.image});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    slug = json['slug'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['image'] = image;
    return data;
  }
}
