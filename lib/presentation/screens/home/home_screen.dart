import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:vpm/presentation/controller/home_screen_controller/home_screen_controller.dart';
import '../../../app/res/res.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
        init: HomeScreenController(),
        builder: (homeScreenController) {
          return PersistentTabView(
            context,
            padding: const NavBarPadding.all(8),
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
                title: 'valet'.tr,
                svgName: Res.iconValet,
              ),
              bottomNavigationItem(
                context: context,
                selected: homeScreenController.selectedTabIndex == 2,
                title: 'services'.tr,
                svgName: Res.iconServices,
              ),
              bottomNavigationItem(
                context: context,
                selected: homeScreenController.selectedTabIndex == 3,
                title: 'booking'.tr,
                svgName: Res.iconBooking,
              ),
              bottomNavigationItem(
                context: context,
                selected: homeScreenController.selectedTabIndex == 4,
                title: 'menu'.tr,
                svgName: Res.iconMenu,
              ),
            ],
            onItemSelected: homeScreenController.handleIndexChanged,
            confineInSafeArea: true,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset: true,
            stateManagement: true,
            hideNavigationBarWhenKeyboardShows: true,
            decoration: NavBarDecoration(
              borderRadius: BorderRadius.circular(12.0),
              colorBehindNavBar: Theme.of(context).scaffoldBackgroundColor,
            ),
            popAllScreensOnTapOfSelectedTab: true,
            popActionScreens: PopActionScreensType.all,
            itemAnimationProperties: const ItemAnimationProperties(
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: const ScreenTransitionAnimation(
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),
            navBarStyle: NavBarStyle.style8,
            // Choose the nav bar style with this property.
          );
        });
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
}
