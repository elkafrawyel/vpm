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
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              parkingController.getRouteToDestination(
                destination:
                    const LatLng(37.77704909733175, -122.40843415260316), //ios
                // destination: const LatLng(37.77704909733175, -122.40843415260316), //android
              );
            },
          ),
          body: GoogleMap(
            initialCameraPosition: CameraPosition(
              target: parkingController.myLocation,
              zoom: 15,
            ),
            myLocationEnabled: true,
            tiltGesturesEnabled: true,
            compassEnabled: true,
            scrollGesturesEnabled: true,
            zoomGesturesEnabled: true,
            onMapCreated: parkingController.onMapCreated,
            markers: Set<Marker>.of(parkingController.markers.values),
            polylines: Set<Polyline>.of(parkingController.polyLines.values),
            onTap: (LatLng latLng) {
              print(latLng);
            },
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
