import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/app/util/constants.dart';
import 'package:vpm/data/providers/storage/local_provider.dart';
import 'package:vpm/presentation/controller/parking_controller.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';

class AddressView extends StatelessWidget {
  const AddressView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18.0),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.8),
        borderRadius: BorderRadius.circular(kRadius),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
            10.pw,
            Expanded(
              child: GetBuilder<ParkingController>(
                id: ParkingController.addressControllerId,
                builder: (parkingController) {
                  return parkingController.myAddressAr == null ||
                          parkingController.myAddressEn == null
                      ? SpinKitWave(
                          color: Theme.of(context).primaryColor,
                          size: 25,
                        )
                      : AppText(
                          LocalProvider().isAr()
                              ? parkingController.myAddressAr!
                              : parkingController.myAddressEn!,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          maxLines: 2,
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
