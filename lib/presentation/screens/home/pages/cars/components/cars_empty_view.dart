import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/app/res/res.dart';
import 'package:vpm/presentation/controller/my_cars_controller.dart';
import 'package:vpm/presentation/screens/add_car/add_car_screen.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';

class CarsEmptyView extends StatelessWidget {
  const CarsEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Flexible(
            child: SvgPicture.asset(
              Res.iconEmptyCars,
            ),
          ),
          AppText(
            "no_cars".tr,
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
                  screen: const AddCarScreen(),
                  withNavBar: true,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
                Get.find<MyCarsController>().getMyCars(loading: false);
              },
              child: AppText(
                'add_new_car'.tr,
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
