import 'package:aio_place/views/forgot_password_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../component/customTextField.dart';
import '../controllers/login_controller.dart';

class LoginView extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
  LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login',
                style: Theme.of(context).textTheme.headlineMedium,
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
              const SizedBox(height: 8.0),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                   Get.to(ForgotPasswordView());
                  },
                  child: const Text('Forgot Password?'),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: controller.login,
                child: const Text('Login'),
              ),
              const SizedBox(height: 8.0),
              TextButton(
                onPressed: controller.navigateToSignUp,
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}