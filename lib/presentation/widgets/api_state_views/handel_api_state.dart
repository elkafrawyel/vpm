import 'package:flutter/material.dart';
import 'package:vpm/presentation/widgets/api_state_views/api_empty_view.dart';

import '../../../app/util/operation_reply.dart';
import '../../controller/my_controllers/general_controller.dart';
import 'api_connection_error_view.dart';
import 'api_error_view.dart';
import 'api_loading_view.dart';

class HandleApiState extends StatelessWidget {
  final GeneralController? generalController;
  final OperationReply? operationReply;
  final Widget child;
  final Widget? shimmerLoader;
  final Widget? emptyView;

  const HandleApiState.controller({
    super.key,
    required this.generalController,
    required this.child,
    this.operationReply,
    this.shimmerLoader,
    this.emptyView,
  });

  const HandleApiState.operation({
    super.key,
    required this.operationReply,
    required this.child,
    this.generalController,
    this.shimmerLoader,
    this.emptyView,
  });

  @override
  Widget build(BuildContext context) {
    if (generalController != null) {
      switch (generalController!.operationReply.status) {
        case OperationStatus.init:
          return const SizedBox();
        case OperationStatus.loading:
          return shimmerLoader ?? const ApiLoadingView();
        case OperationStatus.success:
          return child;
        case OperationStatus.failed:
          return ApiErrorView(
            errorText: generalController!.operationReply.message,
            retry: generalController!.refreshApiCall,
          );
        case OperationStatus.empty:
          return emptyView ??
              ApiEmptyView(
                emptyText: generalController!.operationReply.message,
              );
        case OperationStatus.disConnected:
          return const ApiConnectionErrorView();
        }
    } else if (operationReply != null) {
      switch (operationReply!.status) {
        case OperationStatus.init:
          return const SizedBox();
        case OperationStatus.loading:
          return shimmerLoader ?? const ApiLoadingView();
        case OperationStatus.success:
          return child;
        case OperationStatus.failed:
          return ApiErrorView(errorText: operationReply!.message);
        case OperationStatus.disConnected:
          return const ApiConnectionErrorView();
        case OperationStatus.empty:
          return emptyView ??
              ApiEmptyView(
                emptyText: generalController!.operationReply.message,
              );
        }
    } else {
      return const SizedBox();
    }
  }
}
