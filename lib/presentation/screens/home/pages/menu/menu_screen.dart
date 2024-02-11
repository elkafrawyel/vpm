import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:vpm/app/config/app_color.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/presentation/controller/profile_controller/profile_controller.dart';
import 'package:vpm/presentation/screens/profile/profile_screen.dart';
import 'package:vpm/presentation/screens/users/users_screen.dart';
import 'package:vpm/presentation/screens/wallet/wallet_screen.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_cached_image.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';
import 'package:vpm/presentation/widgets/app_widgets/language_views/app_language_switch.dart';

import '../../../../../app/util/information_viewer.dart';
import '../../../../../app/util/operation_reply.dart';
import '../../../../../data/models/general_response.dart';
import '../../../../../data/providers/storage/local_provider.dart';
import '../../../../../data/repositories/auth_repository.dart';
import '../../../../widgets/app_widgets/app_dialog.dart';
import '../../../cars/cars_screen.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('menu'.tr),
      ),
      body: GetBuilder<ProfileController>(builder: (_) {
        return RefreshIndicator(
          onRefresh: profileController.getUserProfile,
          child: SingleChildScrollView(
            child: Column(
              children: [
                30.ph,
                Center(
                  child: profileController.loading
                      ? const CircularProgressIndicator.adaptive()
                      : InkWell(
                          onTap: () {
                            PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: const ProfileScreen(),
                              withNavBar: true,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                          },
                          child: AppCachedImage(
                            imageUrl:
                                profileController.userModel?.avatar?.filePath,
                            isCircular: true,
                            width: 120,
                            height: 120,
                          ),
                        ),
                ),
                10.ph,
                InkWell(
                  onTap: () {
                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: const ProfileScreen(),
                      withNavBar: true,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                    );
                  },
                  child: AppText(
                    profileController.userModel?.name ?? '',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    centerText: false,
                  ),
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
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
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
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
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
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
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
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
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
                        Get.back();
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
      }),
    );
  }

  void _logout() async {
    EasyLoading.show();

    OperationReply operationReply = await AuthRepositoryIml().logOut();
    if (operationReply.isSuccess()) {
      GeneralResponse generalResponse = operationReply.result;
      EasyLoading.dismiss();
      InformationViewer.showSuccessToast(msg: generalResponse.message);
      await Future.delayed(const Duration(milliseconds: 500));
      await LocalProvider().signOut();
    } else {
      InformationViewer.showSnackBar(operationReply.message);
    }
  }
}
