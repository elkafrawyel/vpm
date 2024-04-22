import 'package:fcm_config/fcm_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:vpm/presentation/screens/home/pages/cars/cars_screen.dart';
import 'package:vpm/presentation/screens/home/pages/parking/parking_screen.dart';
import 'package:vpm/presentation/screens/home/pages/services/services_screen.dart';

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
    selectedTabIndex = 0;
    pages = [
      const ParkingScreen(),
      const CarsScreen(),
      const AdvertisementsScreen(),
      const BookingScreen(),
      const MenuScreen(),
    ];
    initializeNotifications();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future initializeNotifications() async {
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
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  Utils.logMessage("Handling a background message: ${message.messageId}");
  // Get.find<HomeScreenController>().handleRemoteMessage(message);
}
