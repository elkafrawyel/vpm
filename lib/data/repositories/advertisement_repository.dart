import 'package:vpm/app/res/res.dart';
import 'package:vpm/app/util/operation_reply.dart';

import 'package:vpm/data/models/advertisements_response.dart';
import 'package:vpm/data/providers/network/api_provider.dart';

import '../../domain/repositories/advertisement_repository.dart';

class AdvertisementRepositoryImpl extends AdvertisementRepository {
  @override
  Future<OperationReply<AdvertisementsResponse>> getAdvertisements() async {
    return APIProvider.instance.get<AdvertisementsResponse>(
      endPoint: Res.apiAllAdvertisements,
      fromJson: AdvertisementsResponse.fromJson,
    );
  }
}
