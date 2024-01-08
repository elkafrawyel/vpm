import 'package:get/get.dart';
import 'package:vpm/app/types/booking_filter_type.dart';

class BookingController extends GetxController {
  int _selectedIndex = 0;

  BookingFilterType _bookingFilterType = BookingFilterType.all;

  BookingFilterType get bookingFilterType => _bookingFilterType;

  set bookingFilterType(BookingFilterType value) {
    _bookingFilterType = value;
    update();
  }

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
    update();
  }
}
