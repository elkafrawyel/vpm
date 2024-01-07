import 'package:flutter/material.dart';

import '../../app/util/operation_reply.dart';
import 'api_state_views/api_connection_error_view.dart';
import 'api_state_views/api_error_view.dart';
import 'api_state_views/api_loading_view.dart';

class HandleApiState extends StatelessWidget {
  final OperationReply operationReply;
  final Widget child;
  final Function()? retryOnError;

  const HandleApiState({
    Key? key,
    required this.operationReply,
    required this.child,
    this.retryOnError,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (operationReply.status) {
      case OperationStatus.init:
        return const SizedBox();
      case OperationStatus.loading:
        return const ApiLoadingView();
      case OperationStatus.success:
        return child;
      case OperationStatus.failed:
        return ApiErrorView(
          errorText: operationReply.message,
          retry: retryOnError,
        );
      case OperationStatus.disConnected:
        return const ApiConnectionErrorView();
      default:
        return const SizedBox();
    }
  }
}
