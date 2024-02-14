import 'package:get/get.dart';
import 'package:vpm/presentation/controller/parking_controller/parking_controller.dart';
import 'package:vpm/presentation/controller/profile_controller/profile_controller.dart';
import 'package:vpm/presentation/controller/services_controller/services_controller.dart';

import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/lookups_repository.dart';
import 'home_screen_controller.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    //home screen controller
    Get.lazyPut(() => HomeScreenController());
    //todo add repo
    //parking controller
    Get.lazyPut(() => ParkingController());
    //todo add repo
    //services controller
    Get.lazyPut(() => ServicesController());

    // profile controller
    Get.lazyPut(() => AuthRepositoryIml());
    Get.lazyPut(() => LookUpsRepositoryIml());
    Get.lazyPut(() => ProfileController(Get.find<AuthRepositoryIml>(),Get.find<LookUpsRepositoryIml>()));
  }
}
