import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vpm/app/extensions/space.dart';

import '../../../../app/res/res.dart';
import '../../../widgets/app_widgets/app_progress_button.dart';
import '../../../widgets/app_widgets/app_text.dart';
import '../../../widgets/app_widgets/app_text_field/app_text_field.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  late TextEditingController newPasswordController;
  late TextEditingController confirmPasswordController;

  late GlobalKey<AppTextFormFieldState> _newPasswordState;
  late GlobalKey<AppTextFormFieldState> _confirmPasswordState;

  @override
  void initState() {
    super.initState();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    _newPasswordState = GlobalKey();
    _confirmPasswordState = GlobalKey();
  }

  @override
  void dispose() {
    super.dispose();
    confirmPasswordController.dispose();
    newPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: AppText(
          'new_password'.tr,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SvgPicture.asset(
                Res.iconNewPassword,
                height: 250,
                fit: BoxFit.fill,
              ),
            ),
            20.ph,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 38.0),
              child: AppText('create_new_password'.tr),
            ),
            10.ph,
            AppTextFormField(
              key: _newPasswordState,
              controller: newPasswordController,
              hintText: 'new_password'.tr,
              horizontalPadding: 38,
              appFieldType: AppFieldType.password,
              textInputAction: TextInputAction.next,
              validateEmptyText: 'new_password_is_required'.tr,
              checkRules: false,
              prefixIcon: Res.iconPassword,
              onChanged: handlePasswordMatching,
            ),
            AppTextFormField(
              key: _confirmPasswordState,
              controller: confirmPasswordController,
              hintText: 'confirm_password'.tr,
              horizontalPadding: 38,
              appFieldType: AppFieldType.confirmPassword,
              textInputAction: TextInputAction.done,
              checkRules: false,
              validateEmptyText: 'confirm_password_is_required'.tr,
              keyboardType: TextInputType.visiblePassword,
              onChanged: handleConfirmPasswordMatching,
              prefixIcon: Res.iconPassword,
            ),
            20.ph,
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38.0),
                child: AppProgressButton(
                  text: 'submit'.tr,
                  onPressed: (animationController) async {
                    _createNewPassword(animationController);
                  },
                  width: MediaQuery.sizeOf(context).width,
                ),
              ),
            ),
            100.ph,
          ],
        ),
      ),
    );
  }

  bool handlePasswordMatching(String value, {bool shake = false}) {
    if (value.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        confirmPasswordController.text != value) {
      _confirmPasswordState.currentState
          ?.updateHelperText('confirm_password_does_not_match'.tr);
      if (shake) {
        _confirmPasswordState.currentState?.shake();
        return false;
      }
    } else {
      _confirmPasswordState.currentState?.updateHelperText('');
    }
    return true;
  }

  bool handleConfirmPasswordMatching(String value, {bool shake = false}) {
    if (value.isNotEmpty &&
        newPasswordController.text.isNotEmpty &&
        newPasswordController.text != value) {
      _confirmPasswordState.currentState
          ?.updateHelperText('confirm_password_does_not_match'.tr);
      if (shake) {
        _confirmPasswordState.currentState?.shake();
        return false;
      }
    } else {
      _confirmPasswordState.currentState?.updateHelperText('');
    }
    return true;
  }

  void _createNewPassword(
    AnimationController animationController,
  ) async {
    if (newPasswordController.text.isEmpty) {
      _newPasswordState.currentState?.shake();
      return;
    } else if (confirmPasswordController.text.isEmpty) {
      _confirmPasswordState.currentState?.shake();
      return;
    } else if (!handleConfirmPasswordMatching(confirmPasswordController.text,
        shake: true)) {
      return;
    }

    Get.until((route) => route.settings.name == '/LoginScreen');
  }
}
