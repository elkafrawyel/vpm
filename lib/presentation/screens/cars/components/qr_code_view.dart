import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vpm/app/config/app_color.dart';
import 'package:vpm/app/util/constants.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';

class QrCodeView extends StatelessWidget {
  final String qrValue;

  const QrCodeView({super.key, required this.qrValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(kRadius),
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 150,
        horizontal: 18,
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: QrImageView(
              data: qrValue,
              version: QrVersions.auto,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: Get.back,
              child: AppText(
                'close'.tr,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: errorColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}
