import 'dart:async';
import 'dart:io';

import 'package:vpm/data/models/general_response.dart';

import '../../app/res/res.dart';
import '../../app/util/operation_reply.dart';
import '../../domain/entities/requests/change_password_request.dart';
import '../../domain/entities/requests/change_phone_request.dart';
import '../../domain/entities/requests/login_request.dart';
import '../../domain/entities/requests/register_request.dart';
import '../../domain/entities/requests/update_profile_request.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/user_response.dart';
import '../providers/network/api_provider.dart';

class AuthRepositoryIml extends AuthRepository {
  @override
  Future<OperationReply<UserResponse>> login(
      {required LoginRequest loginRequest}) async {
    return await APIProvider.instance.post<UserResponse>(
      endPoint: Res.apiLogin,
      fromJson: UserResponse.fromJson,
      requestBody: {
        'user': loginRequest.phoneOrEmail,
        'password': loginRequest.password,
      },
    );
  }

  @override
  Future<OperationReply<UserResponse>> register({
    required RegisterRequest registerRequest,
  }) async {
    return await APIProvider.instance.post<UserResponse>(
      endPoint: Res.apiRegister,
      fromJson: UserResponse.fromJson,
      requestBody: registerRequest.toJson(),
    );
  }

  @override
  Future<OperationReply<UserResponse>> profile() async {
    return APIProvider.instance.get(
      endPoint: Res.apiProfile,
      fromJson: UserResponse.fromJson,
    );
  }

  @override
  Future<OperationReply<UserResponse>> forgetPasswordByEmail(
      {required String email}) async {
    return OperationReply.failed();
  }

  @override
  Future<OperationReply<UserResponse>> forgetPasswordByPhone(
      {required String phone}) async {
    return OperationReply.failed();
  }

  @override
  Future<OperationReply<void>> changePassword(
      {required ChangePasswordRequest changePasswordRequest}) async {
    return OperationReply.failed();
  }

  @override
  Future<OperationReply<void>> changePhoneNumber(
      {required ChangePhoneRequest changePhoneRequest}) async {
    return OperationReply.failed();
  }

  @override
  Future<OperationReply<void>> deleteAccount() async {
    return OperationReply.failed();
  }

  @override
  Future<OperationReply<GeneralResponse>> logOut() async {
    return await APIProvider.instance.post<GeneralResponse>(
      endPoint: Res.apiLogout,
      fromJson: GeneralResponse.fromJson,
      requestBody: {},
    );
  }

  @override
  Future<OperationReply<void>> resendSms({required String phone}) async {
    return OperationReply.failed();
  }

  @override
  Future<OperationReply<UserResponse>> updateProfileAvatar(
      {required File image}) async {
    return OperationReply.failed();
  }

  @override
  Future<OperationReply<UserResponse>> updateProfileInformation({
    required UpdateProfileRequest updateProfileRequest,
  }) async {
    return APIProvider.instance.patch<UserResponse>(
      endPoint: Res.apiUpdateProfile,
      requestBody: updateProfileRequest.toJson(),
      fromJson: UserResponse.fromJson,
    );
  }

  @override
  Future<OperationReply<void>> verifyOtpCode({required String code}) async {
    return OperationReply.failed();
  }
}
