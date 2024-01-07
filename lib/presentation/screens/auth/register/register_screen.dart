import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_progress_button.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text_field/app_text_field.dart';

import '../../../../app/res/res.dart';
import '../../../../app/util/constants.dart';
import '../../../widgets/app_widgets/app_image_picker_dialog.dart';

class RegisterScreen extends StatefulWidget {
  final bool completingProfile;
  final String? name;
  final String? email;
  final String? profilePicture;

  const RegisterScreen({
    super.key,
    this.completingProfile = false,
    this.name,
    this.email,
    this.profilePicture,
  });

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  File? image;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController = TextEditingController();

  PhoneNumber? phoneNumber;
  final GlobalKey<AppTextFormFieldState> _nameState = GlobalKey();
  final GlobalKey<AppTextFormFieldState> _emailState = GlobalKey();
  final GlobalKey<AppTextFormFieldState> _phoneState = GlobalKey();
  final GlobalKey<AppTextFormFieldState> _passwordState = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    phoneController = TextEditingController();
    nameController = TextEditingController(text: widget.name ?? '');
    emailController = TextEditingController(text: widget.email ?? '');
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    nameController.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.completingProfile ? 'complete_profile'.tr : 'sign_up'.tr,
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            children: [
              20.ph,
              Center(
                child: Container(
                  height: 120,
                  width: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: widget.profilePicture != null
                        ? DecorationImage(
                            image: NetworkImage(widget.profilePicture!),
                            fit: BoxFit.cover,
                          )
                        : image == null
                            ? const DecorationImage(
                                image: AssetImage('assets/images/person.png'),
                                fit: BoxFit.cover,
                              )
                            : DecorationImage(
                                image: FileImage(image!),
                                fit: BoxFit.cover,
                              ),
                  ),
                  alignment: AlignmentDirectional.bottomEnd,
                  child: InkWell(
                    onTap: () {
                      _chooseProfile();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xff1D80E6),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              20.ph,
              AppTextFormField(
                key: _nameState,
                controller: nameController,
                hintText: 'name'.tr,
                radius: kRadius,
                validateEmptyText: 'name_is_required'.tr,
                appFieldType: AppFieldType.name,
                prefixIcon: Res.iconName,
              ),
              AppTextFormField(
                key: _emailState,
                controller: emailController,
                hintText: 'email'.tr,
                radius: kRadius,
                validateEmptyText: 'email_is_required'.tr,
                appFieldType: AppFieldType.email,
                prefixIcon: Res.iconEmail,
              ),
              AppTextFormField(
                key: _phoneState,
                controller: phoneController,
                hintText: '+966 xxx xxx xxx'.tr,
                radius: kRadius,
                validateEmptyText: 'phone_is_required'.tr,
                appFieldType: AppFieldType.phone,
                prefixIcon: Res.iconPhone,
              ),
              // AppPhoneTextField(
              //   key: _phoneState,
              //   onChanged: (PhoneNumber phoneNumber) {
              //     setState(() {
              //       this.phoneNumber = phoneNumber;
              //     });
              //     debugPrint(phoneNumber.completeNumber);
              //   },
              // ),
              if (!widget.completingProfile)
                AppTextFormField(
                  key: _passwordState,
                  controller: passwordController,
                  validateEmptyText: 'password_required'.tr,
                  hintText: 'password'.tr,
                  autoFillHints: const [AutofillHints.email],
                  radius: kRadius,
                  appFieldType: AppFieldType.password,
                  prefixIcon: Res.iconPassword,
                ),
              20.ph,
              AppProgressButton(
                text: widget.completingProfile ? 'continue'.tr : 'sign_up'.tr,
                width: MediaQuery.sizeOf(context).width * 0.8,
                onPressed: (animationController) async {
                  _register(animationController);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _chooseProfile() async {
    showAppImageDialog(
        context: context,
        onFilePicked: (File file) {
          setState(() {
            image = file;
          });
        });
  }

  void _register(AnimationController animationController) async {
    if (nameController.text.isEmpty ||
        (_nameState.currentState?.hasError ?? false)) {
      _nameState.currentState?.shake();
      return;
    } else if (emailController.text.isEmpty ||
        (_emailState.currentState?.hasError ?? false)) {
      _emailState.currentState?.shake();

      return;
    } else if (phoneController.text.isEmpty ||
        (_phoneState.currentState?.hasError ?? false)) {
      _phoneState.currentState?.shake();

      return;
    }

    if (!widget.completingProfile) {
      if (passwordController.text.isEmpty ||
          (_passwordState.currentState?.hasError ?? false)) {
        _passwordState.currentState?.shake();

        return;
      }
    }
  }
}
