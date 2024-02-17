import 'package:vpm/data/models/advertisements_response.dart';

import '../../app/util/operation_reply.dart';

abstract class AdvertisementRepository{

  Future<OperationReply<AdvertisementsResponse>> getAdvertisements();
}