import 'package:vpm/app/util/operation_reply.dart';
import 'package:vpm/presentation/controller/general_controller.dart';

class ServicesController extends GeneralController {
  List<String> services = [];

  @override
  onInit() {
    super.onInit();
    loadAllServices();
  }

  loadAllServices() async {
    operationReply = OperationReply.loading();

    await Future.delayed(const Duration(seconds: 3));

    operationReply = OperationReply.success(message: 'Service is not available');
  }

  @override
  Future<void> refreshApiCall() async {
    loadAllServices();
  }
}
