import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/app/util/information_viewer.dart';
import 'package:vpm/app/util/operation_reply.dart';
import 'package:vpm/data/models/general_response.dart';
import 'package:vpm/data/providers/network/api_provider.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_progress_button.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';

import '../../../../app/res/res.dart';
import '../create_new_password/create_new_password_screen.dart';

class VerificationCodeScreen extends StatefulWidget {
  final String phone;

  const VerificationCodeScreen({super.key, required this.phone});

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  String? otpCode;
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  bool hasError = false;
  bool timerActive = false;
  CountdownController countdownController =
      CountdownController(autoStart: true);

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    timerActive = true;
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(38.0),
          child: Column(
            children: [
              AppText(
                'enter_digits'.tr,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              10.ph,
              AppText(
                widget.phone,
                color: Theme.of(context).primaryColor,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
              10.ph,
              AppText(
                'code_verify_message'.tr,
                fontWeight: FontWeight.w500,
                maxLines: 3,
                centerText: true,
              ),
              30.ph,
              PinCodeTextField(
                appContext: context,
                pastedTextStyle: TextStyle(
                  color: Colors.green.shade600,
                  fontWeight: FontWeight.bold,
                ),
                length: 4,
                obscureText: false,
                // obscuringCharacter: '*',
                // obscuringWidget: const FlutterLogo(
                //   size: 24,
                // ),
                blinkWhenObscuring: true,
                animationType: AnimationType.fade,
                // validator: (v) {
                //   if (v!.length < 3) {
                //     return "I'm from validator";
                //   } else {
                //     return null;
                //   }
                // },
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.underline,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 60,
                  selectedColor: Theme.of(context).primaryColor,
                  activeFillColor: Colors.white,
                  inactiveColor: Theme.of(context).primaryColor,
                  selectedFillColor: Colors.white,
                  inactiveFillColor: Colors.white,
                ),
                cursorColor: Theme.of(context).primaryColor,
                animationDuration: const Duration(milliseconds: 300),
                enableActiveFill: true,
                errorAnimationController: errorController,
                controller: textEditingController,
                keyboardType: TextInputType.number,
                boxShadows: const [
                  BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.black12,
                    blurRadius: 10,
                  )
                ],
                onCompleted: (v) {
                  debugPrint("Completed $v");
                },
                onChanged: (value) {
                  debugPrint(value);
                  setState(() {
                    otpCode = value;
                  });
                },
                beforeTextPaste: (text) {
                  debugPrint("Allowing to paste $text");
                  return true;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError ? "file_code_error".tr : "",
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              20.ph,
              AppText("don't_receive_code".tr),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText('new_code'.tr),
                  10.pw,
                  timerActive
                      ? Countdown(
                          controller: countdownController,
                          seconds: 60,
                          build: (BuildContext context, double time) => AppText(
                            formattedTime(
                              time.toInt(),
                            ),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                          interval: const Duration(milliseconds: 1000),
                          onFinished: () {
                            setState(() {
                              timerActive = false;
                            });
                          },
                        )
                      : AppProgressButton(
                          elevation: 0,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          textColor: Theme.of(context).primaryColor,
                          width: 120,
                          onPressed: (animationController) async {
                            _resendSms(animationController);
                          },
                          text: 'reSend'.tr,
                        ),
                ],
              ),
              30.ph,
              AppProgressButton(
                text: 'submit'.tr,
                onPressed: (animationController) async {
                  _verifySms(animationController);
                },
                width: MediaQuery.sizeOf(context).width * 0.8,
              ),
              100.ph,
            ],
          ),
        ),
      ),
    );
  }

  String formattedTime(int time) // --> time in form of seconds
  {
    final int sec = time % 60;
    final int min = (time / 60).floor();
    return "${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}";
  }

  void _resendSms(AnimationController animationController) async {
    animationController.forward();

    OperationReply operationReply = await APIProvider.instance.post(
      endPoint: Res.apiSendResetPasswordCode,
      fromJson: GeneralResponse.fromJson,
      requestBody: {
        'phone': widget.phone,
      },
    );
    animationController.reverse();

    if (operationReply.isSuccess()) {
      GeneralResponse generalResponse = operationReply.result;
      InformationViewer.showSuccessToast(msg: generalResponse.message);
      Get.to(
        () => VerificationCodeScreen(
          phone: widget.phone,
        ),
      );
    } else {
      InformationViewer.showErrorToast(msg: operationReply.message);
    }

    setState(() {
      timerActive = true;
    });
    countdownController.start();
  }

  void _verifySms(AnimationController animationController) async {
    animationController.forward();
    OperationReply operationReply = await APIProvider.instance.post(
      endPoint: Res.apiVerifyCode,
      fromJson: GeneralResponse.fromJson,
      requestBody: {
        'reset_password_code': otpCode,
      },
    );
    animationController.reverse();
    if (operationReply.isSuccess()) {
      GeneralResponse generalResponse = operationReply.result;
      InformationViewer.showSuccessToast(msg: generalResponse.message);
      Get.to(
        () => CreateNewPasswordScreen(
          otpCode: otpCode!,
        ),
      );
    } else {
      InformationViewer.showErrorToast(msg: operationReply.message);
    }
  }
}
