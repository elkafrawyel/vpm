import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vpm/app/res/res.dart';
import 'package:vpm/app/util/constants.dart';
import 'package:vpm/app/util/information_viewer.dart';
import 'package:vpm/app/util/util.dart';
import 'package:vpm/presentation/widgets/dialogs_view/app_dialog_view.dart';

class ParkingController extends GetxController with WidgetsBindingObserver {
  GoogleMapController? mapController;
  LatLng myLocation = const LatLng(0, 0);
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polyLines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

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
    Position position = await Geolocator.getCurrentPosition();
    myLocation = LatLng(position.latitude, position.longitude);
    EasyLoading.dismiss();
    update();
    animateToPosition(myLocation);
    await addMarker(
      id: 'My Location',
      latLng: myLocation,
      image: Res.locationPinImage,
    );
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

  animateToPosition(LatLng latLng) {
    if (mapController != null) {
      mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(
          latLng,
          14,
        ),
      );
    } else {
      Utils.logMessage('AnimateCamera failed.');
    }
  }

  Future addMarker({
    required String id,
    required LatLng latLng,
    String? image,
  }) async {
    BitmapDescriptor icon = BitmapDescriptor.defaultMarker;

    if (image != null) {
      /// image size 64x64
      icon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(
          platform:
              Platform.isIOS ? TargetPlatform.iOS : TargetPlatform.android,
          size: Size(30, 30),
        ),
        image,
        bundle: PlatformAssetBundle(),
      );
    }

    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
      markerId: markerId,
      icon: icon,
      position: LatLng(
        latLng.latitude,
        latLng.longitude,
      ),
      onTap: () => InformationViewer.showSnackBar(id),
    );
    markers[markerId] = marker;

    update();
  }

  /// IOS     LatLng(37.77704909733175, -122.40843415260316)
  /// ANDROID     LatLng(37.77704909733175, -122.40843415260316)

  getRouteToDestination({
    required LatLng destination,
  }) async {
    await addMarker(
      id: 'Garage 1',
      latLng: destination,
      image: Res.garagePinImage,
    );

    LatLng origin = myLocation;
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Constants.googleMapKey,
      PointLatLng(origin.latitude, origin.longitude),
      PointLatLng(destination.longitude, destination.longitude),
      travelMode: TravelMode.driving,
      wayPoints: [
        PolylineWayPoint(location: "The way to your destination"),
      ],
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    _addPolyLine();
  }

  _addPolyLine() {
    PolylineId id = const PolylineId("Route 1");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
    );
    polyLines[id] = polyline;
    update();
  }
}
