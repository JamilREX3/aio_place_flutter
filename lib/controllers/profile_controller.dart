import 'dart:io';
import 'package:aio_place/component/custom_snacbar.dart';
import 'package:aio_place/controllers/global_controller.dart';
import 'package:aio_place/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../utils/api_request.dart';

class ProfileController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  File? image;
  bool hasChanges = false;

  late UserModel userModel;
  var loading = false.obs;


  profileControllerInitialize(){
    userModel = Get.find<GlobalController>().userModel.value;
    nameController.text = userModel.name!;
    phoneController.text = userModel.phone??'';
    emailController.text = userModel.email!;
    nameController.addListener(checkForChanges);
    phoneController.addListener(checkForChanges);
  }

  @override
  void onInit() {
    print('iniiiiiiiiiiiiiiiting profile controller');
    super.onInit();
    profileControllerInitialize();
  }

  void checkForChanges() {
    hasChanges = (nameController.text != userModel.name ||
        phoneController.text != userModel.phone ||
        image != null);
    update();
  }

  Future<void> pickImage() async {
    final XFile? pickedFile =
    await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      checkForChanges();
    }
  }

  bool validate() {
    if (nameController.text.isEmpty || phoneController.text.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields');
      return false;
    }
    if (!GetUtils.isPhoneNumber(phoneController.text)) {
      Get.snackbar('Error', 'Please enter a valid phone number');
      return false;
    }
    return true;
  }

  Future<void> submit() async {
    loading.value = true;
    if (hasChanges && validate()) {
      Map<String, dynamic> body = {};
      if (nameController.text != userModel.name) {
        body['name'] = nameController.text;
      }
      if (phoneController.text != userModel.phone) {
        body['phone'] = phoneController.text;
      }
      if (image != null) {
        body['profileImg'] = image;
      }
      var response = await ApiRequest().put(
          path: '/users/changeMe', body: body);
      if (response.statusCode.toString().startsWith(RegExp(r'2'))) {
        var newUserModel = UserModelReq.fromJson(response.data).userModel;
        Get.find<GlobalController>().userModel.value = newUserModel!;
        profileControllerInitialize();
        CustomSnackbar.show(title: 'Done' , description: 'user information updated' , backgroundColor: Colors.indigo);
      }
    }
    loading.value = false;
  }
}