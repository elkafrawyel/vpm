import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/app/res/res.dart';
import 'package:vpm/app/util/information_viewer.dart';
import 'package:vpm/app/util/operation_reply.dart';
import 'package:vpm/app/util/util.dart';
import 'package:vpm/data/models/general_response.dart';
import 'package:vpm/data/providers/network/api_provider.dart';
import 'package:vpm/presentation/controller/parking_controller.dart';

import '../../../../../../app/util/constants.dart';
import '../../../../../../domain/entities/models/garage_model.dart';
import '../../../../../widgets/app_widgets/app_text.dart';

class GarageDetailsView extends StatelessWidget {
  final ScrollController scrollController;

  final GarageModel element;
  final LatLng myLocation;

  const GarageDetailsView({
    super.key,
    required this.scrollController,
    required this.element,
    required this.myLocation,
  });

  @override
  Widget build(BuildContext context) {
    double distance = Geolocator.distanceBetween(
      myLocation.latitude,
      myLocation.longitude,
      double.parse(element.latitude!),
      double.parse(element.longitude!),
    );

    double infoWidth = 80;
    String howFar = distance > 1000
        ? Utils().formatNumbers(
            (distance / 1000).toString(),
            symbol: 'km'.tr,
            digits: 2,
          )
        : Utils().formatNumbers(
            distance.toString(),
            symbol: 'm'.tr,
            digits: 2,
          );
    String assetPath = "";

    if (element.type?.code == 1) {
      assetPath =
          element.isAvailable ? Res.garagePinImage : Res.redGaragePinImage;
    } else {
      assetPath = Res.valetPinImage;
      // assetPath =
      //     element.isAvailable ? Res.valetPinImage : Res.redValetPinImage;
    }
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(kRadius * 2),
      ),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadiusDirectional.vertical(
                  top: Radius.circular(kRadius * 2),
                ),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 8.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              assetPath,
                              width: 50,
                              height: 50,
                            ),
                            10.pw,
                            AppText(
                              element.name ?? '',
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).primaryColor,
                            ),
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: Get.back,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.clear,
                              size: 30,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            20.ph,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    AppText(
                      Utils().formatNumbers(
                        element.hourCost.toString(),
                      ),
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 24,
                    ),
                    AppText(
                      'per_hour'.tr,
                      color: Colors.white,
                    ),
                  ],
                ),
                if (element.type?.code == 1) 40.pw,
                if (element.type?.code == 1)
                  Column(
                    children: [
                      AppText(
                        element.availableCarCount == 0
                            ? 'garage_completed'.tr
                            : element.availableCarCount?.toString() ?? '0',
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      if (element.availableCarCount != 0)
                        AppText(
                          'available_spaces'.tr,
                          color: Colors.white,
                        ),
                    ],
                  ),
              ],
            ),
            30.ph,
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    width: infoWidth,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(Res.iconClock),
                        5.ph,
                        AppText(
                          DateFormat(
                            DateFormat.HOUR24_MINUTE,
                            Get.locale?.languageCode,
                          ).format(
                            DateTime.parse(
                              element.openAt!,
                            ),
                          ),
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                        AppText(
                          DateFormat(
                            DateFormat.HOUR24_MINUTE,
                            Get.locale?.languageCode,
                          ).format(
                            DateTime.parse(
                              element.closeAt!,
                            ),
                          ),
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: infoWidth,
                    child: Column(
                      children: [
                        SvgPicture.asset(Res.iconCamera),
                        5.ph,
                        AppText(
                          'cctv'.tr,
                          color: Colors.white,
                          fontSize: 16,
                          maxLines: 4,
                          fontWeight: FontWeight.w700,
                          centerText: true,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: infoWidth,
                    child: Column(
                      children: [
                        SvgPicture.asset(Res.iconStaff),
                        5.ph,
                        AppText(
                          'staff'.tr,
                          color: Colors.white,
                          fontSize: 16,
                          maxLines: 2,
                          fontWeight: FontWeight.w700,
                          centerText: true,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: infoWidth,
                    child: Column(
                      children: [
                        SvgPicture.asset(Res.iconGarageLocation),
                        5.ph,
                        AppText(
                          howFar,
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            20.ph,
            GestureDetector(
              onTap: () {
                Get.back();
                Get.find<ParkingController>().getDirectionsToDestination(
                  lineId: element.id!,
                  destination: PointLatLng(
                    double.parse(element.latitude!),
                    double.parse(element.longitude!),
                  ),
                );
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 1.5,
                decoration: BoxDecoration(
                  color: const Color(0xffE6AF1D),
                  borderRadius: BorderRadius.circular(kRadius),
                  border: Border.all(
                    color: Colors.white,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 18.0,
                    ),
                    child: AppText(
                      element.type?.code == 1
                          ? 'navigate_to_car_parking'.tr
                          : 'navigate_to_valet'.tr,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            20.ph,
            if (element.type?.code == 2)
              GestureDetector(
                onTap: () {
                  _requestValet();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  decoration: BoxDecoration(
                    color: const Color(0xffE6AF1D),
                    borderRadius: BorderRadius.circular(kRadius),
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 18.0,
                      ),
                      child: AppText(
                        'request_valet'.tr,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
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

  Future _requestValet() async {
    EasyLoading.show();
    OperationReply operationReply = await APIProvider.instance.post(
      endPoint: Res.apiRequestDriver,
      fromJson: GeneralResponse.fromJson,
      requestBody: {
        'garage_id': element.id,
      },
    );
    EasyLoading.dismiss();

    if (operationReply.isSuccess()) {
      Get.back();
      GeneralResponse generalResponse = operationReply.result;
      InformationViewer.showSuccessToast(msg: generalResponse.message);
    } else {
      InformationViewer.showErrorToast(msg: operationReply.message);
    }
  }
}
