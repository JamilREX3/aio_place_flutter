import 'package:aio_place/component/custom_snacbar.dart';
import 'package:aio_place/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../component/customTextField.dart';
import '../utils/api_request.dart';

class ResetPasswordDialog extends StatelessWidget {
  final TextEditingController currentPasswordController =
  TextEditingController();
  final TextEditingController newPasswordController =
  TextEditingController();
  final TextEditingController newPasswordConfirmController =
  TextEditingController();
  final RxBool loading = false.obs;

  ResetPasswordDialog({super.key});

  bool validate() {
    if (currentPasswordController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        newPasswordConfirmController.text.isEmpty) {
      CustomSnackbar.show(title: 'Error',description:  'Please fill in all fields');
      return false;
    }
    if (newPasswordController.text !=
        newPasswordConfirmController.text) {
      CustomSnackbar.show(title: 'Error',description:  'New passwords do not match');
      return false;
    }
    return true;
  }

  Future<void> resetPassword() async {
    if (validate()) {
      loading.value = true;
      Map<String, dynamic> body = {
        'currentPassword': currentPasswordController.text,
        'password': newPasswordController.text,
      };
      var response = await ApiRequest().put(
          path: '/users/changeMyPassword', body: body);
      if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
        UserModelReq userModelReq = UserModelReq.fromJson(response.data);
        GetStorage().write('token', userModelReq.token);
        Get.back();
        CustomSnackbar.show(title: 'Done',description: 'the password has been changed',backgroundColor: Colors.indigo);
      }
      loading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      
      title: const Text('Reset Password'),
      content: SingleChildScrollView(
        child: Obx(() => Column(
          mainAxisSize:
          MainAxisSize.min,
          children:
          [
            if (loading.value)
              const LinearProgressIndicator(),
            CustomTextFormField(
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              controller:
              currentPasswordController,
              labelText:
              'Current Password',
              obscureText:
              true,
              prefixIcon: Icons.password,
              prefixIconsSize: 16,
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              controller:
              newPasswordController,
              labelText:
              'New Password',
              obscureText:
              true,
              prefixIcon: Icons.lock,
              prefixIconsSize: 16,
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              controller:
              newPasswordConfirmController,
              labelText:
              'Confirm',
              obscureText:
              true,
              prefixIcon: Icons.lock,
              prefixIconsSize: 16,
            )
          ],
        )),
      ),
      actions: [
        TextButton(
            onPressed:
                () => Get.back(),
            child:
            const Text('Cancel')),
        TextButton(
            onPressed:
            resetPassword,
            child:
            const Text('Reset Password')),
      ],
    );
  }
}