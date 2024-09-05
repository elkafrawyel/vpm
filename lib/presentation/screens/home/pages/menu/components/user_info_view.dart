import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:vpm/app/extensions/space.dart';

import '../../../../../../data/providers/storage/local_provider.dart';
import '../../../../../controller/profile_controller.dart';
import '../../../../../widgets/app_widgets/app_cached_image.dart';
import '../../../../../widgets/app_widgets/app_dialog.dart';
import '../../../../../widgets/app_widgets/app_text.dart';
import '../../../../../widgets/shimmer_widgets/shimmer_effect_ui.dart';
import '../../../../profile/profile_screen.dart';
import 'qr_code_view.dart';

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
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
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
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                      20.pw,
                      GestureDetector(
                        onTap: () {
                          scaleDialog(
                            context: context,
                            barrierDismissible: true,
                            backgroundColor: Colors.transparent,
                            content: QrCodeView(
                              qrValue: LocalProvider().getUser()?.qrId ?? '',
                            ),
                          );
                        },
                        child: const Icon(
                          Icons.qr_code,
                          color: Colors.green,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
          ],
        );
      },
    );
  }
}
