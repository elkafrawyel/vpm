import 'package:vpm/app/util/operation_reply.dart';
import 'package:vpm/data/models/garages_response.dart';

abstract class GaragesRepository {
  Future<OperationReply<GaragesResponse>> getGarages({
    required double radius,
    required double latitude,
    required double longitude,
  });
}
