import 'dart:async';
import 'dart:ui';

import 'package:custom_info_window/custom_info_window.dart';
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
import 'package:vpm/app/util/keys.dart';
import 'package:vpm/app/util/operation_reply.dart';
import 'package:vpm/app/util/util.dart';
import 'package:vpm/data/models/garages_response.dart';
import 'package:vpm/data/providers/storage/local_provider.dart';
import 'package:vpm/data/repositories/garages_repository.dart';
import 'package:vpm/domain/entities/models/user_model.dart';
import 'package:vpm/presentation/controller/home_screen_controller/home_screen_controller.dart';
import 'package:vpm/presentation/screens/home/pages/parking/components/garage_details_view.dart';
import 'package:vpm/presentation/widgets/dialogs_view/app_dialog_view.dart';
import 'package:vpm/presentation/widgets/modal_bottom_sheet.dart';

import '../../../domain/entities/models/garage_model.dart';
import '../../screens/home/pages/parking/components/garage_info_view.dart';

class ParkingController extends GetxController {
  final GaragesRepositoryImpl _garagesRepositoryImpl;

  int garageImageSize = 100;

  int myImageSize = 150;

  ParkingController(this._garagesRepositoryImpl);

  GoogleMapController? mapController;
  LatLng myLocation = const LatLng(0, 0);
  String? myAddressAr, myAddressEn;
  Map<MarkerId, Marker> garagesMarkersMap = {};
  List<Polyline> polyLinesList = [];
  Timer? debouncer;
  double cameraZoom = 13;
  MapType mapType = MapType.normal;
  LatLng? targetGarage;
  CustomInfoWindowController customInfoWindowController =
      CustomInfoWindowController();

  List<GarageModel> garageList = [];
  Timer? timer;

  //====================== Controllers Id================
  static const String addressControllerId = 'addressController';

  @override
  void onInit() async {
    super.onInit();
    await getMyPosition();
    setupTimer();
  }

  setupTimer() {
    timer = Timer.periodic(const Duration(seconds: 30), (timer) async {
      Utils.logMessage('<<=============Timer===============>>');
      if (Get.find<HomeScreenController>().selectedTabIndex == 0) {
        await getMyPosition(loading: false);
        await getGaragesListFromApi();
      }
      handleTargetGarage();
    });
  }

