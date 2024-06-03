import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:vpm/app/types/booking_filter_type.dart';
import 'package:vpm/presentation/controller/booking_controller/current_booking_controller.dart';
import 'package:vpm/presentation/controller/booking_controller/ended_booking_controller.dart';
import 'package:vpm/presentation/screens/home/pages/booking/components/current/current.dart';
import 'package:vpm/presentation/screens/home/pages/booking/components/ended/ended.dart';

class BookingController extends GetxController {
  List<Widget> pages = [
    const CurrentBooking(),
    const EndedBooking(),
  ];

  Rx<BookingFilterType> bookingFilterType = BookingFilterType.all.obs;

  RxInt selectedIndex = 0.obs;

  final CurrentBookingController currentBookingController =
      Get.find<CurrentBookingController>();
  final EndedBookingController endedBookingController =
      Get.find<EndedBookingController>();

  @override
  void onInit() {
    super.onInit();
    ever(
      bookingFilterType,
      (callback) {
        currentBookingController.configData.parameters?['period'] =
            callback.name;
        currentBookingController.refreshApiCall();
        endedBookingController.configData.parameters?['period'] = callback.name;
        endedBookingController.refreshApiCall();
      },
    );
  }
}
