import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/route_manager.dart';

import '../../../../../../app/config/app_color.dart';
import '../../../../../../app/util/information_viewer.dart';
import '../../../../../../app/util/operation_reply.dart';
import '../../../../../../data/models/general_response.dart';
import '../../../../../../data/providers/storage/local_provider.dart';
import '../../../../../../data/repositories/auth_repository.dart';
import '../../../../../widgets/app_widgets/app_dialog.dart';

class LogOutView extends StatelessWidget {
  const LogOutView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      splashColor: Colors.transparent,
      leading: const Icon(
        Icons.logout,
        color: errorColor,
      ),
      title: Text(
        'logout'.tr,
        style: const TextStyle(
          color: errorColor,
          fontWeight: FontWeight.w700,
        ),
      ),
      onTap: () {
        scaleAlertDialog(
          context: context,
          title: 'logout'.tr,
          body: 'logout_message'.tr,
          cancelText: 'cancel'.tr,
          confirmText: 'submit'.tr,
          barrierDismissible: true,
          onCancelClick: () {
            Get.back();
          },
          onConfirmClick: () async {
            Get.back();
            _logout();
          },
        );
      },
    );
  }

  void _logout() async {
    EasyLoading.show();

    OperationReply operationReply = await AuthRepositoryIml().logOut();
    EasyLoading.dismiss();

    if (operationReply.isSuccess()) {
      GeneralResponse generalResponse = operationReply.result;
      InformationViewer.showSnackBar(generalResponse.message);
      await Future.delayed(const Duration(milliseconds: 500));
      await LocalProvider().signOut();
    } else {
      InformationViewer.showSnackBar(operationReply.message);
    }
  }
}
