import 'dart:convert';

import 'package:fcm_config/fcm_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vpm/app/util/information_viewer.dart';
import 'package:vpm/data/models/general_response.dart';
import 'package:vpm/data/providers/network/api_provider.dart';
import 'package:vpm/presentation/controller/my_controllers/pagination_controller/pagination_controller.dart';

import '../../app/res/res.dart';
import '../../app/util/operation_reply.dart';
import '../../domain/entities/models/notifications_model.dart';

class NotificationsController extends PaginationController<NotificationsModel> {
  NotificationsController(super.configData);

  convertDate(String? dateString) => dateString == null
      ? ''
      : DateFormat('EE, dd MMMM', Get.locale.toString()).format(
          DateTime.parse(dateString),
        );

  void addNewNotification(RemoteMessage notification) {
    if (kDebugMode) {
      print('inserting new notification');
    }
    paginationList.insert(
        0,
        NotificationsModel.fromJson(
            jsonDecode(notification.data['notification_model'].toString())));
    operationReply = OperationReply.success();
  }

  Future cancelRequest(NotificationsModel notificationsModel,
      AnimationController animationController) async {
    animationController.forward();

    OperationReply operationReply =
        await APIProvider.instance.patch<GeneralResponse>(
      endPoint: '${Res.apiCancelRequest}/${notificationsModel.eventId}',
      fromJson: GeneralResponse.fromJson,
      requestBody: {},
    );

    if (operationReply.isSuccess()) {
      GeneralResponse generalResponse = operationReply.result;
      InformationViewer.showSuccessToast(msg: generalResponse.message);

      animationController.reverse();
      paginationList.remove(notificationsModel);
      update();
    } else {
      animationController.reverse();
      InformationViewer.showErrorToast(msg: operationReply.message);
    }
  }
}
