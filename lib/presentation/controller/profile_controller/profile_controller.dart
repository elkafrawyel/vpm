import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vpm/app/util/information_viewer.dart';
import 'package:vpm/app/util/util.dart';
import 'package:vpm/data/models/user_response.dart';
import 'package:vpm/data/repositories/auth_repository.dart';
import 'package:vpm/domain/entities/models/user_model.dart';
import 'package:vpm/domain/entities/requests/update_profile_request.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_gender_picker.dart';

import '../../../app/util/operation_reply.dart';
import '../../../data/models/upload_file_response.dart';
import '../../../data/repositories/lookups_repository.dart';

class ProfileController extends GetxController {
  UserModel? _userModel;
  final AuthRepositoryIml _authRepositoryIml;
  final LookUpsRepositoryIml _lookUpsRepositoryIml;

  ProfileController(
    this._authRepositoryIml,
    this._lookUpsRepositoryIml,
  );

  @override
  void onInit() {
    super.onInit();
    getUserProfile();
  }

  UserModel? get userModel => _userModel;

  set userModel(UserModel? value) {
    _userModel = value;
    update();
  }

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    update();
  }

  Future<void> getUserProfile() async {
    loading = true;
    OperationReply operationReply = await _authRepositoryIml.profile();

    if (operationReply.isSuccess()) {
      UserResponse? userResponse = operationReply.result;
      userModel = userResponse?.userModel;
      Utils.logMessage('User Model ===>\n${userModel?.toJson().toString()}');
    }
    loading = false;
  }

  void updateProfile({
    required BuildContext context,
    required AnimationController animationController,
    required String name,
    required String email,
    required String phone,
    File? image,
    AppGender? gender,
    DateTime? birthday,
  }) async {
    //todo image not null update image with file id in user model

    String? fileId = userModel?.avatar?.id;
    if (image != null) {
      OperationReply<UploadFileResponse> uploadOperationReply = await _lookUpsRepositoryIml.uploadFile(
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
        fileId = uploadFileResponse?.data?.id;
      } else {
        InformationViewer.showSnackBar(uploadOperationReply.message);
      }
    }

    animationController.forward();
    OperationReply operationReply = await _authRepositoryIml.updateProfileInformation(
      updateProfileRequest: UpdateProfileRequest(
        name: name,
        email: email,
        phone: phone,
        birthday: birthday == null ? userModel?.birthday : DateFormat('yyyy-MM-dd').format(birthday),
        gender: gender == null ? userModel?.gender : gender.name,
        fileId: fileId,
      ),
    );

    animationController.reverse();

    if (operationReply.isSuccess()) {
      UserResponse? userResponse = operationReply.result;
      userModel = userResponse?.userModel;
      InformationViewer.showSnackBar(userResponse?.message);

      if (!context.mounted) return;
      Navigator.pop(context);
    } else {
      InformationViewer.showSnackBar(operationReply.message);
    }
  }
}
