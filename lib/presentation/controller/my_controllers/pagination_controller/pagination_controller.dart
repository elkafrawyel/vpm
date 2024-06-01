import 'package:get/get.dart';
import 'package:vpm/data/providers/network/api_provider.dart';
import 'package:vpm/presentation/controller/my_controllers/pagination_controller/data/config_data.dart';
import 'package:vpm/presentation/controller/my_controllers/pagination_controller/data/pagination_response.dart';

import '../../../../app/util/operation_reply.dart';

class PaginationController<T> extends GetxController {
  PaginationController(this.configData);

  num page = 1;
  num totalPages = 1;
  bool _loadingMore = false, _loadingMoreEnd = false;

  PaginationResponse<T>? paginationResponse;
  List<T> paginationList = [];

  OperationReply _operationReply = OperationReply.init();

  OperationReply get operationReply => _operationReply;

  set operationReply(OperationReply value) {
    _operationReply = value;
    update();
  }

  ConfigData<T> configData;

  bool get loadingMore => _loadingMore;

  set loadingMore(bool value) {
    _loadingMore = value;
    update();
  }

  get loadingMoreEnd => _loadingMoreEnd;

  set loadingMoreEnd(value) {
    _loadingMoreEnd = value;
    update();
  }

  callApi() async {
    operationReply = OperationReply.loading();
    operationReply = await APIProvider.instance.get(
      endPoint: '${configData.apiEndPoint}?paginate=1&page=$page',
      fromJson: (json) => PaginationResponse<T>.fromJson(
        json,
        fromJson: configData.fromJson,
      ),
    );

    if (operationReply.isSuccess()) {
      paginationResponse = operationReply.result;
      paginationList = paginationResponse?.data ?? [];
      totalPages = paginationResponse?.meta?.lastPage ?? 1;

      if (paginationList.isEmpty) {
        operationReply = OperationReply.empty(
          message: configData.emptyListMessage,
        );
      } else {
        operationReply = OperationReply.success();
      }
    }
  }

  void callMoreData() async {
    if (loadingMoreEnd || loadingMore) {
      return;
    }
    page++;
    if (page > totalPages) {
      loadingMoreEnd = true;
      return;
    }
    loadingMore = true;
    operationReply = await APIProvider.instance.get(
      endPoint: '${configData.apiEndPoint}?paginate=1&page=$page',
      fromJson: (json) => PaginationResponse<T>.fromJson(
        json,
        fromJson: configData.fromJson,
      ),
    );

    if (operationReply.isSuccess()) {
      paginationResponse = operationReply.result;

      paginationList.addAll(paginationResponse?.data ?? []);
      if (paginationList.isEmpty) {
        operationReply = OperationReply.empty();
      } else {
        operationReply = OperationReply.success();
      }
    }
    loadingMore = false;
  }

  Future<void> refreshApiCall() async {
    page = 1;
    totalPages = 1;
    loadingMoreEnd = false;
    loadingMore = false;
    await callApi();
  }
}
