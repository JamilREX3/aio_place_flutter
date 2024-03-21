import 'package:aio_place/component/custom_snacbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/address_model.dart';
import '../utils/api_request.dart';

class MyAddressController extends GetxController {
  List<AddressModel> addressList = [];
  TextEditingController aliasController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController postalCodeController = TextEditingController();
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAddresses();
  }

  Future<void> fetchAddresses() async {
    var response = await ApiRequest().get(path: '/addresses');
    if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
      var addressModelReq = AddressModelReq.fromJson(response.data);
      addressList = addressModelReq.addressList ?? [];
      update();
    }
  }

  Future<void> deleteAddress(String? id) async {
    if (id != null) {
      var response =
      await ApiRequest().delete(path: '/addresses/$id');
      if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
        fetchAddresses();
      }
    }
  }

  bool validate() {
    if (aliasController.text.isEmpty ||
        detailsController.text.isEmpty ||
        phoneController.text.isEmpty ||
        cityController.text.isEmpty ||
        postalCodeController.text.isEmpty) {
      CustomSnackbar.show(title: 'Error', description: 'Please fill in all fields');
      return false;
    }
    if (!GetUtils.isPhoneNumber(phoneController.text)) {
      CustomSnackbar.show(title: 'Error', description: 'Please enter a valid phone number');
      return false;
    }
    return true;
  }

  Future<void> addAddress() async {
    if (validate()) {
      loading.value = true;
      Map<String, dynamic> body = {
        'alias': aliasController.text,
        'details': detailsController.text,
        'phone': phoneController.text,
        'city': cityController.text,
        'postalCode': postalCodeController.text,
      };
      var response =
      await ApiRequest().post(path:
      '/addresses', body:
      body);
      if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
        aliasController.clear();
        detailsController.clear();
        phoneController.clear();
        cityController.clear();
        postalCodeController.clear();
        Get.back();
        fetchAddresses();
      }
      loading.value = false;
    }
  }
}