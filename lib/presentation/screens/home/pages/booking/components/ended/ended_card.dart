import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';
import 'package:vpm/app/config/app_color.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/app/util/util.dart';
import 'package:vpm/domain/entities/models/booking_model.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';

import '../../../../../../../app/util/constants.dart';

class EndedCard extends StatelessWidget {
  final BookingModel bookingModel;

  const EndedCard({required this.bookingModel, super.key});

  @override
  Widget build(BuildContext context) {
    Duration difference =
        DateTime.tryParse(bookingModel.endsAt ?? '')?.difference(
              DateTime.tryParse(bookingModel.startsAt ?? '') ?? DateTime.now(),
            ) ??
            const Duration(milliseconds: 100);

    int hours = ((difference.inMinutes / 60) - bookingModel.freeHours!).ceil();

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
                    fontWeight: FontWeight.w600,
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
                        DateFormat.HOUR_MINUTE_SECOND,
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
            Row(
              children: [
                Expanded(
                  child: AppText(
                    'end_date'.tr,
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
                      DateTime.tryParse(
                            bookingModel.endsAt ?? '',
                          ) ??
                          DateTime.now(),
                    ),
                  ),
                ),
              ],
            ),
            10.ph,
            if (bookingModel.endsAt != null)
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
                        DateFormat.HOUR_MINUTE_SECOND,
                        Get.locale?.languageCode,
                      ).format(
                        DateTime.parse(
                          bookingModel.endsAt!,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            if (bookingModel.garage?.type?.code == 1) 10.ph,
            if (bookingModel.hourCost != null &&
                bookingModel.garage?.type?.code == 1)
              Row(
                children: [
                  Expanded(
                    child: AppText(
                      bookingModel.garage?.type?.code == 1
                          ? 'hour_cost'.tr
                          : 'total_cost'.tr,
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
                        if (bookingModel.garage?.type?.code == 1)
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
            if (bookingModel.garage?.type?.code == 1) 10.ph,
            if (bookingModel.garage?.type?.code == 1)
              Row(
                children: [
                  Expanded(
                    child: AppText(
                      'total_hours'.tr,
                      color: hintColor,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: AppText(
                      hours <= 0 ? "1" : hours.toString(),
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            10.ph,
            if (bookingModel.totalCost != null)
              Row(
                children: [
                  Expanded(
                    child: AppText(
                      'total_cost'.tr,
                      color: hintColor,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: AppText(
                      bookingModel.garage?.type?.code == 1
                          ? bookingModel.totalCost == 0
                              ? 'free'.tr
                              : Utils().formatNumbers(
                                  bookingModel.totalCost.toString(),
                                )
                          : bookingModel.totalCost.toString(),
                      fontSize: 18,
                      color: bookingModel.totalCost == 0
                          ? Colors.green
                          : Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
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
