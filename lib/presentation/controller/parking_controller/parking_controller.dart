import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ParkingController extends GetxController {
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polyLines = {};
  List<LatLng> polylineCoordinates = [];
  final Completer<GoogleMapController> mapController =
      Completer<GoogleMapController>();

  CameraPosition pointOne = const CameraPosition(
    target: LatLng(6.9271, 79.8612),
    zoom: 14.4746,
  );

  CameraPosition pointTwo = const CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(6.2514, 80.7642),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );

  addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
    );
    polyLines[id] = polyline;
    update();
  }

  void makeLines() async {
    await polylinePoints
        .getRouteBetweenCoordinates(
      'AIzaSyCDzltRvdehaa-81Gh7T0JGW-s3x6igHMg',
      const PointLatLng(6.2514, 80.7642), //Starting LATLANG
      const PointLatLng(6.9271, 79.8612), //End LATLANG
      travelMode: TravelMode.driving,
    )
        .then((value) {
      for (var point in value.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }).then((value) {
      addPolyLine();
    });
  }
}
