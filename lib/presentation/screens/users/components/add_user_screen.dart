import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:vpm/app/config/app_color.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/presentation/controller/users_controller/users_controller.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_progress_button.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text_field/app_text_field.dart';

import '../../../../app/res/res.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController phoneController;

  final GlobalKey<AppTextFormFieldState> nameState = GlobalKey();
  final GlobalKey<AppTextFormFieldState> phoneState = GlobalKey();
  final GlobalKey<AppTextFormFieldState> passwordState = GlobalKey();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    phoneController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('add_user'.tr),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              30.ph,
              AppTextFormField(
                key: nameState,
                controller: nameController,
                hintText: 'name'.tr,
                prefixIcon: Res.iconName,
                appFieldType: AppFieldType.text,
              ),
              AppTextFormField(
                key: phoneState,
                controller: phoneController,
                hintText: 'phone'.tr,
                prefixIcon: Res.iconPhone,
                appFieldType: AppFieldType.phone,
              ),
              AppTextFormField(
                key: passwordState,
                controller: passwordController,
                hintText: 'password'.tr,
                prefixIcon: Res.iconPassword,
                appFieldType: AppFieldType.password,
              ),
              30.ph,
              AppProgressButton(
                onPressed: (animationController) async {
                  _addUser(animationController);
                },
                child: AppText('add_user'.tr),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 18.0,
                  horizontal: 38.0,
                ),
                child: AppText(
                  'add_user_note'.tr,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: errorColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _addUser(AnimationController animationController) async {
    if (nameController.text.isEmpty) {
      nameState.currentState?.shake();
      return;
    } else if (phoneController.text.isEmpty) {
      phoneState.currentState?.shake();
      return;
    } else if (passwordController.text.isEmpty) {
      passwordState.currentState?.shake();
      return;
    }
    animationController.forward();

    await Get.find<UsersController>().addUser(
      name: nameController.text,
      phone: phoneController.text,
      password: passwordController.text,
    );

    animationController.reverse();
  }
}
