import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/presentation/controller/users_controller/users_controller.dart';

import '../../../widgets/app_widgets/app_text.dart';
import '../../add_user/add_user_screen.dart';

class UsersEmptyView extends StatelessWidget {
  const UsersEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Icon(
            Icons.group,
            color: Theme.of(context).dividerColor,
            size: 100,
          ),
          30.ph,
          AppText(
            "you don't have any members added in your account.",
            fontSize: 16,
            color: Theme.of(context).dividerColor,
            centerText: true,
          ),
          30.ph,
          ElevatedButton(
            onPressed: () async {
              await PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: const AddUserScreen(),
                withNavBar: true,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
              Get.find<UsersController>().getAllContacts();
            },
            child: AppText(
              'start adding new members',
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
