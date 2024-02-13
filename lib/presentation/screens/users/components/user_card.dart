import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/data/models/contacts_response.dart';
import 'package:vpm/presentation/controller/users_controller/users_controller.dart';

import '../../../../app/config/app_color.dart';
import '../../../widgets/app_widgets/app_cached_image.dart';
import '../../../widgets/app_widgets/app_dialog.dart';
import '../../../widgets/app_widgets/app_text.dart';
import '../../add_user/add_user_screen.dart';

class UserCard extends StatelessWidget {
  final ContactModel user;

  const UserCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppCachedImage(
            imageUrl: user.avatar?.filePath,
            isCircular: true,
            borderWidth: 1,
            height: 80,
            width: 80,
            borderColor: Theme.of(context).primaryColor,
          ),
          10.pw,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: AppText(
                user.name ?? '',
                fontSize: 16,
                fontWeight: FontWeight.w700,
                maxLines: 3,
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              await PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: AddUserScreen(user: user),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
              Get.find<UsersController>().getAllContacts(loading: false);
            },
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {
              scaleAlertDialog(
                context: context,
                title: 'delete'.tr,
                body: 'delete_message'.tr,
                cancelText: 'cancel'.tr,
                confirmText: 'submit'.tr,
                barrierDismissible: true,
                onCancelClick: () {
                  Get.back();
                },
                onConfirmClick: () async {
                  Get.back();
                  Get.find<UsersController>().deleteUser(user);
                },
              );
            },
            icon: const Icon(Icons.clear),
            color: errorColor,
          ),
        ],
      ),
    );
  }
}
