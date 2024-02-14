import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vpm/presentation/controller/parking_controller/parking_controller.dart';

class ParkingScreen extends StatefulWidget {
  const ParkingScreen({super.key});

  @override
  State<ParkingScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen>
    with AutomaticKeepAliveClientMixin {
  final ParkingController parkingController = Get.find();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<ParkingController>(
      builder: (_) {
        return Scaffold(
          body: parkingController.myLocation == null
              ? const SizedBox()
              : GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      parkingController.myLocation!.latitude,
                      parkingController.myLocation!.longitude,
                    ),
                    zoom: 15,
                  ),
                  myLocationEnabled: true,
                  tiltGesturesEnabled: true,
                  compassEnabled: true,
                  scrollGesturesEnabled: true,
                  zoomGesturesEnabled: true,
                  onMapCreated: parkingController.onMapCreated,
                  // markers: Set<Marker>.of(markers.values),
                  // polylines: Set<Polyline>.of(polylines.values),
                ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
