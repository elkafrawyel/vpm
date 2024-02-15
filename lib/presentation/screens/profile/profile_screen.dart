import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/domain/entities/models/user_model.dart';
import 'package:vpm/presentation/controller/profile_controller/profile_controller.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_date_selector.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_gender_picker.dart';

import '../../../app/res/res.dart';
import '../../../app/util/constants.dart';
import '../../widgets/app_widgets/app_cached_image.dart';
import '../../widgets/app_widgets/app_image_picker_dialog.dart';
import '../../widgets/app_widgets/app_progress_button.dart';
import '../../widgets/app_widgets/app_text_field/app_text_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.find();
  late UserModel? userModel;
  File? image;
  String? profilePicture;
  DateTime? birthday;
  AppGender? appGender;

  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController genderController = TextEditingController();

  final GlobalKey<AppTextFormFieldState> _nameState = GlobalKey();
  final GlobalKey<AppTextFormFieldState> _emailState = GlobalKey();
  final GlobalKey<AppTextFormFieldState> _phoneState = GlobalKey();

  @override
  void initState() {
    super.initState();

    userModel = profileController.userModel;
    nameController = TextEditingController(text: userModel?.name);
    emailController = TextEditingController(text: userModel?.email);
    phoneController = TextEditingController(text: userModel?.phone);
    profilePicture = userModel?.avatar?.filePath;
    birthday = DateTime.tryParse(userModel?.birthday);
    appGender = userModel?.gender == null
        ? null
        : userModel!.gender == 'male'
            ? AppGender.male
            : AppGender.female;
    genderController = TextEditingController(text: appGender?.title);
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
          'profile'.tr,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              20.ph,
              Center(
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    image == null
                        ? AppCachedImage(
                            imageUrl: profilePicture,
                            isCircular: true,
                            width: 120,
                            height: 120,
                          )
                        : AppCachedImage(
                            localFile: image,
                            isCircular: true,
                            width: 120,
                            height: 120,
                          ),
                    InkWell(
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
                  ],
                ),
              ),
              20.ph,
              AppTextFormField(
                key: _nameState,
                controller: nameController,
                hintText: 'name'.tr,
                radius: kRadius,
                validateEmptyText: 'name_is_required'.tr,
                appFieldType: AppFieldType.text,
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
              AppDateSelector(
                hint: 'birthday'.tr,
                selectedDate: birthday,
                onChanged: (DateTime? dateTime) {
                  setState(() {
                    birthday = dateTime;
                  });
                },
              ),
              InkWell(
                highlightColor: Colors.transparent,
                onTap: () {
                  showAppGenderDialog(
                    context: context,
                    onGenderPicked: (AppGender appGender) {
                      setState(() {
                        this.appGender = appGender;
                        genderController.text = appGender.title;
                      });
                    },
                  );
                },
                child: IgnorePointer(
                  child: AppTextFormField(
                    controller: genderController,
                    radius: kRadius,
                    hintText: 'gender'.tr,
                    suffixIcon: Icons.keyboard_arrow_down,
                    prefixIcon: appGender?.assetName,
                  ),
                ),
              ),
              20.ph,
              AppProgressButton(
                text: 'save'.tr,
                width: MediaQuery.sizeOf(context).width * 0.8,
                onPressed: (animationController) async {
                  updateProfile(animationController);
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

  void updateProfile(AnimationController animationController) async {
    if (nameController.text.isEmpty || (_nameState.currentState?.hasError ?? false)) {
      _nameState.currentState?.shake();
      return;
    } else if (emailController.text.isEmpty || (_emailState.currentState?.hasError ?? false)) {
      _emailState.currentState?.shake();
      return;
    } else if (phoneController.text.isEmpty || (_phoneState.currentState?.hasError ?? false)) {
      _phoneState.currentState?.shake();
      return;
    }

    profileController.updateProfile(
      context: context,
      animationController: animationController,
      name: nameController.text,
      email: emailController.text,
      phone: phoneController.text,
      image: image,
      birthday: birthday,
      gender: appGender,
    );
  }
}
