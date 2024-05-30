import 'package:vpm/app/res/res.dart';
import 'package:vpm/app/util/operation_reply.dart';
import 'package:vpm/data/models/advertisements_response.dart';
import 'package:vpm/data/providers/network/api_provider.dart';

import '../../domain/repositories/advertisement_repository.dart';

class AdvertisementRepositoryImpl extends AdvertisementRepository {
  @override
  Future<OperationReply<AdvertisementsResponse>> getAdvertisements({
    int? page,
  }) async {
    return APIProvider.instance.get<AdvertisementsResponse>(
      endPoint: '${Res.apiAllAdvertisements}?paginate=1&page=$page',
      fromJson: AdvertisementsResponse.fromJson,
    );
  }
}
