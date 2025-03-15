import 'package:vpm/presentation/controller/my_controllers/pagination_controller/pagination_controller.dart';

import '../../domain/entities/models/advertisementModel.dart';

class AdvertisementsController
    extends PaginationController<AdvertisementModel> {
  AdvertisementsController(super.configData);

  @override
  onInit() {
    super.onInit();
    callApi();
  }
}
