import 'package:aio_place/models/user_model.dart';

class ReviewModelReq {
  int? results;
  PaginationResult? paginationResult;
  List<ReviewModel>? reviewsList;

  ReviewModelReq({this.results, this.paginationResult, this.reviewsList});
  ReviewModelReq.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    paginationResult = json['paginationResult'] != null
        ? PaginationResult.fromJson(json['paginationResult'])
        : null;
    if (json['data'] != null) {
      reviewsList = <ReviewModel>[];
      json['data'].forEach((v) {
        reviewsList!.add(ReviewModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results;
    if (paginationResult != null) {
      data['paginationResult'] = paginationResult!.toJson();
    }
    if (reviewsList != null) {
      data['data'] = reviewsList!.map((v) => v.toJson()).toList();
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

class ReviewModel {
  String? sId;
  String? title;
  num? ratings;
  UserModel? user;
  String? product;
  String? createdAt;
  String? updatedAt;

  ReviewModel(
      {this.sId,
        this.title,
        this.ratings,
        this.user,
        this.product,
        this.createdAt,
        this.updatedAt});

  ReviewModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    ratings = json['ratings'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    product = json['product'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['title'] = title;
    data['ratings'] = ratings;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['product'] = product;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}


