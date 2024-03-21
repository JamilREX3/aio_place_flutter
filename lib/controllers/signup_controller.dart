import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../component/custom_snacbar.dart';
import '../models/user_model.dart';
import '../utils/api_request.dart';
import '../views/auth_view.dart';
class SignUpController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordConfirmController =
  TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  void signUp() async {
    if (_validateFields()) {
      var response = await ApiRequest().post(
          path: '/auth/signup',
          authRequire: false,
          body: {
            'name' : nameController.text,
            'phone' : phoneController.text,
            'email': emailController.text,
            'password': passwordController.text,
            'passwordConfirm' : passwordConfirmController.text,
          });
      if (response.statusCode == 201) {
        UserModelReq userModel = UserModelReq.fromJson(response.data);
        await GetStorage().write('token', userModel.token);
        Get.offAll(const AuthView());
      }
    }
  }

  bool _validateFields() {
    if (nameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        passwordConfirmController.text.isEmpty ||
        phoneController.text.isEmpty) {
      CustomSnackbar.show(title: 'Error', description: 'Please fill in all fields');
      return false;
    }
    if (!GetUtils.isEmail(emailController.text)) {
      CustomSnackbar.show(title:'Error', description: 'Please enter a valid email');
      return false;
    }
    if (passwordController.text.length < 6) {
      CustomSnackbar.show(title:'Error', description: 'Password must be at least 6 characters');
      return false;
    }
    if (passwordController.text != passwordConfirmController.text) {
      CustomSnackbar.show(title:'Error', description: 'Passwords do not match');
      return false;
    }
    return true;
  }
}