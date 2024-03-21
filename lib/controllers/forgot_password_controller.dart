import 'package:aio_place/component/custom_snacbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/api_request.dart';
import '../views/login_view.dart';

class ForgotPasswordController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmationController = TextEditingController();

  var step = 1.obs;

  void sendEmail() async {
    if (_validateEmail()) {
      var response = await ApiRequest().post(
          path: '/auth/forgetpassword',
          authRequire: false,
          body: {
            'email': emailController.text,
          });
      if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
        step.value = 2;
      }
    }
  }

  void checkCode() async {
    print('checking');
    // If code is valid
    var response = await ApiRequest().post(
        path: '/auth/verifyResetCode',
        authRequire: false,
        body: {
          'resetCode': codeController.text,
        });
    if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
      step.value = 3;
    }
    // Else show CustomSnackbar with error message
  }

  void resetPassword() async {
    if (_validatePassword()) {
      // If newPassword and confirmation match
      var response = await ApiRequest().post(
          path: '/auth/resetPassword',
          authRequire: false,
          body: {
            'email': emailController.text,
            'newPassword': newPasswordController.text,
          });

      if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
        Get.offAll(LoginView());
      }
    }
      // Show CustomSnackbar with error message
  }

  bool _validateEmail() {
    if (GetUtils.isEmail(emailController.text)) {
      return true;
    } else {
      CustomSnackbar.show(title: 'Error', description: 'Please enter a valid email');
      return false;
    }
  }

  bool _validatePassword() {
    if (newPasswordController.text.length < 6) {
      CustomSnackbar.show(title: 'Error', description: 'Password must be at least 6 characters');
      return false;
    }
    if (newPasswordController.text != confirmationController.text) {
      CustomSnackbar.show(title: 'Error', description: 'Passwords do not match');
      return false;
    }
    return true;
  }
}
