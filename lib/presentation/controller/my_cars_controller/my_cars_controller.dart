import 'package:vpm/data/repositories/cars_repository.dart';
import 'package:vpm/presentation/controller/general_controller.dart';

import '../../../app/util/operation_reply.dart';

class MyCarsController extends GeneralController {
  final CarsRepositoryIml _carsRepositoryIml = CarsRepositoryIml();

  @override
  onInit() {
    super.onInit();
    getMyCars();
  }

  Future<void> getMyCars() async {
    operationReply = OperationReply.loading();
    await Future.delayed(const Duration(seconds: 1));
    // operationReply = await _carsRepositoryIml.get();
    operationReply = OperationReply.success();
  }

  @override
  Future<void> refreshApiCall() async {
    getMyCars();
  }
}
