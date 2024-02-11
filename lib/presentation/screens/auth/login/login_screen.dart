import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/app/util/constants.dart';
import 'package:vpm/data/providers/storage/local_provider.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_progress_button.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';

import '../../../../app/res/res.dart';
import '../../../controller/auth_controller/auth_controller.dart';
import '../../../widgets/app_widgets/app_text_field/app_text_field.dart';
import '../forget_password/forget_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<AppTextFormFieldState> _phoneState = GlobalKey();
  final GlobalKey<AppTextFormFieldState> _passwordState = GlobalKey();
  late TextEditingController phoneController;

  late TextEditingController passwordController;

  bool? rememberMe = false;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController(
      text: LocalProvider().get(LocalProviderKeys.phone),
    );
    passwordController = TextEditingController(
      text: LocalProvider().get(LocalProviderKeys.password),
    );

    rememberMe = LocalProvider().get(LocalProviderKeys.rememberMe) ?? false;
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('login'.tr),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                Res.logoImage,
                height: 200,
                width: 300,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 38.0),
              child: AppText(
                'login_to_your_account'.tr,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            10.ph,
            AppTextFormField(
              key: _phoneState,
              controller: phoneController,
              validateEmptyText: 'phone_required'.tr,
              hintText: 'phone'.tr,
              horizontalPadding: 28,
              autoFillHints: const [AutofillHints.telephoneNumber],
              radius: kRadius,
              appFieldType: AppFieldType.phone,
              prefixIcon: Res.iconPhone,
            ),
            AppTextFormField(
              key: _passwordState,
              controller: passwordController,
              validateEmptyText: 'password_required'.tr,
              hintText: 'password'.tr,
              horizontalPadding: 28,
              autoFillHints: const [AutofillHints.email],
              radius: kRadius,
              appFieldType: AppFieldType.password,
              prefixIcon: Res.iconPassword,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Row(
                children: [
                  Checkbox.adaptive(
                    // fillColor: MaterialStateProperty.all(
                    //     Theme.of(context).scaffoldBackgroundColor),
                    // checkColor: Theme.of(context).primaryColor,
                    value: rememberMe,
                    onChanged: (bool? value) {
                      setState(() {
                        rememberMe = value;
                      });
                    },
                  ),
                  AppText(
                    'remember_me'.tr,
                    color: Theme.of(context).primaryColor,
                    fontSize: 16,
                  ),
                ],
              ),
            ),
            10.ph,
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: AppProgressButton(
                  text: 'login'.tr,
                  width: MediaQuery.sizeOf(context).width,
                  radius: kRadius,
                  onPressed: (animationController) async {
                    _login(animationController);
                  },
                ),
              ),
            ),
            20.ph,
            InkWell(
              onTap: () {
                Get.to(() => const ForgetPasswordScreen());
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 38.0),
                child: AppText(
                  'forget_password?'.tr,
                  color: Theme.of(context).primaryColor,
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _login(AnimationController animationController) async {
    if (phoneController.text.isEmpty ||
        (_phoneState.currentState?.hasError ?? false)) {
      _phoneState.currentState?.shake();
      return;
    }

    if (passwordController.text.isEmpty ||
        (_passwordState.currentState?.hasError ?? false)) {
      _passwordState.currentState?.shake();
      return;
    }

    Get.find<AuthController>().login(
      phone: phoneController.text,
      password: passwordController.text,
      animationController: animationController,
      rememberMe: rememberMe,
    );
  }
}
