import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:vpm/app/config/app_color.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/app/util/constants.dart';
import 'package:vpm/domain/entities/models/car_model.dart';
import 'package:vpm/presentation/controller/my_cars_controller/my_cars_controller.dart';
import 'package:vpm/presentation/screens/add_car/add_car_screen.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_cached_image.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_dialog.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';

class CarCard extends StatelessWidget {
  final CarModel car;

  const CarCard({
    super.key,
    required this.car,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      color: const Color(0xffF4F4F4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadius),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppCachedImage(
            imageUrl: car.image?.filePath,
            width: 130,
            height: 120,
            radius: 4,
          ),
          10.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: AppText(
                        car.name ?? '',
                        fontSize: 16,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w700,
                        maxLines: 2,
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await PersistentNavBarNavigator.pushNewScreen(
                              context,
                              screen: AddCarScreen(car: car),
                              withNavBar: true,
                              pageTransitionAnimation:
                                  PageTransitionAnimation.cupertino,
                            );
                            Get.find<MyCarsController>()
                                .getMyCars(loading: false);
                          },
                          child: Icon(
                            Icons.edit,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        10.pw,
                        GestureDetector(
                          onTap: () {
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
                                Get.find<MyCarsController>().deleteCar(car);
                              },
                            );
                          },
                          child: const Icon(
                            Icons.delete_forever_outlined,
                            color: errorColor,
                          ),
                        ),
                        // InkWell(
                        //   child: SvgPicture.asset(Res.iconScan),
                        // ),
                      ],
                    ),
                  ],
                ),
                5.ph,
                AppText(
                  car.type?.name ?? '',
                  fontSize: 14,
                  // color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w400,
                ),
                5.ph,
                AppText(
                  car.number ?? '',
                  color: hintColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
              ],
            ),
          ),
          10.ph,
        ],
      ),
    );
  }
}
