class SubCategoryReq {
  int? results;
  PaginationResult? paginationResult;
  List<SubCategoryModel>? subCategoriesList;

  SubCategoryReq({this.results, this.paginationResult, this.subCategoriesList});

  SubCategoryReq.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    paginationResult = json['paginationResult'] != null
        ? PaginationResult.fromJson(json['paginationResult'])
        : null;
    if (json['data'] != null) {
      subCategoriesList = <SubCategoryModel>[];
      json['data'].forEach((v) {
        subCategoriesList!.add(SubCategoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results;
    if (paginationResult != null) {
      data['paginationResult'] = paginationResult!.toJson();
    }
    if (subCategoriesList != null) {
      data['data'] = subCategoriesList!.map((v) => v.toJson()).toList();
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

class SubCategoryModel {
  String? id;
  String? name;
  String? slug;
  String? category;
  String? createdAt;
  String? updatedAt;

  SubCategoryModel(
      {this.id,
        this.name,
        this.slug,
        this.category,
        this.createdAt,
        this.updatedAt});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    slug = json['slug'];
    category = json['category'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['slug'] = slug;
    data['category'] = category;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
