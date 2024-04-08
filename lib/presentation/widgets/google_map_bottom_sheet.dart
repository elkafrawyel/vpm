import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/instance_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vpm/presentation/controller/parking_controller/parking_controller.dart';

import '../../app/res/res.dart';
import '../../app/util/keys.dart';
import '../../app/util/util.dart';

class GoogleMapBottomSheet extends StatefulWidget {
  final String bookingId;
  final LatLng latLng;

  const GoogleMapBottomSheet({
    super.key,
    required this.bookingId,
    required this.latLng,
  });

  @override
  State<GoogleMapBottomSheet> createState() => _GoogleMapBottomSheetState();
}

class _GoogleMapBottomSheetState extends State<GoogleMapBottomSheet> {
  GoogleMapController? mapController;
  Map<MarkerId, Marker> garagesMarkersMap = {};
  List<Polyline> polyLinesList = [];

  @override
  void initState() {
    super.initState();
    addCarMarker();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: Get.find<ParkingController>().myLocation,
        zoom: 13,
      ),
      myLocationEnabled: true,
      // tiltGesturesEnabled: true,
      // compassEnabled: true,
      scrollGesturesEnabled: true,
      // zoomGesturesEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: true,
      mapType: MapType.normal,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height * 0.02,
      ),
      onTap: (position) {},
      onCameraMove: (position) {},
      onMapCreated: onMapCreated,
      markers: Set<Marker>.of(garagesMarkersMap.values),
      polylines: Set<Polyline>.of(polyLinesList),
    );
  }

  void onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  Future addCarMarker() async {
    BitmapDescriptor icon = BitmapDescriptor.defaultMarker;

    final Uint8List? markerIcon = await _getBytesFromAssetMarker(
      Res.locationPinImage,
      150,
    );
    icon = markerIcon == null ? icon : BitmapDescriptor.fromBytes(markerIcon);

    MarkerId markerId = MarkerId(widget.bookingId);
    Marker marker = Marker(
      markerId: markerId,
      icon: icon,
      position: widget.latLng,
      onTap: () async {},
    );
    garagesMarkersMap[markerId] = marker;

    getDirectionsToDestination(
      lineId: widget.bookingId,
      destination: PointLatLng(widget.latLng.latitude, widget.latLng.longitude),
    );
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

  animateToPosition(LatLng latLng, {double? zoom}) {
    if (mapController != null) {
      mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(
          latLng,
          15,
        ),
      );
    } else {
      Utils.logMessage('AnimateCamera failed.');
    }
  }

  Future getDirectionsToDestination({
    required String lineId,
    required PointLatLng destination,
  }) async {
    LatLng myLocation = Get.find<ParkingController>().myLocation;
    animateToPosition(myLocation, zoom: 16);

    PointLatLng origin = PointLatLng(myLocation.latitude, myLocation.longitude);
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
    setState(() {});
  }
}
