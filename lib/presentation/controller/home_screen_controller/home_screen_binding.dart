import 'package:get/get.dart';
import 'package:vpm/data/repositories/booking_repository.dart';
import 'package:vpm/data/repositories/garages_repository.dart';
import 'package:vpm/presentation/controller/booking_controller.dart';
import 'package:vpm/presentation/controller/notifications_controller.dart';
import 'package:vpm/presentation/controller/parking_controller.dart';
import 'package:vpm/presentation/controller/profile_controller.dart';

import '../../../app/res/res.dart';
import '../../../data/repositories/auth_repository.dart';
import '../../../data/repositories/lookups_repository.dart';
import '../../../domain/entities/models/advertisementModel.dart';
import '../../../domain/entities/models/notifications_model.dart';
import '../advertisements_controller.dart';
import '../my_controllers/pagination_controller/data/config_data.dart';
import 'home_screen_controller.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    //home screen controller
    Get.lazyPut(() => HomeScreenController());
    //todo add repo
    //parking controller
    Get.lazyPut(() => GaragesRepositoryImpl());
    Get.lazyPut(() => ParkingController(Get.find<GaragesRepositoryImpl>()));
    //services controller

    Get.lazyPut(
      () => AdvertisementsController(
        ConfigData<AdvertisementModel>(
          apiEndPoint: Res.apiAllAdvertisements,
          emptyListMessage: 'empty_services'.tr,
          fromJson: AdvertisementModel.fromJson,
        ),
      ),
    );

    //booking controller
    Get.lazyPut(() => BookingRepositoryImpl());
    Get.lazyPut(() => BookingController(Get.find<BookingRepositoryImpl>()));

    // profile controller
    Get.lazyPut(() => AuthRepositoryIml());
    Get.lazyPut(() => LookUpsRepositoryIml());
    Get.lazyPut(() => ProfileController(
          Get.find<AuthRepositoryIml>(),
          Get.find<LookUpsRepositoryIml>(),
        ));

    //notifications controller
    Get.lazyPut(
      () => NotificationsController(
        ConfigData(
          apiEndPoint: Res.apiNotifications,
          emptyListMessage: 'Empty Notifications List',
          fromJson: NotificationsModel.fromJson,
        ),
      ),
    );
  }
}
