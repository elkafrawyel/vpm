import 'dart:convert';
import 'package:fcm_config/fcm_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:vpm/presentation/controller/booking_controller/current_booking_controller.dart';
import 'package:vpm/presentation/controller/booking_controller/ended_booking_controller.dart';

import '../../../domain/entities/models/notifications_model.dart';

class HomeScreenController extends GetxController {
  PersistentTabController tabController =
      PersistentTabController(initialIndex: 0);
  var currentIndex = 0.obs;
  /// Keeps track of visited main tabs in order
  final List<int> tabHistory = [0];
  // navigator keys for each tab
  final List<GlobalKey<NavigatorState>> navigatorKeys = List.generate(
    4,
    (_) => GlobalKey<NavigatorState>(),
  );

  void changeTab(int index,{bool addToHistory=true}) {
    if (currentIndex.value == index) return;

    if(addToHistory){
      // ✅ Push tab into history if it's a new tab
      tabHistory.add(index);
      debugPrint("Tab history: $tabHistory");
    }

    currentIndex.value = index;
    tabController.index = index;
  }

  /// Pop history when going back
  int? popTabHistory() {
    if (tabHistory.length > 1) {
      tabHistory.removeLast();
      return tabHistory.last;
    }
    return null;
  }

  @override
  void onInit() async {
    super.onInit();
    handleInitialMessage();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
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
