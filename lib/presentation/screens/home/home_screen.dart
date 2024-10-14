import 'package:fcm_config/fcm_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:vpm/presentation/controller/home_screen_controller/home_screen_controller.dart';

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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      init: HomeScreenController(),
      builder: (homeScreenController) {
        return PersistentTabView(
          context,
          padding: const EdgeInsets.all(8),
          navBarHeight: 70,
          controller: homeScreenController.controller,
          screens: homeScreenController.pages,
          items: [
            bottomNavigationItem(
              context: context,
              selected: homeScreenController.selectedTabIndex == 0,
              title: 'parking'.tr,
              svgName: Res.iconParking,
            ),
            bottomNavigationItem(
              context: context,
              selected: homeScreenController.selectedTabIndex == 1,
              title: 'booking'.tr,
              svgName: Res.iconBooking,
            ),

            // bottomNavigationItem(
            //   context: context,
            //   selected: homeScreenController.selectedTabIndex == 2,
            //   title: 'services'.tr,
            //   svgName: Res.iconServices,
            // ),

            bottomNavigationItem(
              context: context,
              selected: homeScreenController.selectedTabIndex == 2,
              title: 'notifications'.tr,
              svgName: Res.iconNotifications,
            ),
            // bottomNavigationItem(
            //   context: context,
            //   selected: homeScreenController.selectedTabIndex == 3,
            //   title: 'your_cars'.tr,
            //   svgName: Res.iconValet,
            // ),

            bottomNavigationItem(
              context: context,
              selected: homeScreenController.selectedTabIndex == 3,
              title: 'menu'.tr,
              svgName: Res.iconMenu,
            ),
          ],
          onItemSelected: homeScreenController.handleIndexChanged,
          onWillPop: (p0) {
            if (homeScreenController.selectedTabIndex != 0) {
              homeScreenController.handleIndexChanged(0);
              return Future.value(false);
            } else {
              scaleAlertDialog(
                context: context,
                title: 'close_app'.tr,
                body: 'close_app_message'.tr,
                cancelText: 'cancel'.tr,
                confirmText: 'submit'.tr,
                barrierDismissible: true,
                onCancelClick: () {
                  Get.back();
                },
                onConfirmClick: () async {
                  SystemNavigator.pop();
                },
              );
              return Future.value(true);
            }
          },
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
        );
      },
    );
  }

  PersistentBottomNavBarItem bottomNavigationItem({
    required BuildContext context,
    required bool selected,
    required String title,
    required String svgName,
  }) =>
      PersistentBottomNavBarItem(
        icon: SvgPicture.asset(
          svgName,
          fit: BoxFit.contain,
          colorFilter: ColorFilter.mode(
            selected
                ? Theme.of(context).primaryColor
                : const Color.fromRGBO(217, 217, 217, 1),
            BlendMode.srcIn,
          ),
        ),
        contentPadding: 0,
        title: title,
        inactiveColorPrimary: Theme.of(context).iconTheme.color,
        activeColorPrimary: Theme.of(context).primaryColor,
        textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: selected ? FontWeight.w800 : FontWeight.w400,
              fontFamily: GoogleFonts.cairo().fontFamily,
              fontSize: selected ? 12 : 10,
            ),
      );

  @override
  void onNotify(RemoteMessage notification) {
    if (kDebugMode) {
      print(
          'Notification Model====>\n${notification.data['notification_model']}');
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
