import 'package:vpm/app/res/res.dart';
import 'package:vpm/app/util/operation_reply.dart';
import 'package:vpm/data/models/booking_response.dart';
import 'package:vpm/data/providers/network/api_provider.dart';
import 'package:vpm/domain/repositories/booking_repository.dart';

class BookingRepositoryImpl implements BookingRepository {
  @override
  Future<OperationReply<BookingResponse>> getBookingList({
    required String status,
    required String period,
  }) async {
    return APIProvider.instance.get(
      endPoint: '${Res.apiBookingList}?period=$period&status=$status',
      fromJson: BookingResponse.fromJson,
    );
  }
}
