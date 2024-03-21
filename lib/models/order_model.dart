import 'package:aio_place/models/address_model.dart';
import 'package:aio_place/models/cart_model.dart';
import 'package:aio_place/models/user_model.dart';

class OrderModelReq {
  int? results;
  PaginationResult? paginationResult;
  List<OrderModel>? ordersList;

  OrderModelReq({this.results, this.paginationResult, this.ordersList});

  OrderModelReq.fromJson(Map<String, dynamic> json) {
    results = json['results'];
    paginationResult = json['paginationResult'] != null
        ? PaginationResult.fromJson(json['paginationResult'])
        : null;
    if (json['data'] != null) {
      ordersList = <OrderModel>[];
      json['data'].forEach((v) {
        ordersList!.add(OrderModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['results'] = results;
    if (paginationResult != null) {
      data['paginationResult'] = paginationResult!.toJson();
    }
    if (ordersList != null) {
      data['data'] = ordersList!.map((v) => v.toJson()).toList();
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

class OrderModel {
  AddressModel? shippingAddress;
  String? sId;
  UserModel? user;
  List<CartItems>? cartItems;
  int? taxPrice;
  int? shippingPrice;
  num? totalOrderPrice;
  String? paymentMethod;
  bool? isPaid;
  bool? isDelivered;
  String? createdAt;
  String? updatedAt;

  OrderModel(
      {this.shippingAddress,
      this.sId,
      this.user,
      this.cartItems,
      this.taxPrice,
      this.shippingPrice,
      this.totalOrderPrice,
      this.paymentMethod,
      this.isPaid,
      this.isDelivered,
      this.createdAt,
      this.updatedAt,
      });

  OrderModel.fromJson(Map<String, dynamic> json) {
    shippingAddress = json['shippingAddress'] != null
        ? AddressModel.fromJson(json['shippingAddress'])
        : null;
    sId = json['_id'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    if (json['cartItems'] != null) {
      cartItems = <CartItems>[];
      json['cartItems'].forEach((v) {
        cartItems!.add(CartItems.fromJson(v));
      });
    }
    taxPrice = json['taxPrice'];
    shippingPrice = json['shippingPrice'];
    totalOrderPrice = json['totalOrderPrice'];
    paymentMethod = json['paymentMethod'];
    isPaid = json['isPaid'];
    isDelivered = json['isDelivered'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (shippingAddress != null) {
      data['shippingAddress'] = shippingAddress!.toJson();
    }
    data['_id'] = sId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (cartItems != null) {
      data['cartItems'] = cartItems!.map((v) => v.toJson()).toList();
    }
    data['taxPrice'] = taxPrice;
    data['shippingPrice'] = shippingPrice;
    data['totalOrderPrice'] = totalOrderPrice;
    data['paymentMethod'] = paymentMethod;
    data['isPaid'] = isPaid;
    data['isDelivered'] = isDelivered;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
