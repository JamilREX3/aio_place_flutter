import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../component/customTextField.dart';
import '../controllers/signup_controller.dart';


class SignUpView extends StatelessWidget {
  final SignUpController controller = Get.put(SignUpController());

  SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 120),
                  Text(
                    'Sign Up',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextFormField(
                          hintText: 'Name',
                          prefixIcon: Icons.person,
                          controller: controller.nameController,
                          labelText: 'Name',
                        ),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        child: CustomTextFormField(
                          hintText: 'Phone',
                          prefixIcon: Icons.phone,
                          keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                          controller: controller.phoneController,
                          labelText: 'Phone',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextFormField(
                    hintText: 'Email',
                    prefixIcon: Icons.email,
                    controller: controller.emailController,
                    labelText: 'Email',
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextFormField(
                    hintText: 'Password',
                    prefixIcon: Icons.lock,
                    keyboardType: TextInputType.visiblePassword,
                    controller: controller.passwordController,
                    obscureText: true,
                    labelText: 'Password',
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextFormField(
                    hintText: 'Confirm Password',
                    prefixIcon: Icons.lock,
                    keyboardType: TextInputType.visiblePassword,
                    controller: controller.passwordConfirmController,
                    obscureText: true,
                    labelText: 'Confirm Password',
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: controller.signUp,
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}