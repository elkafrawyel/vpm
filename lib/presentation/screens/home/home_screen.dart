import 'package:fcm_config/fcm_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:vpm/presentation/controller/home_screen_controller/home_screen_controller.dart';
import 'package:vpm/presentation/screens/home/pages/booking/booking_screen.dart';
import 'package:vpm/presentation/screens/home/pages/menu/menu_screen.dart';
import 'package:vpm/presentation/screens/home/pages/notifications/notifications_screen.dart';
import 'package:vpm/presentation/screens/home/pages/parking/parking_screen.dart';

import '../../../app/res/res.dart';
import '../../controller/notifications_controller.dart';
import '../../widgets/app_widgets/app_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with FCMNotificationMixin, FCMNotificationClickMixin {
  final HomeScreenController homeScreenController = Get.find();

  Future<bool> _onWillPop(BuildContext context) async {
    print(
        "➡️ onWillPop called, tab: ${homeScreenController.currentIndex.value}");

    final currentIndex = homeScreenController.currentIndex.value;
    final currentNavigator =
        homeScreenController.navigatorKeys[currentIndex].currentState;

    // 1. If current tab has inner pages → pop them
    if (currentNavigator?.canPop() ?? false) {
      currentNavigator?.pop();
      return false;
    }

    // 2. If not on first tab → go back to tab 0

    final previousTab = homeScreenController.popTabHistory();
    if (previousTab != null && previousTab != currentIndex) {
      homeScreenController.changeTab(previousTab, addToHistory: false);
      return false;
    }

    // if (currentIndex != 0) {
    //   homeScreenController.changeTab(0);
    //   return false;
    // }
    // 3. Already at root of main tab → confirm exit
    final shouldExit = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("close_app".tr),
        content: Text("close_app_message".tr),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text("cancel".tr),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text("submit".tr),
          ),
        ],
      ),
    );

    return shouldExit ?? false;
  }

  List<Widget> _buildScreens() {
    return [
      Navigator(
        key: homeScreenController.navigatorKeys[0],
        onGenerateRoute: (_) =>
            MaterialPageRoute(builder: (_) => const ParkingScreen()),
      ),
      Navigator(
        key: homeScreenController.navigatorKeys[1],
        onGenerateRoute: (_) =>
            MaterialPageRoute(builder: (_) => const BookingScreen()),
      ),
      Navigator(
        key: homeScreenController.navigatorKeys[2],
        onGenerateRoute: (_) =>
            MaterialPageRoute(builder: (_) => const NotificationsScreen()),
      ),
      Navigator(
        key: homeScreenController.navigatorKeys[3],
        onGenerateRoute: (_) =>
            MaterialPageRoute(builder: (_) => const MenuScreen()),
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    Color selectedColor = Theme.of(context).primaryColor;
    Color unSelectedColor = const Color.fromRGBO(217, 217, 217, 1);
    return [
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          Res.iconParking,
          fit: BoxFit.contain,
          colorFilter: ColorFilter.mode(
            homeScreenController.currentIndex.value == 0
                ? selectedColor
                : unSelectedColor,
            BlendMode.srcIn,
          ),
        ),
        title: "parking".tr,
        activeColorPrimary: selectedColor,
        inactiveColorPrimary: unSelectedColor,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          Res.iconBooking,
          fit: BoxFit.contain,
          colorFilter: ColorFilter.mode(
            homeScreenController.currentIndex.value == 1
                ? selectedColor
                : unSelectedColor,
            BlendMode.srcIn,
          ),
        ),
        title: "booking".tr,
        activeColorPrimary: selectedColor,
        inactiveColorPrimary: unSelectedColor,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          Res.iconNotifications,
          fit: BoxFit.contain,
          colorFilter: ColorFilter.mode(
            homeScreenController.currentIndex.value == 2
                ? selectedColor
                : unSelectedColor,
            BlendMode.srcIn,
          ),
        ),
        title: "notifications".tr,
        activeColorPrimary: selectedColor,
        inactiveColorPrimary: unSelectedColor,
      ),
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          Res.iconMenu,
          fit: BoxFit.contain,
          colorFilter: ColorFilter.mode(
            homeScreenController.currentIndex.value == 3
                ? selectedColor
                : unSelectedColor,
            BlendMode.srcIn,
          ),
        ),
        title: "menu".tr,
        activeColorPrimary: selectedColor,
        inactiveColorPrimary: unSelectedColor,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(context),
      child: Scaffold(
        body: Obx(
          () => PersistentTabView(
            context,
            padding: const EdgeInsets.all(8),
            navBarHeight: 70,
            controller: homeScreenController.tabController,
            screens: _buildScreens(),
            items: _navBarsItems(),
            onItemSelected: homeScreenController.changeTab,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            handleAndroidBackButtonPress: false,
            resizeToAvoidBottomInset: true,
            stateManagement: true,
            hideNavigationBarWhenKeyboardAppears: true,
            decoration: NavBarDecoration(
              borderRadius: BorderRadius.circular(12.0),
              colorBehindNavBar: Theme.of(context).scaffoldBackgroundColor,
            ),
            popBehaviorOnSelectedNavBarItemPress: PopBehavior.all,
            animationSettings: const NavBarAnimationSettings(
              screenTransitionAnimation: ScreenTransitionAnimationSettings(
                animateTabTransition: true,
                curve: Curves.ease,
                duration: Duration(milliseconds: 200),
              ),
              navBarItemAnimation: ItemAnimationSettings(
                duration: Duration(milliseconds: 200),
                curve: Curves.ease,
              ),
            ),
            navBarStyle: NavBarStyle.style8,
            // Choose the nav bar style with this property.
          ),
        ),
      ),
    );
  }

  @override
  void onNotify(RemoteMessage notification) {
    if (kDebugMode) {
      print(
          'Notification Model : : "${notification.data['notification_model']}');
    }

    Get.find<NotificationsController>().addNewNotification(notification);
    homeScreenController.handleNotificationClick(
      notification,
      withNavigation: false,
    );
  }

  @override
  void onClick(RemoteMessage notification) {
    homeScreenController.handleNotificationClick(notification);
  }
}
