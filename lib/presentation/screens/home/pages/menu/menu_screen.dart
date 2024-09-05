import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/presentation/controller/profile_controller.dart';
import 'package:vpm/presentation/controller/wallet_controller.dart';
import 'package:vpm/presentation/screens/home/pages/menu/components/logout_view.dart';
import 'package:vpm/presentation/screens/home/pages/menu/components/user_info_view.dart';
import 'package:vpm/presentation/screens/profile/profile_screen.dart';
import 'package:vpm/presentation/screens/users/users_screen.dart';
import 'package:vpm/presentation/widgets/app_widgets/language_views/app_language_switch.dart';

import '../cars/cars_screen.dart';
import 'components/wallet_view.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('menu'.tr),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Get.find<ProfileController>().getUserProfile();
          final WalletController walletController =
              Get.find<WalletController>();
          walletController.getWalletBalance();
          walletController.getPaymentOptions();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              30.ph,
              const UserInfoView(),
              ListTile(
                splashColor: Colors.transparent,
                leading: const Icon(Icons.person),
                title: Text('profile'.tr),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).dividerColor,
                  size: 20,
                ),
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const ProfileScreen(),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
              ),
              const WalletView(),
              ListTile(
                splashColor: Colors.transparent,
                leading: const Icon(Icons.directions_car),
                title: Text('your_cars'.tr),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).dividerColor,
                  size: 20,
                ),
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const CarsScreen(),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
              ),
              ListTile(
                splashColor: Colors.transparent,
                leading: const Icon(Icons.group),
                title: Text('users_management'.tr),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).dividerColor,
                  size: 20,
                ),
                onTap: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const UsersScreen(),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
              ),
              ListTile(
                splashColor: Colors.transparent,
                leading: const Icon(Icons.settings),
                title: Text('settings'.tr),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).dividerColor,
                  size: 20,
                ),
                onTap: () {},
              ),
              ListTile(
                splashColor: Colors.transparent,
                leading: const Icon(Icons.help),
                title: Text('help'.tr),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).dividerColor,
                  size: 20,
                ),
                onTap: () {},
              ),
              // ListTile(
              //   leading: const Icon(Icons.dark_mode_outlined),
              //   title: Text('dark_mode'.tr),
              //   trailing: Obx(
              //     () => Switch.adaptive(
              //       value: Get.find<AppConfigController>().isDarkMode.value,
              //       onChanged: (bool value) {
              //         Get.find<AppConfigController>().toggleAppTheme();
              //       },
              //     ),
              //   ),
              // ),
              ListTile(
                splashColor: Colors.transparent,
                leading: const Icon(Icons.language),
                title: Text('language'.tr),
                trailing: const AppLanguageSwitch(),
                onTap: () {},
              ),
              const LogOutView(),
              200.ph,
            ],
          ),
        ),
      ),
    );
  }
}
