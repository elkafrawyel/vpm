import 'dart:async';
import 'dart:io';

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
        'email': loginRequest.phoneOrEmail,
        'password': loginRequest.password,
        "fcm_token": loginRequest.fcmToken,
        'is_mobile': true,
      },
    );
  }

  @override
  Future<OperationReply<UserResponse>> register(
      {required RegisterRequest registerRequest}) async {
    return OperationReply.failed();
  }

  @override
  Future<OperationReply<UserResponse>> profile({required int userId}) async {
    return OperationReply.failed();
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
  Future<OperationReply<void>> logOut() async {
    return OperationReply.failed();
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
    return OperationReply.failed();
  }

  @override
  Future<OperationReply<void>> verifyOtpCode({required String code}) async {
    return OperationReply.failed();
  }
}
