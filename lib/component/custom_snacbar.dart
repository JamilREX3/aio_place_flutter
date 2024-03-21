import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class CustomSnackbar {
  static void show(
      {dio.Response? response,
        String? title,
        Color? colorText,
        String? description,
        Color backgroundColor = Colors.red}) {
    // Set default background color based on theme
    backgroundColor ??= Get.isDarkMode ? Colors.indigo : Colors.purple;

    // Check if response is not null
    if(response?.statusCode==204){
      backgroundColor = Colors.indigo;
      title = 'Successes';
      description = 'Deleted successfully';
    }


    else if (response != null && response.data!=null) {
      // print(response.data);
      // Check if response contains an 'errors' array
      if (response.data['errors'] != null && response.data['errors'].isNotEmpty) {
        // Get the first error from the 'errors' array
        var error = response.data['errors'][0];
        backgroundColor = Colors.red;
        title = 'Failed';
        description = error['msg'];
      }
      // Check if status code starts with 4 or 5
      else if (response.statusCode.toString().startsWith(RegExp(r'[45]'))) {
        backgroundColor = Colors.red;
        title = 'Failed';
        description = response.data['msg'] ?? response.data['message'];
      } else {
        // If status code does not start with 4 or 5 and there are no errors, return without showing snackbar
        return;
      }
    }

    Get.snackbar(
      title ?? '',
      description ?? '',
      backgroundColor: backgroundColor,
      colorText : colorText ?? Colors.white,
    );
  }
}