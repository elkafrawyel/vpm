import 'package:get/get.dart';
import 'package:vpm/presentation/controller/my_cars_controller/my_cars_controller.dart';
import 'package:vpm/presentation/controller/profile_controller/profile_controller.dart';

import 'home_screen_controller.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeScreenController());
    Get.lazyPut(() => ProfileController());
  }
}
