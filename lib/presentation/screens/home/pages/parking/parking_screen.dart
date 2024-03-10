import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vpm/presentation/controller/parking_controller/parking_controller.dart';
import 'package:vpm/presentation/screens/home/pages/parking/components/address_view.dart';

import '../../../../../app/util/util.dart';
import 'components/build_map_icons.dart';

class ParkingScreen extends StatefulWidget {
  const ParkingScreen({super.key});

  @override
  State<ParkingScreen> createState() => _ParkingScreenState();
}

class _ParkingScreenState extends State<ParkingScreen>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  final ParkingController parkingController = Get.find();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
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
        // parkingController.getMyPosition(loading: false);
        Utils.logMessage('App is resumed');
        break;
      case AppLifecycleState.detached:
        Utils.logMessage('App is detached');
        break;
      case AppLifecycleState.inactive:
        Utils.logMessage('App is inactive');
        break;
      case AppLifecycleState.hidden:
        Utils.logMessage('App is hidden');
        break;
      case AppLifecycleState.paused:
        Utils.logMessage('App is paused');
        break;
    }
  }

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
                // tiltGesturesEnabled: true,
                // compassEnabled: true,
                scrollGesturesEnabled: true,
                // zoomGesturesEnabled: true,
                zoomControlsEnabled: false,
                myLocationButtonEnabled: true,
                mapType: parkingController.mapType,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.02,
                ),
                onTap: (position) {
                  print(position);
                  parkingController
                      .customInfoWindowController.hideInfoWindow!();
                },
                onCameraMove: (position) {
                  parkingController.customInfoWindowController.onCameraMove!();
                },
                onMapCreated: parkingController.onMapCreated,
                markers:
                    Set<Marker>.of(parkingController.garagesMarkersMap.values),
                polylines: Set<Polyline>.of(parkingController.polyLinesList),
              ),
              CustomInfoWindow(
                controller: parkingController.customInfoWindowController,
                offset: 30,
                width: 200,
                height: 50,
              ),
              // PositionedDirectional(
              //   bottom: MediaQuery.sizeOf(context).height * 0.12,
              //   start: 20,
              //   child: BuildMapIcons(),
              // ),
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
