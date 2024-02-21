import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vpm/app/res/res.dart';
import 'package:vpm/app/util/constants.dart';
import 'package:vpm/app/util/information_viewer.dart';
import 'package:vpm/app/util/util.dart';
import 'package:vpm/data/providers/storage/local_provider.dart';
import 'package:vpm/domain/entities/models/user_model.dart';
import 'package:vpm/presentation/screens/home/pages/parking/components/garage_details_view.dart';
import 'package:vpm/presentation/widgets/dialogs_view/app_dialog_view.dart';
import 'package:vpm/presentation/widgets/modal_bottom_sheet.dart';

class GarageModel {
  String id;
  String name;
  LatLng latLng;

  GarageModel({
    required this.id,
    required this.name,
    required this.latLng,
  });
}

class ParkingController extends GetxController with WidgetsBindingObserver {
  GoogleMapController? mapController;
  LatLng myLocation = const LatLng(0, 0);
  String? myAddressAr, myAddressEn;
  Map<MarkerId, Marker> markers = {};
  Polyline? polyLine;
  List<LatLng> polylineCoordinates = [];

  // double distanceInMeters = Geolocator.distanceBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);

  double cameraZoom = 14;

  List<GarageModel> garageList = [
    GarageModel(
      id: '1',
      name: 'Garage 1',
      latLng: const LatLng(30.958723431397278, 31.168272905051708),
    ),
    GarageModel(
      id: '2',
      name: 'Garage 2',
      latLng: const LatLng(30.959876347794545, 31.17682747542858),
    ),
    GarageModel(
      id: '3',
      name: 'Garage 3',
      latLng: const LatLng(30.953251920211937, 31.17127664387226),
    ),
    GarageModel(
      id: '4',
      name: 'Garage 4',
      latLng: const LatLng(30.947559548368822, 31.16051897406578),
    ),
  ];

  //====================== Controllers Id================
  static const String addressControllerId = 'addressController';

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
        _determinePosition(loading: false);
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
    // todo get all garages and draw markers
    for (var element in garageList) {
      await addGarageMarker(element);
    }
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future _determinePosition({bool loading = true}) async {
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

    if (loading) {
      EasyLoading.show(status: 'getting_location'.tr);
    }
    //todo get my latLng
    Position position = await Geolocator.getCurrentPosition();
    myLocation = LatLng(position.latitude, position.longitude);

    //todo get my address from latLng
    myAddressAr = await getAddress(myLocation, locale: 'AR_SA');
    myAddressEn = await getAddress(myLocation, locale: 'EN_US');
    update([addressControllerId]);

    if (loading) {
      EasyLoading.dismiss();
    }
    animateToPosition(myLocation);
    //todo add my mark on map

    await addMyMarker();

    update();
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
          cameraZoom,
        ),
      );
    } else {
      Utils.logMessage('AnimateCamera failed.');
    }
  }

  Future addGarageMarker(GarageModel element) async {
    BitmapDescriptor icon = BitmapDescriptor.defaultMarker;

    /// image size 64x64
    icon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      Res.garagePinImage,
      bundle: PlatformAssetBundle(),
    );

    MarkerId markerId = MarkerId(element.id);
    Marker marker = Marker(
      markerId: markerId,
      icon: icon,
      position: element.latLng,
      infoWindow: InfoWindow(
        title: element.name,
        anchor: const Offset(1, 3),
        onTap: () {
          openGarageInfoBottomSheet(element);
        },
      ),
      onTap: () {
        openGarageInfoBottomSheet(element);
      },
    );
    markers[markerId] = marker;
  }

  Future addMyMarker() async {
    BitmapDescriptor icon = BitmapDescriptor.defaultMarker;

    /// image size 64x64
    icon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      Res.locationPinImage,
      // bundle: PlatformAssetBundle(),
    );

    UserModel? userModel = LocalProvider().getUser();
    if (userModel != null) {
      MarkerId markerId = MarkerId(userModel.id!);
      Marker marker = Marker(
        markerId: markerId,
        icon: icon,
        position: myLocation,
        onTap: () => InformationViewer.showSnackBar(userModel.name),
      );
      markers[markerId] = marker;
    }
  }

  getRouteToDestination({
    required String lineId,
    required LatLng destination,
  }) async {
    animateToPosition(myLocation);

    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Constants.googleMapKey,
      PointLatLng(myLocation.latitude, myLocation.longitude),
      PointLatLng(destination.longitude, destination.longitude),
    );
    if (result.points.isNotEmpty) {
      polylineCoordinates = [];
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }

    polyLine = Polyline(
      polylineId: PolylineId(lineId),
      color: Colors.blue,
      points: polylineCoordinates,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      patterns: [PatternItem.dash(10), PatternItem.gap(10)],
    );

    update();
  }

  Future<String> getAddress(LatLng latLng, {required String locale}) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(
      latLng.latitude,
      latLng.longitude,
      localeIdentifier: locale,
    );

    Placemark placeMark = placeMarks.first;

    String name = placeMark.name ?? '';
    String city = placeMark.subAdministrativeArea ?? '';
    String governorate = placeMark.administrativeArea ?? '';
    String country = placeMark.country ?? '';
    String address = "$name, $city, $governorate, $country";

    Utils.logMessage(address);

    return address;
  }

  void openGarageInfoBottomSheet(GarageModel element) async {
    showAppModalBottomSheet(
      context: Get.context!,
      initialChildSize: 0.4,
      minChildSize: 0.3,
      builder: (context, scrollController) {
        return GarageDetailsView(
          scrollController: scrollController,
          element: element,
        );
      },
    );
  }

  MapType _mapType = MapType.normal;

  MapType get mapType => _mapType;

  switchMapType() {
    _mapType = MapType.values[(_mapType.index + 1) % MapType.values.length];
    if (_mapType == MapType.none) _mapType = MapType.normal;
    update();
  }
}
