import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConfirmDeleteDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onDelete;
  final String confirmString;
  final String cancelString;

  const ConfirmDeleteDialog(
      {Key? key,
      required this.title,
        this.cancelString = 'Cancel',
        this.confirmString = 'Confirm',
      required this.content,
      required this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed:
            () => Get.back(),
          child:
          Text(cancelString)),
        TextButton(
          onPressed:
            () {
            onDelete();
            Get.back();
          },
          child:
             Text(confirmString)),
      ],
    );
  }
}