import 'package:flutter/cupertino.dart';
import 'package:vpm/app/types/booking_filter_type.dart';
import 'package:vpm/app/util/operation_reply.dart';
import 'package:vpm/data/models/booking_response.dart';
import 'package:vpm/data/repositories/booking_repository.dart';
import 'package:vpm/domain/entities/models/booking_model.dart';
import 'package:vpm/presentation/controller/my_controllers/general_controller.dart';
import 'package:vpm/presentation/screens/home/pages/booking/components/current/current.dart';
import 'package:vpm/presentation/screens/home/pages/booking/components/ended/ended.dart';

class BookingController extends GeneralController {
  final BookingRepositoryImpl _bookingRepositoryImpl;

  BookingController(this._bookingRepositoryImpl);

  int endedPage = 1;

  int endedTotalPages = 1;

  bool endedLoadingMore = false, endedLoadingMoreEnd = false;

  int currentPage = 1;

  int currentTotalPages = 1;

  bool currentLoadingMore = false, currentLoadingMoreEnd = false;

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
    if (_selectedIndex == value) {
      return;
    }
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
      page: 1,
    );

    if (operationReply.isSuccess()) {
      BookingResponse bookingResponse = operationReply.result;
      switch (_selectedIndex) {
        case 0:
          currentBookingsList = bookingResponse.data ?? [];
          currentTotalPages = bookingResponse.meta?.total ?? 1;
          if (currentBookingsList.isEmpty) {
            operationReply = OperationReply.empty();
          } else {
            operationReply = OperationReply.success();
          }
          break;
        case 1:
          endedBookingsList = bookingResponse.data ?? [];
          endedTotalPages = bookingResponse.meta?.total ?? 1;
          if (endedBookingsList.isEmpty) {
            operationReply = OperationReply.empty();
          } else {
            operationReply = OperationReply.success();
          }
          break;
      }
    }
  }

  void loadMoreEndBookings() async {
    if (endedLoadingMoreEnd) {
      return;
    }
    endedPage++;
    if (endedPage > endedTotalPages) {
      endedLoadingMoreEnd = true;
      update();
      return;
    }

    print('Page========>$endedPage');
    endedLoadingMore = true;
    update();
    operationReply = await _bookingRepositoryImpl.getBookingList(
      status: 'ends',
      period: _bookingFilterType.name,
      page: endedPage,
    );

    if (operationReply.isSuccess()) {
      BookingResponse bookingResponse = operationReply.result;

      endedBookingsList.addAll(bookingResponse.data ?? []);
      if (endedBookingsList.isEmpty) {
        operationReply = OperationReply.empty();
      } else {
        operationReply = OperationReply.success();
      }
    }

    endedLoadingMore = false;
    update();
  }

  void loadMoreCurrentBookings() async {
    if (currentLoadingMoreEnd) {
      return;
    }
    currentPage++;
    if (currentPage > currentTotalPages) {
      currentLoadingMoreEnd = true;
      update();
      return;
    }

    print('Page========>$currentPage');
    currentLoadingMore = true;
    update();
    operationReply = await _bookingRepositoryImpl.getBookingList(
      status: 'current',
      period: _bookingFilterType.name,
      page: currentPage,
    );

    if (operationReply.isSuccess()) {
      BookingResponse bookingResponse = operationReply.result;

      currentBookingsList.addAll(bookingResponse.data ?? []);
      if (currentBookingsList.isEmpty) {
        operationReply = OperationReply.empty();
      } else {
        operationReply = OperationReply.success();
      }
    }

    currentLoadingMore = false;
    update();
  }

  @override
  Future<void> refreshApiCall() async {
    if (selectedIndex == 0) {
      currentTotalPages = 1;
      currentLoadingMoreEnd = false;
      currentLoadingMore = false;
    } else {
      endedTotalPages = 1;
      endedLoadingMore = false;
      endedLoadingMore = false;
    }
    update();
    getBookingList();
  }
}
