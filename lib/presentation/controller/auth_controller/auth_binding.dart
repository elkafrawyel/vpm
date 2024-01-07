import 'package:get/get.dart';

import '../../../data/repositories/auth_repository.dart';
import 'auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthRepositoryIml());
    Get.lazyPut(() => AuthController(Get.find<AuthRepositoryIml>()));
  }
}
