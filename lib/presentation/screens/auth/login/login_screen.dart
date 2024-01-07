import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/app/util/constants.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_progress_button.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';

import '../../../../app/res/res.dart';
import '../../../controller/auth_controller/auth_controller.dart';
import '../../../widgets/app_widgets/app_text_field/app_text_field.dart';
import '../../home/home_screen.dart';
import '../forget_password/forget_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<AppTextFormFieldState> _emailState = GlobalKey();
  final GlobalKey<AppTextFormFieldState> _passwordState = GlobalKey();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool? rememberMe = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
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
              child: Hero(
                tag: 'logo',
                child: Image.asset(
                  Res.logoImage,
                  height: 200,
                  width: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: AppText(
                'login_to_your_account'.tr,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            10.ph,
            AppTextFormField(
              key: _emailState,
              controller: emailController,
              validateEmptyText: 'email_required'.tr,
              hintText: 'email'.tr,
              horizontalPadding: 18,
              autoFillHints: const [AutofillHints.email],
              radius: kRadius,
              appFieldType: AppFieldType.email,
              prefixIcon: Res.iconEmail,
            ),
            AppTextFormField(
              key: _passwordState,
              controller: passwordController,
              validateEmptyText: 'password_required'.tr,
              hintText: 'password'.tr,
              horizontalPadding: 18,
              autoFillHints: const [AutofillHints.email],
              radius: kRadius,
              appFieldType: AppFieldType.password,
              prefixIcon: Res.iconPassword,
            ),
            10.ph,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Row(
                children: [
                  Checkbox.adaptive(
                    fillColor: MaterialStateProperty.all(
                        Theme.of(context).scaffoldBackgroundColor),
                    checkColor: Theme.of(context).primaryColor,
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
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
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
    Get.offAll(() => HomeScreen());
    return;
    if (emailController.text.isEmpty ||
        (_emailState.currentState?.hasError ?? false)) {
      _emailState.currentState?.shake();
      return;
    }

    if (passwordController.text.isEmpty ||
        (_passwordState.currentState?.hasError ?? false)) {
      _passwordState.currentState?.shake();
      return;
    }

    Get.find<AuthController>().login(
      email: emailController.text,
      password: passwordController.text,
      animationController: animationController,
      rememberMe: rememberMe,
    );
  }
}
