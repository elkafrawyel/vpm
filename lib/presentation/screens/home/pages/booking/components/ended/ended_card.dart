import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:intl/intl.dart';
import 'package:vpm/app/config/app_color.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/app/util/util.dart';
import 'package:vpm/data/providers/storage/local_provider.dart';
import 'package:vpm/domain/entities/models/booking_model.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_cached_image.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';

import '../../../../../../../app/util/constants.dart';

class EndedCard extends StatelessWidget {
  final BookingModel bookingModel;

  const EndedCard({required this.bookingModel, super.key});

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
        padding: const EdgeInsets.all(8.0),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppCachedImage(
                imageUrl: bookingModel.car?.image?.filePath ?? '',
                width: 140,
                height: 110,
              ),
              10.pw,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: AppText(
                            bookingModel.car?.name ?? '',
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                        if (bookingModel.hourCost != null)
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
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
                                AppText('per_hour'.tr),
                              ],
                            ),
                          )
                      ],
                    ),
                    5.ph,
                    Row(
                      children: [
                        Expanded(child: AppText('garage'.tr)),
                        Expanded(
                          flex: 2,
                          child: AppText(
                            bookingModel.garage?.name ?? '',
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: hintColor,
                          ),
                        ),
                      ],
                    ),
                    5.ph,
                    Row(
                      children: [
                        Expanded(
                          child: AppText(
                            'date'.tr,
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
                    5.ph,
                    if (bookingModel.startsAt != null)
                      Row(
                        children: [
                          Expanded(
                            child: AppText(
                              'starts_at'.tr,
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
                    5.ph,
                    if (bookingModel.endsAt != null)
                      Row(
                        children: [
                          Expanded(
                            child: AppText(
                              'ends_at'.tr,
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
                    5.ph,
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
                              Utils().formatNumbers(
                                bookingModel.totalCost.toString(),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
