import 'package:vpm/app/res/res.dart';
import 'package:vpm/app/util/operation_reply.dart';
import 'package:vpm/data/models/garages_response.dart';
import 'package:vpm/data/providers/network/api_provider.dart';

import '../../domain/repositories/garages_repository.dart';

class GaragesRepositoryImpl extends GaragesRepository {
  @override
  Future<OperationReply<GaragesResponse>> getGarages({
    required double radius,
    required double latitude,
    required double longitude,
  }) async {
    return APIProvider.instance.get(
      endPoint:
          "${Res.apiSearchGarages}?radius=$radius&longitude=$longitude&latitude=$latitude",
      fromJson: GaragesResponse.fromJson,
    );
  }
}
