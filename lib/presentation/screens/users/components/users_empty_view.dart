import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/app/res/res.dart';
import 'package:vpm/presentation/controller/users_controller.dart';

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
          SvgPicture.asset(
            Res.iconEmptyUsers,
          ),
          AppText(
            "no_users".tr,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).primaryColor,
            centerText: true,
          ),
          30.ph,
          SizedBox(
            width: MediaQuery.of(context).size.width * .8,
            child: ElevatedButton(
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
                'add_new_user'.tr,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        ],
      ),
    );
  }
}
