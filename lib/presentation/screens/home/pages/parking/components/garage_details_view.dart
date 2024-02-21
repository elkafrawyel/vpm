import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/app/res/res.dart';
import 'package:vpm/presentation/controller/parking_controller/parking_controller.dart';

import '../../../../../../app/util/constants.dart';
import '../../../../../widgets/app_widgets/app_text.dart';

class GarageDetailsView extends StatelessWidget {
  final ScrollController scrollController;

  final GarageModel element;

  const GarageDetailsView({
    super.key,
    required this.scrollController,
    required this.element,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.7),
        borderRadius: BorderRadius.circular(kRadius * 2),
      ),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: AppText(
                element.name,
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.white,
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 28.0,
                  vertical: 8.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        AppText(
                          '5.75',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                        AppText(
                          'SAR/Hour',
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        AppText(
                          '30',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                        AppText(
                          'Available Spaces',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            20.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(Res.iconClock),
                    5.ph,
                    AppText(
                      '08:00 - 23:30',
                      color: Colors.white,
                    )
                  ],
                ),
                Column(
                  children: [
                    SvgPicture.asset(Res.iconCamera),
                    5.ph,
                    AppText(
                      'CCTV',
                      color: Colors.white,
                    )
                  ],
                ),
                Column(
                  children: [
                    SvgPicture.asset(Res.iconStaff),
                    5.ph,
                    AppText(
                      'Staff',
                      color: Colors.white,
                    )
                  ],
                ),
                Column(
                  children: [
                    SvgPicture.asset(Res.iconGarageLocation),
                    5.ph,
                    AppText(
                      '1221 km',
                      color: Colors.white,
                    )
                  ],
                ),
              ],
            ),
            10.ph,
            GestureDetector(
              onTap: () {
                Get.back();
                Get.find<ParkingController>().getRouteToDestination(
                  lineId: element.id,
                  destination: element.latLng,
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xffE6AF1D),
                  borderRadius: BorderRadius.circular(kRadius),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 18.0,
                  ),
                  child: AppText(
                    'navigate_to_car_parking'.tr,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            20.ph,
          ],
        ),
      ),
    );
  }
}
