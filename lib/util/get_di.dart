import 'package:assignment_3/controller/home_controller.dart';
import 'package:assignment_3/data/repository/home_repo.dart';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';





import '../data/api/api_client.dart';

import '../database/db/database.dart';
import 'app_constants.dart';

Future<void> init() async {
/// this is dependency injection
  final db= await $FloorAssignment3Database
      .databaseBuilder('glorious.db')
      .build();

  await Hive.initFlutter();
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL ));

  //repo
  Get.lazyPut(() => HomeRepo(apiClient: Get.find(), database: db ));
  //controller
  Get.lazyPut(() => HomeController( homeRepo: Get.find()));








}
