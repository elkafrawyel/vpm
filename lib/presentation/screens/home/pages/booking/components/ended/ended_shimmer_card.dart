import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpm/app/extensions/space.dart';

import '../../../../../../../app/config/app_color.dart';
import '../../../../../../../app/util/constants.dart';
import '../../../../../../widgets/app_widgets/app_text.dart';
import '../../../../../../widgets/shimmer_widgets/shimmer_effect_ui.dart';

class EndedShimmerCard extends StatelessWidget {
  const EndedShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kRadius),
        border: Border.all(width: .5, color: hintColor),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: AppText(
                    'garage'.tr,
                    color: hintColor,
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(end: 50.0),
                    child: MyShimmerEffectUI.rectangular(
                      height: 13,
                    ),
                  ),
                ),
              ],
            ),
            10.ph,
            Row(
              children: [
                Expanded(
                  child: AppText(
                    'start_date'.tr,
                    color: hintColor,
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(end: 100.0),
                    child: MyShimmerEffectUI.rectangular(
                      height: 13,
                    ),
                  ),
                ),
              ],
            ),
            10.ph,
            Row(
              children: [
                Expanded(
                  child: AppText(
                    'time'.tr,
                    color: hintColor,
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(end: 100.0),
                    child: MyShimmerEffectUI.rectangular(
                      height: 13,
                    ),
                  ),
                ),
              ],
            ),
            10.ph,
            Row(
              children: [
                Expanded(
                  child: AppText(
                    'end_date'.tr,
                    color: hintColor,
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(end: 100.0),
                    child: MyShimmerEffectUI.rectangular(
                      height: 13,
                    ),
                  ),
                ),
              ],
            ),
            10.ph,
            Row(
              children: [
                Expanded(
                  child: AppText(
                    'time'.tr,
                    color: hintColor,
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(end: 100.0),
                    child: MyShimmerEffectUI.rectangular(
                      height: 13,
                    ),
                  ),
                ),
              ],
            ),
            10.ph,
            Row(
              children: [
                Expanded(
                  child: AppText(
                    'hour_cost'.tr,
                    color: hintColor,
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(end: 100.0),
                    child: MyShimmerEffectUI.rectangular(
                      height: 13,
                    ),
                  ),
                ),
              ],
            ),
            10.ph,
            Row(
              children: [
                Expanded(
                  child: AppText(
                    'total_hours'.tr,
                    color: hintColor,
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(end: 100.0),
                    child: MyShimmerEffectUI.rectangular(
                      height: 13,
                    ),
                  ),
                ),
              ],
            ),
            10.ph,
            Row(
              children: [
                Expanded(
                  child: AppText(
                    'total_cost'.tr,
                    color: hintColor,
                  ),
                ),
                const Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(end: 100.0),
                    child: MyShimmerEffectUI.rectangular(
                      height: 13,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
