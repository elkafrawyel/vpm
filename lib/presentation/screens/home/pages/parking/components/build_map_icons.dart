import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpm/presentation/controller/parking_controller/parking_controller.dart';

class BuildMapIcons extends StatelessWidget {
  BuildMapIcons({Key? key}) : super(key: key);

  final ParkingController parkingController = Get.find<ParkingController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 35,
          height: 35,
          child: RawMaterialButton(
            shape: const CircleBorder(),
            fillColor: Colors.white,
            elevation: 8.0,
            onPressed: () {
              parkingController.switchMapType();
            },
            child: Icon(
              Icons.layers,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 35,
          height: 35,
          child: RawMaterialButton(
            shape: const CircleBorder(),
            fillColor: Colors.white,
            elevation: 8.0,
            onPressed: () {
              parkingController.animateToPosition(parkingController.myLocation);
            },
            child: Icon(
              Icons.my_location,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
