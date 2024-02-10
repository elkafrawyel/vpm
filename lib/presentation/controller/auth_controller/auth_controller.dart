import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:vpm/app/util/information_viewer.dart';
import 'package:vpm/app/util/operation_reply.dart';
import 'package:vpm/data/models/upload_file_response.dart';
import 'package:vpm/data/models/user_response.dart';
import 'package:vpm/data/providers/storage/local_provider.dart';
import 'package:vpm/data/repositories/auth_repository.dart';
import 'package:vpm/data/repositories/lookups_repository.dart';
import 'package:vpm/domain/entities/requests/login_request.dart';
import 'package:vpm/domain/entities/requests/register_request.dart';
import 'package:vpm/presentation/controller/app_config_controller.dart';
import 'package:vpm/presentation/controller/home_screen_controller/home_screen_binding.dart';
import 'package:vpm/presentation/screens/auth/register/register_screen.dart';
import 'package:vpm/presentation/screens/home/home_screen.dart';

import '../../screens/auth/verification_code/verification_code_screen.dart';

class AuthController extends GetxController {
  final AuthRepositoryIml _authRepositoryIml;

  AuthController(this._authRepositoryIml);

  void login({
    required String email,
    required String password,
    required AnimationController animationController,
    bool? rememberMe,
  }) async {
    animationController.forward();
    OperationReply<UserResponse> operationReply =
        await _authRepositoryIml.login(
      loginRequest: LoginRequest(
        phoneOrEmail: email,
        password: password,
      ),
    );
    if (operationReply.isSuccess()) {
      UserResponse? userResponse = operationReply.result;
      if (rememberMe ?? false) {
        //todo save email and password for next login
        await LocalProvider().saveUserCredentials(
          email: email,
          password: password,
        );
      }
      //todo save user model and token
      bool isSaved = await LocalProvider().saveUser(userResponse?.userModel);
      if (isSaved) {
        if (userResponse?.userModel?.isCompleted ?? false) {
          Get.offAll(
            () => RegisterScreen(
              completingProfile: true,
              name: userResponse?.userModel?.name,
              email: userResponse?.userModel?.email,
            ),
            binding: HomeScreenBinding(),
          );
        } else {
          InformationViewer.showSnackBar(userResponse?.message);

          Get.find<AppConfigController>().isLoggedIn.value = true;
        }
      }
    } else {
      InformationViewer.showSnackBar(operationReply.message);
    }
    animationController.reverse();
  }

  void forgetPassword({
    required String phoneNumber,
    required AnimationController animationController,
  }) async {
    animationController.forward();
    Get.to(
      () => const VerificationCodeScreen(
        phone: '01019744661',
      ),
    );
  }

  Future register({
    required String name,
    required String email,
    required String phone,
    required String password,
    required File image,
    required AnimationController animationController,
  }) async {
    OperationReply<UploadFileResponse> uploadOperationReply =
        await LookUpsRepositoryIml().uploadFile(
      file: image,
      onUploadProgress: (double percent) {
        EasyLoading.showProgress(
          percent,
          status: 'uploading'.tr,

        );
      },
    );
    //todo dismiss uploading view
    EasyLoading.dismiss();
    if (uploadOperationReply.isSuccess()) {
      UploadFileResponse? uploadFileResponse = uploadOperationReply.result;
      if (uploadFileResponse?.data?.id == null) {
        return;
      }
      animationController.forward();
      OperationReply<UserResponse> operationReply =
          await _authRepositoryIml.register(
        registerRequest: RegisterRequest(
          name: name,
          email: email,
          phone: phone,
          password: password,
          fileId: uploadFileResponse?.data?.id,
        ),
      );
      if (operationReply.isSuccess()) {
        UserResponse? userResponse = operationReply.result;
        //todo save user model and token
        bool isSaved = await LocalProvider().saveUser(userResponse?.userModel);
        if (isSaved) {
          Get.offAll(
            () => const HomeScreen(),
            binding: HomeScreenBinding(),
          );
        }
      } else {
        InformationViewer.showSnackBar(operationReply.message);
      }
      animationController.reverse();
    } else {
      InformationViewer.showSnackBar(uploadOperationReply.message);
    }
  }
}
