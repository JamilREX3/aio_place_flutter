class AddressModelReq {
  String? status;
  int? results;
  List<AddressModel>? addressList;

  AddressModelReq({this.status, this.results, this.addressList});

  AddressModelReq.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    results = json['results'];
    if (json['data'] != null) {
      addressList = <AddressModel>[];
      json['data'].forEach((v) {
        addressList!.add(AddressModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['results'] = results;
    if (addressList != null) {
      data['data'] = addressList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddressModel {
  String? alias;
  String? details;
  String? phone;
  String? city;
  String? postalCode;
  String? id;

  AddressModel(
      {this.alias,
        this.details,
        this.phone,
        this.city,
        this.postalCode,
        this.id});

  AddressModel.fromJson(Map<String, dynamic> json) {
    alias = json['alias'];
    details = json['details'];
    phone = json['phone'];
    city = json['city'];
    postalCode = json['postalCode'];
    id = json['_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['alias'] = alias;
    data['details'] = details;
    data['phone'] = phone;
    data['city'] = city;
    data['postalCode'] = postalCode;
    data['_id'] = id;
    return data;
  }
}
