import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/presentation/controller/auth_controller/auth_binding.dart';

import '../../../../app/res/res.dart';
import '../../../widgets/app_widgets/app_text.dart';
import '../../../widgets/app_widgets/language_views/app_language_dialog.dart';
import '../login/login_screen.dart';
import '../register/register_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [
          GestureDetector(
            onTap: () {
              showAppLanguageDialog(context: context);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Row(
                children: [
                  const Icon(Icons.language),
                  5.pw,
                  AppText('language'.tr),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // AnimationConfiguration.staggeredGrid(
          //   position: 1,
          //   columnCount: 3,
          //   duration: const Duration(milliseconds: 2000),
          //   child: SlideAnimation(
          //     horizontalOffset: 0,
          //     verticalOffset: 500,
          //     duration: const Duration(milliseconds: 2000),
          //     child: ScaleAnimation(
          //       scale: 0.4,
          //       duration: const Duration(milliseconds: 2000),
          //       child: Hero(
          //         tag: 'logo',
          //         child: Image.asset(
          //           Res.logoImage,
          //           height: 200,
          //           width: 300,
          //           fit: BoxFit.cover,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          Image.asset(
            Res.logoImage,
            height: 200,
            width: 300,
            fit: BoxFit.cover,
          ),
          AppText(
            "let_you_in".tr,
            fontSize: 25,
            centerText: true,
            fontWeight: FontWeight.w500,
          ),
          // 30.ph,
          // SocialButton(
          //   svgName: 'assets/icons/facebook.svg',
          //   text: 'continue_with_facebook'.tr,
          //   onTap: () {},
          // ),
          // 10.ph,
          // SocialButton(
          //   svgName: 'assets/icons/google.svg',
          //   text: 'continue_with_google'.tr,
          //   onTap: () {},
          // ),
          // 10.ph,
          // SocialButton(
          //   svgName: 'assets/icons/apple.svg',
          //   text: 'continue_with_apple'.tr,
          //   onTap: () {},
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(36.0),
          //   child: Row(
          //     mainAxisSize: MainAxisSize.max,
          //     children: [
          //       const Expanded(child: Divider()),
          //       Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //         child: AppText(
          //           'or'.tr,
          //           fontSize: 18,
          //           color: Theme.of(context).primaryColor,
          //           fontWeight: FontWeight.w700,
          //         ),
          //       ),
          //       const Expanded(child: Divider()),
          //     ],
          //   ),
          // ),
          30.ph,
          ElevatedButton(
            onPressed: () {
              Get.to(() => const LoginScreen(), binding: AuthBinding());
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AppText(
                'sign_in_with_password'.tr,
                fontSize: 16,
              ),
            ),
          ),
          20.ph,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppText('have_no_account'.tr),
              10.pw,
              InkWell(
                onTap: () {
                  Get.to(
                    () => const RegisterScreen(),
                    binding: AuthBinding(),
                  );
                },
                child: AppText(
                  'sign_up'.tr,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          100.ph,
        ],
      ),
    );
  }
}
