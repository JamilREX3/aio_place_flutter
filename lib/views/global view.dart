import 'package:aio_place/controllers/global_controller.dart';
import 'package:aio_place/views/profile_view.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/user_model.dart';

class GlobalView extends StatelessWidget {
  final UserModel userModel;
  const GlobalView({Key? key, required this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(GlobalController(userModel));
    return GetBuilder<GlobalController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: GestureDetector(
            onTap: (){
              Get.to(const ProfileView());
            },
            child: Container(
              padding: const EdgeInsets.only(left: 7,right: 7,top: 7,bottom: 3),
              child: Obx(() => CircleAvatar(
                backgroundImage:
                controller.userModel.value.profileImg != null
                    ? NetworkImage(controller.userModel.value.profileImg!)
                    : const NetworkImage('https://www.w3schools.com/howto/img_avatar.png'),
              )),
            ),
          ),
          title: Obx(() =>Text(controller.title.value,style: GoogleFonts.lobsterTwo(fontSize: 35,fontStyle: FontStyle.italic),)),
        ),
        extendBody: true,
        bottomNavigationBar: CurvedNavigationBar(
          index: controller.index.value,
          backgroundColor: Colors.transparent,
          color: Theme.of(context).bottomNavigationBarTheme.backgroundColor!,
          buttonBackgroundColor:
              Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
          onTap: (value) {
            controller.changeIndex(value);
            controller.navBarTrigger(value);
          },
          // buttonBackgroundColor: Colors.purple,
          items: [
            Obx(() => Icon(Icons.home,
                color:
                    controller.index.value == 0 ? Theme.of(context).bottomNavigationBarTheme.backgroundColor :Theme.of(context).bottomNavigationBarTheme.unselectedItemColor)),
            Obx(() => Icon(Icons.shopping_cart_rounded,
                color:
                    controller.index.value == 1 ? Theme.of(context).bottomNavigationBarTheme.backgroundColor :Theme.of(context).bottomNavigationBarTheme.unselectedItemColor)),

            Obx(() => Icon(Icons.search_rounded,
                color:
                controller.index.value == 2 ? Theme.of(context).bottomNavigationBarTheme.backgroundColor :Theme.of(context).bottomNavigationBarTheme.unselectedItemColor)),


            //todo icon need to edit
            Obx(() => Icon(Icons.favorite,
                color:
                    controller.index.value == 3 ? Theme.of(context).bottomNavigationBarTheme.backgroundColor :Theme.of(context).bottomNavigationBarTheme.unselectedItemColor)),
            Obx(() => Icon(Icons.payment,
                color:
                    controller.index.value == 4 ? Theme.of(context).bottomNavigationBarTheme.backgroundColor :Theme.of(context).bottomNavigationBarTheme.unselectedItemColor)),
          ],
        ),
        body: SafeArea(bottom: false,child: Obx(() => controller.screens[controller.index.value])),
      ),
    );
  }
}
