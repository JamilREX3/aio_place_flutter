
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class AuthView extends StatelessWidget {
  const AuthView({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    Get.lazyPut(()=>AuthController());
    return Scaffold(
      body: GetBuilder<AuthController>(
        initState: (_) async{
          if (kDebugMode) {
            print('object');
          }
          var controller = Get.find<AuthController>();
          await controller.auth();
        },
        builder: (controller) =>
        const Center(child: CircularProgressIndicator()),
      ),
    );
  }}