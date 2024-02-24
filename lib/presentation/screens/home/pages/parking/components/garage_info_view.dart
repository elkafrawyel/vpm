import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vpm/data/providers/storage/local_provider.dart';

import '../../../../../../app/res/res.dart';
import '../../../../../../domain/entities/models/garage_model.dart';
import '../../../../../widgets/app_widgets/app_text.dart';

class GarageInfoView extends StatelessWidget {
  final VoidCallback onTap;
  final GarageModel garageModel;

  const GarageInfoView({
    super.key,
    required this.onTap,
    required this.garageModel,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 70.0),
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          fit: StackFit.expand,
          alignment: AlignmentDirectional.center,
          children: [
            Transform.flip(
              flipX: !LocalProvider().isAr(),
              child: SvgPicture.asset(
                garageModel.isAvailable
                    ? Res.iconBlueBorder
                    : Res.iconRedBorder,
                // width: 100,
                // height: 80,
                // fit: BoxFit.fitHeight,
              ),
            ),
            Center(
              child: AppText(
                garageModel.isAvailable
                    ? '${garageModel.reservedCarCount?.toString() ?? '0'} / ${garageModel.maxCarCount?.toString() ?? '0'}'
                    : 'garage_completed'.tr,
                fontWeight: FontWeight.bold,
                color: garageModel.isAvailable ? Colors.black : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
