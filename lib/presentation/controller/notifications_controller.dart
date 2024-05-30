import 'dart:convert';

import 'package:fcm_config/fcm_config.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vpm/presentation/controller/my_controllers/pagination_controller/pagination_controller.dart';

import '../../app/res/res.dart';
import '../../app/util/operation_reply.dart';
import '../../domain/entities/models/notifications_model.dart';

class NotificationsController extends PaginationController<NotificationsModel> {
  @override
  void onInit() {
    super.onInit();
    build(
      apiEndPoint: Res.apiNotifications,
      emptyListMessage: 'Empty Notifications List',
      fromJson: NotificationsModel.fromJson,
    );
    callApi();
  }

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
}
