import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vpm/app/util/util.dart';
import 'package:vpm/presentation/controller/notifications_controller.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_cached_image.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_progress_button.dart';

import '../../../../../../app/config/app_color.dart';
import '../../../../../../domain/entities/models/notifications_model.dart';
import '../../../../../widgets/app_widgets/app_text.dart';

class NotificationsCard extends StatelessWidget {
  final NotificationsModel notificationsModel;

  const NotificationsCard({super.key, required this.notificationsModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: AppText(
              Get.locale?.languageCode == "ar"
                  ? notificationsModel.eventNameAr ?? ''
                  : notificationsModel.eventName ?? '',
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: AppText(
                Get.locale?.languageCode == "ar"
                    ? notificationsModel.eventContentAr ?? ''
                    : notificationsModel.eventContent ?? '',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: hintColor,
                maxLines: 3,
              ),
            ),
          ),
          Offstage(
            offstage: notificationsModel.driver == null,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              horizontalTitleGap: 0,
              leading: AppCachedImage(
                imageUrl: notificationsModel.driver?.avatar?.filePath,
                isCircular: true,
                width: 70,
                height: 70,
                borderColor: Colors.black,
                borderWidth: 1,
              ),
              title: AppText(
                notificationsModel.driver?.name ?? '',
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              subtitle: AppText(
                notificationsModel.driver?.phone ?? '',
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              trailing: notificationsModel.driver?.phone == null
                  ? null
                  : IconButton(
                      onPressed: () {
                        Utils.callPhoneNumber(
                          phoneNumber: notificationsModel.driver!.phone!,
                        );
                      },
                      icon: const Icon(Icons.call),
                    ),
            ),
          ),
          Offstage(
            offstage: notificationsModel.driver == null,
            child: Center(
              child: AppProgressButton(
                onPressed: (animationController) async {
                  _cancelRequest(animationController);
                },
                text: 'cancel_request'.tr,
                backgroundColor: Colors.red,
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 8.0,
              ),
              child: AppText(
                DateFormat(
                  "hh:mm a",
                  Get.locale?.languageCode,
                ).format(
                  DateTime.parse(notificationsModel.createdAt!),
                ),
                fontSize: 12,
                fontWeight: FontWeight.w100,
                color: hintColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _cancelRequest(AnimationController animationController) async {
    await Get.find<NotificationsController>()
        .cancelRequest(notificationsModel, animationController);
  }
}
