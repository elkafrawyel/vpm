import 'dart:io';

import '../../app/util/operation_reply.dart';
import '../../data/models/general_response.dart';
import '../../data/models/user_response.dart';
import '../entities/requests/change_password_request.dart';
import '../entities/requests/change_phone_request.dart';
import '../entities/requests/login_request.dart';
import '../entities/requests/register_request.dart';
import '../entities/requests/update_profile_request.dart';


abstract class AuthRepository {
  Future<OperationReply<UserResponse>> login({required LoginRequest loginRequest});

  Future<OperationReply<UserResponse>> register({required RegisterRequest registerRequest});

  Future<OperationReply<UserResponse>> profile();

  Future<OperationReply<UserResponse>> updateProfileInformation({required UpdateProfileRequest updateProfileRequest});

  Future<OperationReply<UserResponse>> updateProfileAvatar({required File image});

  Future<OperationReply<void>> forgetPasswordByPhone({required String phone});

  Future<OperationReply<void>> forgetPasswordByEmail({required String email});

  Future<OperationReply<void>> changePassword({required ChangePasswordRequest changePasswordRequest});

  Future<OperationReply<void>> changePhoneNumber({required ChangePhoneRequest changePhoneRequest});

  Future<OperationReply<void>> verifyOtpCode({required String code});

  Future<OperationReply<void>> resendSms({required String phone});

  Future<OperationReply<void>> deleteAccount();

  Future<OperationReply<GeneralResponse>> logOut();
}
