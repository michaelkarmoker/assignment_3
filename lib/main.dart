
import 'package:assignment_3/util/app_constants.dart';
import 'package:assignment_3/util/get_di.dart';
import 'package:assignment_3/view/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(  MyApp());
}



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: AppConstants.APP_NAME,
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.key,
      home: HomeScreen(),
      defaultTransition: Transition.topLevel,
      transitionDuration: Duration(milliseconds: 500),
    );
  }
}
