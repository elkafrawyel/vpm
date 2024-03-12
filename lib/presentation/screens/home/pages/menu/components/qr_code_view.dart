import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:vpm/app/extensions/space.dart';
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
      margin: EdgeInsets.symmetric(
        vertical: MediaQuery.sizeOf(context).height * 0.2,
        horizontal: 8,
      ),
      child: Column(
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: QrImageView(
                data: qrValue,
                version: QrVersions.auto,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.8,
            child: ElevatedButton(
              onPressed: Get.back,
              child: AppText(
                'close'.tr,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          10.ph,
        ],
      ),
    );
  }
}
