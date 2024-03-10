import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';
import 'package:vpm/app/config/app_color.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/domain/entities/models/booking_model.dart';
import 'package:vpm/presentation/screens/home/pages/booking/components/current/timer_view.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';

import '../../../../../../../app/util/constants.dart';
import '../../../../../../../app/util/util.dart';

class CurrentCard extends StatelessWidget {
  final BookingModel bookingModel;

  const CurrentCard({required this.bookingModel, super.key});

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
                Expanded(
                  flex: 2,
                  child: AppText(
                    bookingModel.garage?.name ?? '',
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
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
                Expanded(
                  flex: 2,
                  child: AppText(
                    DateFormat(
                      DateFormat.YEAR_ABBR_MONTH_WEEKDAY_DAY,
                      Get.locale?.languageCode,
                    ).format(
                      DateTime.parse(
                        bookingModel.startsAt!,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            10.ph,
            if (bookingModel.startsAt != null)
              Row(
                children: [
                  Expanded(
                    child: AppText(
                      'time'.tr,
                      color: hintColor,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: AppText(
                      DateFormat(
                        DateFormat.HOUR_MINUTE,
                        Get.locale?.languageCode,
                      ).format(
                        DateTime.parse(
                          bookingModel.startsAt!,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            10.ph,
            if (bookingModel.hourCost != null)
              Row(
                children: [
                  Expanded(
                    child: AppText(
                      'hour_cost'.tr,
                      color: hintColor,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        AppText(
                          Utils().formatNumbers(
                            bookingModel.hourCost.toString(),
                          ),
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                        ),
                        AppText(
                          'per_hour'.tr,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          fontSize: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            10.ph,
            if (bookingModel.startsAt != null)
              Center(
                child: TimerView(
                  startTime: bookingModel.startsAt!,
                  freeHours: bookingModel.freeHours ?? 0,
                  perHour: bookingModel.hourCost ?? 0,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
