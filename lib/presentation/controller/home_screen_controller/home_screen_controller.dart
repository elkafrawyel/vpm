import 'package:fcm_config/fcm_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:vpm/presentation/controller/parking_controller/parking_controller.dart';
import 'package:vpm/presentation/screens/home/pages/parking/parking_screen.dart';
import 'package:vpm/presentation/screens/home/pages/services/services_screen.dart';
import 'package:vpm/presentation/screens/home/pages/valet/valet_screen.dart';

import '../../../app/util/util.dart';
import '../../../firebase_options.dart';
import '../../screens/home/pages/booking/booking_screen.dart';
import '../../screens/home/pages/menu/menu_screen.dart';

class HomeScreenController extends GetxController {
  int? selectedTabIndex;
  late List<Widget> pages;
  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  @override
  void onInit() async {
    super.onInit();

    initializeNotifications();
    selectedTabIndex = 0;
    pages = [
      const ParkingScreen(),
      const ValetScreen(),
      const AdvertisementsScreen(),
      const BookingScreen(),
      const MenuScreen(),
    ];
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  initializeNotifications() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await FCMConfig.instance.init(
      onBackgroundMessage: _firebaseMessagingBackgroundHandler,
      defaultAndroidChannel: const AndroidNotificationChannel(
        'com.vpmsystems.parking',
        'VPM',
      ),
    );

    FCMConfig.instance.messaging.getToken().then((token) {
      Utils.logMessage('Firebase Token:$token');
    });
  }

  handleIndexChanged(int index) {
    selectedTabIndex = index;
    controller.jumpToTab(index);
    update();

    try {
      Get.find<ParkingController>()
          .customInfoWindowController
          .hideInfoWindow!();
    } catch (e) {
      print(e.toString());
    }
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  Utils.logMessage("Handling a background message: ${message.messageId}");
  // Get.find<HomeScreenController>().handleRemoteMessage(message);
}
