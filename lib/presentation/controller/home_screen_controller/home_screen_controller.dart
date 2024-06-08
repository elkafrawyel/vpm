import 'dart:convert';

import 'package:fcm_config/fcm_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:vpm/presentation/controller/booking_controller/current_booking_controller.dart';
import 'package:vpm/presentation/controller/booking_controller/ended_booking_controller.dart';
import 'package:vpm/presentation/screens/home/pages/notifications/notifications_screen.dart';
import 'package:vpm/presentation/screens/home/pages/parking/parking_screen.dart';
import 'package:vpm/presentation/screens/home/pages/services/services_screen.dart';

import '../../../domain/entities/models/notifications_model.dart';
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
      const BookingScreen(),
      const AdvertisementsScreen(),
      const NotificationsScreen(),
      const MenuScreen(),
    ];

    handleInitialMessage();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  handleIndexChanged(int index) {
    selectedTabIndex = index;
    controller.jumpToTab(index);
    update();
  }

  void handleNotificationClick(
    RemoteMessage notification, {
    bool withNavigation = true,
  }) {
    NotificationsModel notificationsModel = NotificationsModel.fromJson(
      jsonDecode(
        notification.data['notification_model'].toString(),
      ),
    );
    switch (notificationsModel.moduleCode) {
      case 1:
        switch (notificationsModel.eventCode) {
          case 2:

            /// تمت الموافقة علي طلب الانهاء
            ///ACCEPT_REQUEST_DRIVER
            Get.find<CurrentBookingController>().refreshApiCall(loading: false);

            break;
        }
        break;
      case 2:
        switch (notificationsModel.eventCode) {
          case 1:
            Get.find<CurrentBookingController>().refreshApiCall(loading: false);
            break;
          case 2:
            Get.find<EndedBookingController>().refreshApiCall(loading: false);
            break;
          case 5:

            /// بدآ الركن
            /// START_PARKINK
            Get.find<CurrentBookingController>().refreshApiCall(loading: false);
            break;
          case 6:

            /// تآكيد الركن
            /// CONFIRM_START_PARKINK
            Get.find<CurrentBookingController>().refreshApiCall(loading: false);
            break;
          case 7:

            /// تم انهاء الركن
            /// END_PARKINK
            Get.find<CurrentBookingController>().refreshApiCall(loading: false);
            Get.find<EndedBookingController>().refreshApiCall(loading: false);
            break;
        }
        break;
    }
  }

  void handleInitialMessage() async {
    RemoteMessage? remoteMessage = await FCMConfig.instance.getInitialMessage();

    if (remoteMessage != null) {
      if (kDebugMode) {
        print(
            'Notification Model handleInitialMessage ====>\n${remoteMessage.data['notification_model']}');
      }

      handleNotificationClick(remoteMessage);
    } else {
      if (kDebugMode) {
        print('Notification Model handleInitialMessage ====> null');
      }
    }
  }
}
