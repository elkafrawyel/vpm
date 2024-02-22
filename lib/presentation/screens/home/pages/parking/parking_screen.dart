import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vpm/presentation/controller/parking_controller/parking_controller.dart';
import 'package:vpm/presentation/screens/home/pages/parking/components/address_view.dart';
import 'package:vpm/presentation/screens/home/pages/parking/components/build_map_icons.dart';

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
          body: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: parkingController.myLocation,
                  zoom: parkingController.cameraZoom,
                ),
                myLocationEnabled: true,
                tiltGesturesEnabled: true,
                compassEnabled: true,
                scrollGesturesEnabled: true,
                zoomGesturesEnabled: true,
                zoomControlsEnabled: true,
                myLocationButtonEnabled: false,
                mapType: parkingController.mapType,
                onMapCreated: parkingController.onMapCreated,
                markers: Set<Marker>.of(parkingController.garagesMarkersMap.values),
                polylines: Set<Polyline>.of(parkingController.polyLinesList),
                onTap: (LatLng latLng) {
                  print(latLng);
                },
              ),
              PositionedDirectional(
                top: MediaQuery.sizeOf(context).height * 0.2,
                start: 20,
                child: BuildMapIcons(),
              ),
              PositionedDirectional(
                top: MediaQuery.of(context).padding.top,
                start: 0,
                end: 0,
                child: const AddressView(),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
