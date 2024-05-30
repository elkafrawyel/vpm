import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vpm/app/util/operation_reply.dart';
import 'package:vpm/data/models/advertisements_response.dart';
import 'package:vpm/data/repositories/advertisement_repository.dart';
import 'package:vpm/domain/entities/models/advertisementModel.dart';
import 'package:vpm/presentation/controller/my_controllers/general_controller.dart';

class AdvertisementsController extends GeneralController {
  List<AdvertisementModel> services = [];

  final AdvertisementRepositoryImpl _advertisementRepositoryImpl;

  AdvertisementsController(this._advertisementRepositoryImpl);

  @override
  onInit() {
    super.onInit();
    loadAllAdvertisements();
  }

  loadAllAdvertisements() async {
    operationReply = OperationReply.loading();

    operationReply =
        await _advertisementRepositoryImpl.getAdvertisements(page: 1);

    if (operationReply.isSuccess()) {
      AdvertisementsResponse advertisementsResponse = operationReply.result;

      services = advertisementsResponse.data ?? [];
      if (services.isEmpty) {
        operationReply = OperationReply.empty(message: 'empty_services'.tr);
      } else {
        operationReply = OperationReply.success(result: services);
      }
    }
  }

  @override
  Future<void> refreshApiCall() async {
    loadAllAdvertisements();
  }
}
