import 'package:aio_place/component/custom_snacbar.dart';

import 'package:aio_place/models/user_model.dart';
import 'package:aio_place/utils/api_request.dart';
import 'package:aio_place/views/auth_view.dart';
import 'package:aio_place/views/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var obscureText = true.obs;

  final dio = Dio();

  void login() async {
    if (_validateFields()) {
      print(emailController.text);
      print(passwordController.text);
      var response = await ApiRequest().get(
          path: '/auth/login',
          authRequire: false,
          body: {
            'email': emailController.text,
            'password': passwordController.text
          });
      if (response.statusCode == 200) {
        UserModelReq userModel = UserModelReq.fromJson(response.data);
        await GetStorage().write('token', userModel.token);
        Get.offAll(const AuthView());
      }
    }
  }

  bool _validateFields() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      CustomSnackbar.show(title:'Error', description: 'Please fill in all fields');
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
    return true;
  }

  void navigateToSignUp() {
    // Add your navigation logic here
    Get.to(SignUpView());
  }
}