import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpm/app/util/operation_reply.dart';
import 'package:vpm/data/repositories/auth_repository.dart';
import 'package:vpm/domain/entities/requests/login_request.dart';

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
    OperationReply operationReply = await _authRepositoryIml.login(
      loginRequest: LoginRequest(
        phoneOrEmail: email,
        password: password,
      ),
    );
    if (operationReply.isSuccess()) {
      if (rememberMe ?? false) {
        ///save email and password for next login
      }
    } else {}
    animationController.reverse();
  }

  void forgetPassword({
    required String phoneNumber,
    required AnimationController animationController,
  }) async {
    animationController.forward();
    Get.to(() => const VerificationCodeScreen(
          phone: '01019744661',
        ));
  }
}
