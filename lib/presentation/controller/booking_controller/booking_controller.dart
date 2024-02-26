import 'package:flutter/cupertino.dart';
import 'package:vpm/app/types/booking_filter_type.dart';
import 'package:vpm/app/util/operation_reply.dart';
import 'package:vpm/data/models/booking_response.dart';
import 'package:vpm/data/repositories/booking_repository.dart';
import 'package:vpm/domain/entities/models/booking_model.dart';
import 'package:vpm/presentation/controller/general_controller.dart';
import 'package:vpm/presentation/screens/home/pages/booking/components/current/current.dart';
import 'package:vpm/presentation/screens/home/pages/booking/components/ended/ended.dart';

class BookingController extends GeneralController {
  final BookingRepositoryImpl _bookingRepositoryImpl;

  BookingController(this._bookingRepositoryImpl);

  List<Widget> pages = [
    const CurrentBooking(),
    const EndedBooking(),
  ];

  List<BookingModel> currentBookingsList = [];
  List<BookingModel> endedBookingsList = [];
  BookingFilterType _bookingFilterType = BookingFilterType.all;

  BookingFilterType get bookingFilterType => _bookingFilterType;

  set bookingFilterType(BookingFilterType value) {
    _bookingFilterType = value;
    update();
    getBookingList();
  }

  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
    update();
    getBookingList();
  }

  @override
  onInit() {
    super.onInit();
    getBookingList();
  }

  Future getBookingList() async {
    operationReply = OperationReply.loading();

    operationReply = await _bookingRepositoryImpl.getBookingList(
      status: _selectedIndex == 0 ? 'current' : 'ends',
      period: _bookingFilterType.name,
    );

    if (operationReply.isSuccess()) {
      BookingResponse bookingResponse = operationReply.result;
      switch (_selectedIndex) {
        case 0:
          currentBookingsList = bookingResponse.data ?? [];
          if (currentBookingsList.isEmpty) {
            operationReply = OperationReply.empty();
          } else {
            operationReply = OperationReply.success();
          }
          break;
        case 1:
          endedBookingsList = bookingResponse.data ?? [];
          if (endedBookingsList.isEmpty) {
            operationReply = OperationReply.empty();
          } else {
            operationReply = OperationReply.success();
          }
          break;
      }
    }
  }

  @override
  Future<void> refreshApiCall() async {
    getBookingList();
  }
}
