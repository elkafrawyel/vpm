import 'package:vpm/data/models/booking_response.dart';

import '../../app/util/operation_reply.dart';

abstract class BookingRepository {
  Future<OperationReply<BookingResponse>> getBookingList({
    required String status,
    required String period,
    int? page,
  });
}
