import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:vpm/app/config/app_color.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/presentation/screens/profile/profile_screen.dart';
import 'package:vpm/presentation/screens/users/users_screen.dart';
import 'package:vpm/presentation/screens/wallet/wallet_screen.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';
import 'package:vpm/presentation/widgets/app_widgets/language_views/app_language_switch.dart';

import '../../../../../data/providers/storage/local_provider.dart';
import '../../../../widgets/app_widgets/app_dialog.dart';
import '../../../cars/cars_screen.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            30.ph,
            Center(
              child: Container(
                height: 120,
                width: 120,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/person.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: AlignmentDirectional.bottomEnd,
              ),
            ),
            10.ph,
            const AppText(
              'Anabia Rani',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              centerText: false,
            ),
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
              leading: const Icon(Icons.wallet),
              title: Text('wallet'.tr),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const AppText(
                    '(1000 SAR)',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                  10.pw,
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).dividerColor,
                    size: 20,
                  ),
                ],
              ),
              onTap: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: const WalletScreen(),
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
            ListTile(
              splashColor: Colors.transparent,
              leading: const Icon(
                Icons.logout,
                color: errorColor,
              ),
              title: Text(
                'logout'.tr,
                style: const TextStyle(
                  color: errorColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              onTap: () {
                scaleAlertDialog(
                  context: context,
                  title: 'logout'.tr,
                  body: 'logout_message'.tr,
                  cancelText: 'cancel'.tr,
                  confirmText: 'submit'.tr,
                  barrierDismissible: true,
                  onCancelClick: () {
                    Get.back();
                  },
                  onConfirmClick: () async {
                    _logout();
                  },
                );
              },
            ),
            200.ph,
          ],
        ),
      ),
    );
  }

  void _logout() async {
    await LocalProvider().signOut();
  }
}
