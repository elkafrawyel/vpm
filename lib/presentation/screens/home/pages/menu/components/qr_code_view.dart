import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: QrImageView(
              data: qrValue,
              version: QrVersions.auto,
            ),
          ),
          GestureDetector(
            onTap: Get.back,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(kRadius),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Center(
                  child: AppText(
                    'close'.tr,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
