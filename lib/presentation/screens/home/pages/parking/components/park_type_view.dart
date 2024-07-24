import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:get/instance_manager.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:vpm/presentation/controller/parking_controller.dart';

class ParkTypeView extends StatelessWidget {
  const ParkTypeView({super.key});

  @override
  Widget build(BuildContext context) {
    final parkingController = Get.find<ParkingController>();
    return Obx(
      () => ToggleSwitch(
        minWidth: MediaQuery.sizeOf(context).width * 3,
        initialLabelIndex: parkingController.parkType.value - 1,
        cornerRadius: 8.0,
        activeFgColor: Colors.white,
        inactiveBgColor: Colors.white,
        inactiveFgColor: Colors.black,
        totalSwitches: 2,
        labels: [
          'parking_option'.tr,
          'valet_option'.tr,
        ],
        activeBgColors: [
          [Theme.of(context).primaryColor],
          [Theme.of(context).primaryColor],
        ],
        onToggle: (int? index) async {
          parkingController.handleParkTypeChange(index ?? 0);
        },
      ),
    );
  }
}
