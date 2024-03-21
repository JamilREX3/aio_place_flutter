import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../component/confirm_delete_dialog1.dart';
import '../component/customTextField.dart';
import '../controllers/my_addresses_controller.dart';

class MyAddressView extends StatelessWidget {
  const MyAddressView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(MyAddressController());
    return GetBuilder<MyAddressController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          // title: const Text('My Addresses'),
          title: Text(
            'My Addresses',
            style: GoogleFonts.lobsterTwo(
                fontSize: 30, fontStyle: FontStyle.italic),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: controller.addressList.length,
                  itemBuilder: (context, index) {
                    final address = controller.addressList[index];
                    //final theme = Theme.of(context);
                    //final isDark = theme.brightness == Brightness.dark;
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [
                            Colors.indigoAccent.shade700,
                            Colors.indigoAccent.shade100
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Card(
                        color: Colors.transparent,
                        elevation: 0,
                        child: ListTile(
                          title: Text(address.alias ?? '',
                              style: const TextStyle(color: Colors.white)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(children: [
                                const Icon(Icons.home, color: Colors.white),
                                const SizedBox(width: 8.0),
                                Text(address.details ?? '',
                                    style: const TextStyle(color: Colors.white)),
                              ]),
                              Row(children: [
                                const Icon(Icons.phone, color: Colors.white),
                                const SizedBox(width: 8.0),
                                Text(address.phone ?? '',
                                    style: const TextStyle(color: Colors.white)),
                              ]),
                              Row(children: [
                                const Icon(Icons.location_city, color: Colors.white),
                                const SizedBox(width: 8.0),
                                Text(address.city ?? '',
                                    style: const TextStyle(color: Colors.white)),
                              ]),
                              Row(children: [
                                const Icon(Icons.mail, color: Colors.white),
                                const SizedBox(width: 8.0),
                                Text(address.postalCode ?? '',
                                    style: const TextStyle(color: Colors.white)),
                              ]),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.white),
                            onPressed: () => Get.dialog(ConfirmDeleteDialog(
                              title: 'Confirm Delete',
                              content:
                                  'Are you sure you want to delete this address?',
                              onDelete: () =>
                                  controller.deleteAddress(address.id),
                            )),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () => Get.dialog(AddAddressDialog()),
                  child: const Text('Add Address'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddAddressDialog extends StatelessWidget {
  final MyAddressController controller = Get.find();

  AddAddressDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      title: const Text('Add Address'),
      content: SingleChildScrollView(
        child: Obx(() => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (controller.loading.value) const LinearProgressIndicator(),
                CustomTextFormField(
                  contentPadding: const EdgeInsets.all(12),
                  controller: controller.aliasController,
                  hintText: 'Alias',
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  contentPadding: const EdgeInsets.all(12),
                  controller: controller.detailsController,
                  hintText: 'Details',
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  contentPadding: const EdgeInsets.all(12),
                  controller: controller.phoneController,
                  hintText: 'Phone',
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  contentPadding: const EdgeInsets.all(12),
                  controller: controller.cityController,
                  hintText: 'City',
                ),
                const SizedBox(height: 10),
                CustomTextFormField(
                  contentPadding: const EdgeInsets.all(12),
                  controller: controller.postalCodeController,
                  hintText: 'Postal Code',
                  keyboardType: TextInputType.number,
                )
              ],
            )),
      ),
      actions: [
        TextButton(
            onPressed: () async {
              await controller.addAddress();
            },
            child: const Text('Add Address')),
      ],
    );
  }
}
