import 'package:aio_place/models/product_model.dart';

class CartModelReq {
  int? result;
  CartModel? cartModel;

  CartModelReq({this.result, this.cartModel});

  CartModelReq.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    cartModel = json['data'] != null ? CartModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    if (cartModel != null) {
      data['data'] = cartModel!.toJson();
    }
    return data;
  }
}

class CartModel {
  String? sId;
  List<CartItems>? cartItems;
  String? user;
  String? createdAt;
  String? updatedAt;
  int? iV;
  num? totalCartPrice;
  num? totalPriceAfterDiscount;

  CartModel(
      {this.sId,
      this.cartItems,
      this.user,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.totalCartPrice,
      this.totalPriceAfterDiscount});

  CartModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    if (json['cartItems'] != null) {
      cartItems = <CartItems>[];
      json['cartItems'].forEach((v) {
        cartItems!.add(CartItems.fromJson(v));
      });
    }
    user = json['user'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    totalCartPrice = json['totalCartPrice'];
    totalPriceAfterDiscount = json['totalPriceAfterDiscount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (cartItems != null) {
      data['cartItems'] = cartItems!.map((v) => v.toJson()).toList();
    }
    data['user'] = user;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    data['totalCartPrice'] = totalCartPrice;
    data['totalPriceAfterDiscount'] = totalPriceAfterDiscount;
    return data;
  }
}

class CartItems {
  ProductModel? product;
  int? quantity;
  String? color;
  String? size;
  num? price;
  String? sId;

  CartItems(
      {this.product,
      this.quantity,
      this.color,
      this.size,
      this.price,
      this.sId});

  CartItems.fromJson(Map<String, dynamic> json) {
    product =
        json['product'] != null ? ProductModel.fromJson(json['product']) : null;
    quantity = json['quantity'];
    color = json['color'];
    size = json['size'];
    price = json['price'];
    sId = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['quantity'] = quantity;
    data['color'] = color;
    data['size'] = size;
    data['price'] = price;
    data['_id'] = sId;
    return data;
  }
}
