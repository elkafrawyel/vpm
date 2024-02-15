import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:vpm/app/extensions/space.dart';

import '../../../../../controller/profile_controller/profile_controller.dart';
import '../../../../../widgets/app_widgets/app_cached_image.dart';
import '../../../../../widgets/app_widgets/app_text.dart';
import '../../../../../widgets/shimmer_widgets/shimmer_effect_ui.dart';
import '../../../../profile/profile_screen.dart';

class UserInfoView extends StatelessWidget {
  const UserInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profileController) {
        return Column(
          children: [
            Center(
              child: profileController.loading
                  ? const MyShimmerEffectUI.circular(
                      height: 120,
                      width: 120,
                    )
                  : InkWell(
                      onTap: () {
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: const ProfileScreen(),
                          withNavBar: true,
                          pageTransitionAnimation: PageTransitionAnimation.cupertino,
                        );
                      },
                      child: AppCachedImage(
                        imageUrl: profileController.userModel?.avatar?.filePath,
                        isCircular: true,
                        width: 120,
                        height: 120,
                      ),
                    ),
            ),
            10.ph,
            profileController.loading
                ? const MyShimmerEffectUI.rectangular(
                    height: 13,
                    width: 150,
                  )
                : InkWell(
                    onTap: () {
                      PersistentNavBarNavigator.pushNewScreen(
                        context,
                        screen: const ProfileScreen(),
                        withNavBar: true,
                        pageTransitionAnimation: PageTransitionAnimation.cupertino,
                      );
                    },
                    child: AppText(
                      profileController.userModel?.name ?? '',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      centerText: false,
                    ),
                  ),
          ],
        );
      },
    );
  }
}
