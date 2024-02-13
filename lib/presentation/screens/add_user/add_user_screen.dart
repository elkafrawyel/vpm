import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:vpm/app/config/app_color.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/app/util/operation_reply.dart';
import 'package:vpm/data/models/contacts_response.dart';
import 'package:vpm/data/models/general_response.dart';
import 'package:vpm/presentation/controller/users_controller/users_controller.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_progress_button.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text_field/app_text_field.dart';

import '../../../app/res/res.dart';
import '../../../app/util/information_viewer.dart';

class AddUserScreen extends StatefulWidget {
  final ContactModel? user;

  const AddUserScreen({super.key, this.user});

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
    nameController = TextEditingController(text: widget.user?.name ?? '');
    passwordController = TextEditingController();
    phoneController = TextEditingController(text: widget.user?.phone ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.user == null ? 'add_user'.tr : 'edit_user'.tr),
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
              if (widget.user == null)
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
                child: AppText(
                  widget.user == null ? 'add_user'.tr : 'edit_user'.tr,
                ),
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
    } else if (passwordController.text.isEmpty && widget.user == null) {
      passwordState.currentState?.shake();
      return;
    }

    OperationReply operationReply = await Get.find<UsersController>().addUser(
      userId: widget.user?.id,
      context: context,
      animationController: animationController,
      name: nameController.text,
      phone: phoneController.text,
      password: passwordController.text,
    );

    if (operationReply.isSuccess() && mounted) {
      GeneralResponse generalResponse = operationReply.result;
      InformationViewer.showSnackBar(generalResponse.message);
      Navigator.of(context).pop();
    } else {
      InformationViewer.showSnackBar(operationReply.message);
    }
  }
}
