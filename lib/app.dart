import 'package:curd_practice/feature/ui/screens/home_screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurdApp extends StatelessWidget {
  const CurdApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      getPages: [
        GetPage(name: '/home', page: () => HomeScreens()),
      ],
    );
  }
}
