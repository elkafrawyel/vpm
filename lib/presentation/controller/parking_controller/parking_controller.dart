import 'dart:async';
import 'dart:ui';

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
import 'package:vpm/app/util/util.dart';
import 'package:vpm/data/providers/storage/local_provider.dart';
import 'package:vpm/domain/entities/models/user_model.dart';
import 'package:vpm/presentation/screens/home/pages/parking/components/garage_details_view.dart';
import 'package:vpm/presentation/widgets/dialogs_view/app_dialog_view.dart';
import 'package:vpm/presentation/widgets/modal_bottom_sheet.dart';

class GarageModel {
  String id;
  String name;
  double lat;
  double lng;

  GarageModel({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
  });
}

class ParkingController extends GetxController with WidgetsBindingObserver {
  GoogleMapController? mapController;
  LatLng myLocation = const LatLng(0, 0);
  String? myAddressAr, myAddressEn;
  Map<MarkerId, Marker> markers = {};
  List<Polyline> polyLines = [];
  Timer? debouncer;

  // double distanceInMeters = Geolocator.distanceBetween(52.2165157, 6.9437819, 52.3546274, 4.8285838);

  double cameraZoom = 13;

  void debounce(VoidCallback callback,
      {Duration duration = const Duration(seconds: 1)}) {
    if (debouncer != null) {
      debouncer!.cancel();
    }
    debouncer = Timer(duration, callback);
  }

  List<GarageModel> garageList = [
    GarageModel(
      id: '1',
      name: 'Garage 1',
      lat: 30.958723431397278,
      lng: 31.168272905051708,
    ),
    GarageModel(
      id: '2',
      name: 'Garage 2',
      lat: 30.959876347794545,
      lng: 31.17682747542858,
    ),
    GarageModel(
      id: '3',
      name: 'Garage 3',
      lat: 30.933517087159764,
      lng: 31.159301251173023,
    ),
    GarageModel(
      id: '4',
      name: 'Garage 4',
      lat: 30.921552106485493,
      lng: 31.174164041876793,
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
        Utils.logMessage('App is resumed');
        break;
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
      case AppLifecycleState.hidden:
      case AppLifecycleState.paused:
        Utils.logMessage('App is in background');
        break;
    }
  }

  void onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    // todo get all garages and draw markers
    for (var element in garageList) {
      await addGarageMarker(element);
    }
    update();
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
    getMyAddress();

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
    BitmapDescriptor icon = BitmapDescriptor.defaultMarkerWithHue(2);

    /// image size 64x64
    final Uint8List markerIcon = await getBytesFromAssetMarker(
      Res.garagePinImage,
      120,
    );
    icon = BitmapDescriptor.fromBytes(markerIcon);

    MarkerId markerId = MarkerId(element.id);
    Marker marker = Marker(
      markerId: markerId,
      icon: icon,
      position: LatLng(element.lat, element.lng),
      infoWindow: InfoWindow(
        title: element.name,
        anchor: const Offset(0.5, 0.5),
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
    final Uint8List markerIcon = await getBytesFromAssetMarker(
      Res.locationPinImage,
      150,
    );
    icon = BitmapDescriptor.fromBytes(markerIcon);

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
      markers[markerId] = marker;
    }
  }

  Future<Uint8List> getBytesFromAssetMarker(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(),
        targetHeight: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  Future getDirectionsToDestination({
    required String lineId,
    required PointLatLng destination,
  }) async {
    animateToPosition(myLocation);

    PointLatLng origin = PointLatLng(myLocation.latitude, myLocation.longitude);
    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
      googleMapKey,
      origin,
      // const PointLatLng(30.921552106485493, 31.174164041876793),
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
      color: Colors.redAccent,
      points: polylineCoordinates,
      width: 10,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      patterns: [PatternItem.dash(10), PatternItem.gap(10)],
    );

    polyLines.clear();
    polyLines.add(polyLine);
    update();
  }

  void getMyAddress() async {
    myAddressAr = await getAddress(myLocation, locale: 'ar_EG');
    myAddressEn = await getAddress(myLocation, locale: 'en_US');
    update([addressControllerId]);
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
