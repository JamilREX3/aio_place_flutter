import 'package:aio_place/themes/primary_themes.dart';
import 'package:aio_place/views/auth_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'bindings.dart';



void main() async{
  await GetStorage.init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    //statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: Binding(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      darkTheme: darkTheme,
      theme: lightTheme,
      home: const AuthView(),
    );
  }
}
