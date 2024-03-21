import 'package:aio_place/component/confirm_delete_dialog1.dart';
import 'package:aio_place/views/login_view.dart';
import 'package:aio_place/views/my_addresses_view.dart';
import 'package:aio_place/views/reset_password_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import '../component/customTextField.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return GetBuilder<ProfileController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: (){
              Get.dialog(ConfirmDeleteDialog(title: 'Logout', content: 'Are you sure that you want to logout from this Account', onDelete: ()async{
                await GetStorage().erase();
                Get.offAll(LoginView());
              }));
            }, icon: const Icon(Icons.output_rounded))
          ],
          centerTitle: true,
          title: Text(
            'Profile',
            style: GoogleFonts.lobsterTwo(
                fontSize: 35, fontStyle: FontStyle.italic),
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Obx(() => controller.loading.value == true
                  ? const LinearProgressIndicator(
                      color: Colors.indigoAccent,
                    )
                  : const SizedBox()),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: controller.pickImage,
                          child: CircleAvatar(
                            backgroundImage: (controller.image != null
                                    ? FileImage(controller.image!)
                                    : (controller.userModel.profileImg != null
                                        ? NetworkImage(
                                            controller.userModel.profileImg!)
                                        : const NetworkImage(
                                            'https://www.w3schools.com/howto/img_avatar.png')))
                                as ImageProvider,
                            radius: 50,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        CustomTextFormField(
                          hintText: 'Email',
                          prefixIcon: Icons.email,
                          controller: controller.emailController,
                          labelText: 'Email',
                          enabled: false,
                        ),
                        const SizedBox(height: 16.0),
                        CustomTextFormField(
                          hintText: 'Name',
                          prefixIcon: Icons.person,
                          controller: controller.nameController,
                          labelText: 'Name',
                        ),
                        const SizedBox(height: 16.0),
                        CustomTextFormField(
                          hintText: 'Phone',
                          prefixIcon: Icons.phone,
                          keyboardType: const TextInputType.numberWithOptions(
                              decimal: true),
                          controller: controller.phoneController,
                          labelText: 'Phone',
                        ),
                        const SizedBox(height: 16.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Get.dialog(ResetPasswordDialog());
                              },
                              child: const Text('Reset Password'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Get.to(const MyAddressView());
                              },
                              child: const Text('My Addresses'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed:
                              controller.hasChanges ? controller.submit : null,
                          child: const Text('Submit'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
