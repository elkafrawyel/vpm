import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vpm/app/res/res.dart';
import 'package:vpm/app/util/util.dart';
import 'package:vpm/presentation/widgets/dialogs_view/app_dialog_view.dart';

class ParkingController extends GetxController with WidgetsBindingObserver {
  GoogleMapController? mapController;
  Position? myLocation;
  String googleAPiKey = "AIzaSyCDzltRvdehaa-81Gh7T0JGW-s3x6igHMg";

  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
    _determinePosition();
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        _determinePosition();
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.hidden:
        break;
      case AppLifecycleState.paused:
        break;
    }
  }

  void onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        openSettingDialog();

        Future.error('Location permissions are denied');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      openSettingDialog();

      Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');

      return;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.

    EasyLoading.show(status: 'getting_location'.tr);
    myLocation = await Geolocator.getCurrentPosition();
    EasyLoading.dismiss();
    update();
    animateToPosition(myLocation);
  }

  openSettingDialog() {
    Get.dialog(
      AppDialogView(
        title: 'location_permission'.tr,
        message: 'location_permission_message'.tr,
        onActionClicked: () async {
          Get.back();
          openAppSettings();
        },
        actionText: 'ok'.tr,
        svgName: Res.iconLocation,
      ),
    );
  }

  animateToPosition(Position? position) {
    if (position != null && mapController != null) {
      mapController!.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(position.latitude, position.longitude),
        14,
      ));
    } else {
      Utils.logMessage('AnimateCamera failed.');
    }
  }
}
