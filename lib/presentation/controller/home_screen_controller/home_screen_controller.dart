import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:vpm/presentation/screens/home/pages/parking/parking_screen.dart';
import 'package:vpm/presentation/screens/home/pages/services/services_screen.dart';
import 'package:vpm/presentation/screens/home/pages/valet/valet_screen.dart';

import '../../screens/home/pages/booking/booking_screen.dart';
import '../../screens/home/pages/menu/menu_screen.dart';

class HomeScreenController extends GetxController {
  int? selectedTabIndex;
  late List<Widget> pages;
  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  @override
  void onInit() {
    super.onInit();

    selectedTabIndex = 0;
    pages = [
      ParkingScreen(),
      ValetScreen(),
      ServicesScreen(),
      BookingScreen(),
      MenuScreen(),
    ];
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
}
