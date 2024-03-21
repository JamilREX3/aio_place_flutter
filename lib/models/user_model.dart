


class UserModelReq {
  UserModel? userModel;
  String? token;
  UserModelReq({this.userModel, this.token});
  UserModelReq.fromJson(Map<String, dynamic> json) {
    userModel = json['data'] != null ? UserModel.fromJson(json['data']) : null;
    token = json['token'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (userModel != null) {
      data['data'] = userModel!.toJson();
    }
    data['token'] = token;
    return data;
  }
}

class UserModel {
  String? name;
  String? email;
  String? phone;
  String? profileImg;
  String? password;
  String? role;
  bool? active;
  //List<Null>? wishlist;
  String? id;
  //List<AddressModel>? addresses;
  String? createdAt;
  String? updatedAt;

  UserModel(
      {this.name,
        this.email,
        this.phone,
        this.profileImg,
        this.password,
        this.role,
        this.active,
        //this.wishlist,
        this.id,
        //this.addresses,
        this.createdAt,
        this.updatedAt,
        });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    profileImg = json['profileImg'];
    password = json['password'];
    role = json['role'];
    active = json['active'];
    // if (json['wishlist'] != null) {
    //   wishlist = <Null>[];
    //   json['wishlist'].forEach((v) {
    //     wishlist!.add(new Null.fromJson(v));
    //   });
    // }
    id = json['_id'];
    // if (json['addresses'] != null) {
    //   addresses = <AddressModel>[];
    //   json['addresses'].forEach((v) {
    //     addresses!.add(AddressModel.fromJson(v));
    //   });
    // }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['profileImg'] = profileImg;
    data['password'] = password;
    data['role'] = role;
    data['active'] = active;
    // if (this.wishlist != null) {
    //   data['wishlist'] = this.wishlist!.map((v) => v.toJson()).toList();
    // }
    data['_id'] = id;
    // if (this.addresses != null) {
    //   data['addresses'] = this.addresses!.map((v) => v.toJson()).toList();
    // }
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}