  void handleTargetGarage() {
    if (targetGarage != null) {
      //todo check if the customer arrive to garage
      double distance = Geolocator.distanceBetween(
        myLocation.latitude,
        myLocation.longitude,
        targetGarage!.latitude,
        targetGarage!.longitude,
      );

      //if distance lower than 10 meters
      if (distance < 10) {
        targetGarage = null;
        polyLinesList.clear();
        update();
        Get.dialog(
          AppDialogView(
            svgName: Res.iconLocation,
            title: 'You have arrived!',
            message:
                'Please scan your Parking QR Cod on the scanner machine to enter',
            actionText: 'Ok',
            onActionClicked: () {
              Get.back();
            },
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    customInfoWindowController.dispose();
    timer?.cancel();
  }

  void onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    customInfoWindowController.googleMapController = controller;
  }

  Future<void> getGaragesListFromApi() async {
    OperationReply<GaragesResponse> operationReply =
        await _garagesRepositoryImpl.getGarages(
      radius: 100,
      latitude: myLocation.latitude,
      longitude: myLocation.longitude,
    );

    if (operationReply.isSuccess()) {
      GaragesResponse? garagesResponse = operationReply.result;
      garageList = garagesResponse?.garages ?? [];
      for (var element in garageList) {
        await addGarageMarker(element);
      }
      update();
    }
  }

  Future checkLocationPermission() async {
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
        _openSettingDialog();
        Future.error('Location permissions are denied');
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      _openSettingDialog();
      Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
      return;
    }
  }

  Future getMyPosition({bool loading = true}) async {
    await checkLocationPermission();
    if (loading) {
      EasyLoading.show(status: 'getting_location'.tr);
    }
    Position position = await Geolocator.getCurrentPosition();
    myLocation = LatLng(position.latitude, position.longitude);
    await _getMyAddress(myLocation);
    await _addMyMarker();
    await getGaragesListFromApi();
    if (loading) {
      EasyLoading.dismiss();
    }
    update();
    if (loading) {
      animateToPosition(myLocation);
    }
  }

  _openSettingDialog() {
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

  animateToPosition(LatLng latLng, {double? zoom}) {
    if (mapController != null) {
      customInfoWindowController.hideInfoWindow!();
      mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(
          latLng,
          zoom ?? cameraZoom,
        ),
      );
    } else {
      Utils.logMessage('AnimateCamera failed.');
    }
  }

  Future addGarageMarker(GarageModel element) async {
    BitmapDescriptor icon = BitmapDescriptor.defaultMarkerWithHue(2);

    String assetPath = "";

    if (element.type?.code == 1) {
      assetPath =
          element.isAvailable ? Res.garagePinImage : Res.redGaragePinImage;
    } else {
      assetPath =
          element.isAvailable ? Res.valetPinImage : Res.redValetPinImage;
    }

    final Uint8List? markerIcon = await _getBytesFromAssetMarker(
      assetPath,
      garageImageSize,
    );
    icon = markerIcon == null ? icon : BitmapDescriptor.fromBytes(markerIcon);

    LatLng latLng = LatLng(
      double.parse(element.latitude!),
      double.parse(element.longitude!),
    );

    MarkerId markerId = MarkerId(element.id!);
    Marker marker = Marker(
      markerId: markerId,
      icon: icon,
      position: latLng,
      onTap: () async {
        if (element.type?.code == 1) {
          Utils.logMessage('Clicked Garage id ==> ${element.id}');
          await Future.delayed(const Duration(milliseconds: 100));
          customInfoWindowController.addInfoWindow!(
            GarageInfoView(
              onTap: () {
                customInfoWindowController.hideInfoWindow!();
                _openGarageInfoBottomSheet(element);
              },
              garageModel: element,
            ),
            latLng,
          );
        } else {
          _openGarageInfoBottomSheet(element);
        }
      },
    );
    garagesMarkersMap[markerId] = marker;
  }

  Future _addMyMarker() async {
    BitmapDescriptor icon = BitmapDescriptor.defaultMarker;

    final Uint8List? markerIcon = await _getBytesFromAssetMarker(
      Res.locationPinImage,
      myImageSize,
    );
    icon = markerIcon == null ? icon : BitmapDescriptor.fromBytes(markerIcon);

    UserModel? userModel = LocalProvider().getUser();
    if (userModel != null) {
      MarkerId markerId = MarkerId(userModel.id!);
      Marker marker = Marker(
        markerId: markerId,
        icon: icon,
        position: myLocation,
        anchor: const Offset(0.5, 0.5),
        infoWindow: InfoWindow(title: userModel.name),
        // onTap: () => InformationViewer.showSnackBar(userModel.name),
      );
      garagesMarkersMap[markerId] = marker;
    }
  }

  Future<Uint8List?> _getBytesFromAssetMarker(String path, int width) async {
    try {
      ByteData data = await rootBundle.load(path);
      Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
          targetHeight: width);
      FrameInfo fi = await codec.getNextFrame();
      return (await fi.image.toByteData(format: ImageByteFormat.png))!
          .buffer
          .asUint8List();
    } catch (e) {
      Utils.logMessage("==============>${e.toString()}");
      return null;
    }
  }

  Future getDirectionsToDestination({
    required String lineId,
    required PointLatLng destination,
  }) async {
    animateToPosition(myLocation, zoom: 16);

    PointLatLng origin = PointLatLng(myLocation.latitude, myLocation.longitude);
    targetGarage = LatLng(destination.latitude, destination.longitude);
    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
      googleMapKey,
      origin,
      destination,
      travelMode: TravelMode.driving,
    );
    List<LatLng> polylineCoordinates = [];

    if (result.status == 'OK' && result.points.isNotEmpty) {
      Utils.logMessage('Origin===========>${result.startAddress}');
      Utils.logMessage('Destination======>${result.endAddress}');
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }

    Polyline polyLine = Polyline(
      polylineId: PolylineId(lineId),
      color: Colors.blue,
      points: polylineCoordinates,
      width: 10,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      patterns: [PatternItem.dash(10), PatternItem.gap(10)],
    );

    polyLinesList.clear();
    polyLinesList.add(polyLine);
    update();
  }

  Future<void> _getMyAddress(LatLng latLng) async {
    myAddressAr = await _getAddressFromLocation(latLng, locale: 'ar_SA');
    myAddressEn = await _getAddressFromLocation(latLng, locale: 'en_US');
    update([addressControllerId]);
  }

  Future<String> _getAddressFromLocation(
    LatLng latLng, {
    required String locale,
  }) async {
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

  void _openGarageInfoBottomSheet(
    GarageModel element,
  ) async {
    showAppModalBottomSheet(
      context: Get.context!,
      initialChildSize: 0.5,
      minChildSize: 0.4,
      builder: (context, scrollController) {
        return GarageDetailsView(
          scrollController: scrollController,
          element: element,
          myLocation: myLocation,
        );
      },
    );
  }

  switchMapType() {
    mapType = MapType.values[(mapType.index + 1) % MapType.values.length];
    if (mapType == MapType.none) mapType = MapType.normal;
    update();
  }

  void clearPolyline() async {
    polyLinesList.clear();
    targetGarage = null;
    update();
    animateToPosition(myLocation);
  }
}
