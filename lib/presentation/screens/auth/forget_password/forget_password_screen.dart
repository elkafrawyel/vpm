import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/app/res/res.dart';
import 'package:vpm/presentation/controller/auth_controller/auth_controller.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_progress_button.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';

import '../../../../app/util/constants.dart';
import '../../../widgets/app_widgets/app_text_field/app_phone_text_field.dart';
import '../../../widgets/app_widgets/app_text_field/app_text_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final GlobalKey<AppTextFormFieldState> _phoneState = GlobalKey();
  final TextEditingController phoneController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText('forget_password'.tr),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            children: [
              SvgPicture.asset(Res.iconForgetPassword),
              20.ph,
              AppText(
                'write_your_phone'.tr,
                maxLines: 2,
                centerText: true,
              ),
              20.ph,
              AppTextFormField(
                key: _phoneState,
                controller: phoneController,
                hintText: '+966 xxx xxx xxx'.tr,
                radius: kRadius,
                validateEmptyText: 'phone_is_required'.tr,
                appFieldType: AppFieldType.phone,
                prefixIcon: Res.iconPhone,
              ),
              40.ph,
              AppProgressButton(
                text: 'continue'.tr,
                onPressed: (animationController) async {
                  _forgetPassword(animationController);
                },
              ),
              100.ph,
            ],
          ),
        ),
      ),
    );
  }

  void _forgetPassword(AnimationController animationController) async {
    if (phoneController.text.isEmpty ||
        (_phoneState.currentState?.hasError ?? false)) {
      _phoneState.currentState?.shake();

      return;
    }

    Get.find<AuthController>().forgetPassword(
      phoneNumber: phoneController.text,
      animationController: animationController,
    );
  }
}
