import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vpm/data/providers/storage/local_provider.dart';
import '../../widgets/app_widgets/app_text.dart';
import '../auth/welcome/welcome_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  @override
  Widget build(BuildContext context) {
    return OnBoardingSlider(
      totalPage: 3,
      speed: 1.8,
      pageBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
      headerBackgroundColor: Colors.transparent,
      controllerColor: Theme.of(context).primaryColor,
      finishButtonText: 'get_started'.tr,
      finishButtonStyle: FinishButtonStyle(
        backgroundColor: Theme.of(context).primaryColor,
      ),
      skipTextButton: AppText(
        'skip'.tr,
        fontWeight: FontWeight.w700,
        fontSize: 16,
      ),
      skipFunctionOverride: () async {
        await LocalProvider().save(LocalProviderKeys.introScreen, 1);
        Get.offAll(() => const WelcomeScreen());
      },
      onFinish: () async {
        await LocalProvider().save(LocalProviderKeys.introScreen, 1);
        Get.offAll(() => const WelcomeScreen());
      },
      centerBackground: true,
      background: [
        Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: SvgPicture.asset(
            'assets/images/intro/intro_1.svg',
            height: 200,
            width: 300,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: SvgPicture.asset(
            'assets/images/intro/intro_2.svg',
            height: 200,
            width: 300,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: SvgPicture.asset(
            'assets/images/intro/intro_3.svg',
            height: 200,
            width: 300,
          ),
        ),
      ],
      pageBodies: [
        Container(
          margin: const EdgeInsets.only(top: 200),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: AppText(
            'intro_1_message'.tr,
            centerText: true,
            maxLines: 4,
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 200),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: AppText(
            'intro_2_message'.tr,
            centerText: true,
            maxLines: 4,
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 200),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: AppText(
            'intro_3_message'.tr,
            centerText: true,
            maxLines: 4,
            color: Colors.black,
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
