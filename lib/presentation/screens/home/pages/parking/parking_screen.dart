import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/presentation/controller/parking_controller.dart';
import 'package:vpm/presentation/screens/home/pages/parking/components/address_view.dart';
import 'package:vpm/presentation/screens/home/pages/parking/components/park_type_view.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_dialog.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';

import '../../../../../app/util/util.dart';
import '../../../../../data/providers/storage/local_provider.dart';
import '../menu/components/qr_code_view.dart';

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
        parkingController.getMyPosition(loading: false);
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
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.white,
            tooltip: 'QR CODE',
            shape: const CircleBorder(),
            child: Icon(
              Icons.qr_code,
              color: Theme.of(context).primaryColor,
            ),
            onPressed: () {
              scaleDialog(
                context: context,
                barrierDismissible: true,
                backgroundColor: Colors.transparent,
                content: QrCodeView(
                  qrValue: LocalProvider().getUser()?.qrId ?? '',
                ),
              );
            },
          ),
          body: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: parkingController.myLocation,
                  zoom: parkingController.cameraZoom,
                ),
                myLocationEnabled: false,
                // tiltGesturesEnabled: true,
                // compassEnabled: true,
                scrollGesturesEnabled: true,
                // zoomGesturesEnabled: true,
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                mapType: parkingController.mapType,
                onTap: (position) {
                  // print(position);
                },
                onCameraMove: (position) {},
                onMapCreated: parkingController.onMapCreated,
                markers:
                    Set<Marker>.of(parkingController.garagesMarkersMap.values),
                polylines: Set<Polyline>.of(parkingController.polyLinesList),
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
                child: Column(
                  children: [
                    const AddressView(),
                    10.ph,
                    const ParkTypeView(),
                  ],
                ),
              ),
              if (parkingController.polyLinesList.isNotEmpty)
                PositionedDirectional(
                  start: 0,
                  bottom: 30,
                  end: 0,
                  child: Center(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.polyline),
                      onPressed: () {
                        parkingController.clearPolyline();
                      },
                      label: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18.0,
                          vertical: 12,
                        ),
                        child: AppText(
                          'cancel_trip'.tr,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
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
