import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:vpm/app/config/app_color.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/data/providers/storage/local_provider.dart';
import 'package:vpm/domain/entities/models/booking_model.dart';
import 'package:vpm/presentation/controller/booking_controller/booking_controller.dart';
import 'package:vpm/presentation/controller/parking_controller/parking_controller.dart';
import 'package:vpm/presentation/screens/home/pages/booking/components/current/timer_view.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';
import 'package:vpm/presentation/widgets/google_map_bottom_sheet.dart';
import 'package:vpm/presentation/widgets/modal_bottom_sheet.dart';

import '../../../../../../../app/res/res.dart';
import '../../../../../../../app/util/constants.dart';
import '../../../../../../../app/util/information_viewer.dart';
import '../../../../../../../app/util/operation_reply.dart';
import '../../../../../../../app/util/util.dart';
import '../../../../../../../data/models/general_response.dart';
import '../../../../../../../data/providers/network/api_provider.dart';
import '../../../menu/components/qr_code_view.dart';

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
            if (bookingModel.endDriver != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  'your_request_accepted'.tr,
                  maxLines: 2,
                  centerText: true,
                  fontSize: 16,
                  color: Colors.green,
                ),
              ),
            if ((bookingModel.hasEndRequest ?? false) &&
                bookingModel.endDriver == null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppText(
                  'you_already_sent'.tr,
                  maxLines: 2,
                  centerText: true,
                  fontSize: 16,
                  color: hintColor,
                ),
              ),
            if (bookingModel.garage?.type?.code == 2 &&
                bookingModel.startConfirmedAt != null &&
                bookingModel.endDriver == null)
              GestureDetector(
                onTap: () {
                  _requestEndValet();
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(kRadius),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 28.0,
                    ),
                    child: AppText(
                      (bookingModel.hasEndRequest ?? false)
                          ? 'resend_end_parking'.tr
                          : 'end_parking'.tr,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            if (bookingModel.startConfirmedAt != null)
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (bookingModel.endDriver == null)
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.map,
                              color: Colors.green,
                            ),
                            10.pw,
                            AppText(
                              'car_parked'.tr,
                              fontSize: 14,
                              fontWeight: FontWeight.w100,
                              color: Colors.green,
                            ),
                          ],
                        ),
                      if (bookingModel.startLatitude != null &&
                          bookingModel.startLongitude != null)
                        ElevatedButton(
                          onPressed: () {
                            showAppModalBottomSheet(
                              context: context,
                              initialChildSize: 0.8,
                              minChildSize: 0.7,
                              builder: (context, scrollController) =>
                                  GoogleMapBottomSheet(
                                bookingId: bookingModel.id!,
                                latLng: LatLng(
                                  // 30.95712249827692, 31.19021671167132
                                  double.parse(bookingModel.startLatitude),
                                  double.parse(bookingModel.startLongitude),
                                ),
                              ),
                            );
                          },
                          child: AppText(
                            'show_on_map'.tr,
                          ),
                        ),
                      if (bookingModel.endDriver != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 28.0),
                          child: GestureDetector(
                            onTap: () {
                              Get.dialog(
                                QrCodeView(
                                  qrValue: LocalProvider().getUser()?.id ?? '',
                                ),
                              );
                            },
                            child: const Icon(
                              Icons.qr_code,
                              color: Colors.green,
                              size: 30,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future _requestEndValet() async {
    EasyLoading.show();
    LatLng myLocation = Get.find<ParkingController>().myLocation;
    OperationReply operationReply = await APIProvider.instance.post(
      endPoint: Res.apiRequestEndParking,
      fromJson: GeneralResponse.fromJson,
      requestBody: {
        'parking_id': bookingModel.id,
        'garage_id': bookingModel.garage?.id,
        'longitude': myLocation.latitude,
        'latitude': myLocation.longitude,
      },
    );
    EasyLoading.dismiss();

    if (operationReply.isSuccess()) {
      GeneralResponse generalResponse = operationReply.result;
      InformationViewer.showSuccessToast(msg: generalResponse.message);
      Get.find<BookingController>().refreshApiCall();
    } else {
      InformationViewer.showErrorToast(msg: operationReply.message);
    }
  }
}
