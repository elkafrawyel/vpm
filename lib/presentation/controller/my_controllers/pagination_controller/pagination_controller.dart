import 'package:get/get.dart';
import 'package:vpm/data/providers/network/api_provider.dart';
import 'package:vpm/presentation/controller/my_controllers/pagination_controller/data/pagination_response.dart';

import '../../../../app/util/operation_reply.dart';

class PaginationController<T> extends GetxController {
  num page = 1;
  num totalPages = 1;
  bool loadingMore = false, loadingMoreEnd = false;

  PaginationResponse<T>? paginationResponse;
  List<T> paginationList = [];

  OperationReply _operationReply = OperationReply.init();

  OperationReply get operationReply => _operationReply;

  set operationReply(OperationReply value) {
    _operationReply = value;
    update();
  }

  String? apiEndPoint;
  String? emptyListMessage;
  T Function(dynamic)? fromJson;

  void build({
    required String apiEndPoint,
    String emptyListMessage = 'Empty Data',
    required T Function(dynamic) fromJson,
  }) {
    this.apiEndPoint = apiEndPoint;
    this.emptyListMessage = emptyListMessage;
    this.fromJson = fromJson;
  }

  callApi() async {
    assert(this.apiEndPoint != null || this.fromJson != null);
    operationReply = OperationReply.loading();
    operationReply = await APIProvider.instance.get(
      endPoint: '$apiEndPoint?page=$page',
      fromJson: (json) => PaginationResponse<T>.fromJson(
        json,
        fromJson: fromJson!,
      ),
    );

    if (operationReply.isSuccess()) {
      paginationResponse = operationReply.result;
      paginationList = paginationResponse?.data ?? [];
      if (paginationList.isEmpty) {
        operationReply = OperationReply.empty(
          message: emptyListMessage!,
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
      update();
      return;
    }
    loadingMore = true;
    update();
    operationReply = await APIProvider.instance.get(
      endPoint: '$apiEndPoint?page=$page',
      fromJson: fromJson!,
    );

    if (operationReply.isSuccess()) {
      paginationResponse = operationReply.result;

      paginationList.addAll(paginationResponse?.data ?? []);
      if (paginationList.isEmpty) {
        operationReply = OperationReply.empty();
      } else {
        totalPages = paginationResponse?.meta?.lastPage ?? 1;
        operationReply = OperationReply.success();
      }
    }
    loadingMore = false;
    update();
  }

  Future<void> refreshApiCall() async {
    page = 1;
    totalPages = 1;
    loadingMoreEnd = false;
    loadingMore = false;
    await callApi();
  }
}
