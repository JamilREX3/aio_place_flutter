import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../component/customTextField.dart';
import '../controllers/forgot_password_controller.dart';



class ForgotPasswordView extends StatelessWidget {
  final ForgotPasswordController controller = Get.put(ForgotPasswordController());

  ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() {
          if (controller.step.value == 1) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Step 1: Enter your email'),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomTextFormField(
                    controller: controller.emailController,
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.sendEmail(),
                  child: const Text('Submit'),
                ),
              ],
            );
          } else if (controller.step.value == 2) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Step 2: Enter the code you received'),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: controller.codeController,
                  hintText: 'Code',
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.checkCode(),
                  child: const Text('Submit'),
                ),
              ],
            );
          } else if (controller.step.value == 3) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Step 3: Enter your new password'),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: controller.newPasswordController,
                  hintText: 'New Password',
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                CustomTextFormField(
                  controller: controller.confirmationController,
                  hintText: 'Confirmation',
                  obscureText: true,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.resetPassword(),
                  child: const Text('Submit'),
                ),
              ],
            );
          }
          return Container();
        }),
      ),
    );
  }
}