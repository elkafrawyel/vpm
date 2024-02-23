import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vpm/presentation/screens/home/pages/parking/components/garage_model.dart';

import '../../../../../../app/res/res.dart';
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
      padding: const EdgeInsetsDirectional.only(start: 80.0),
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          fit: StackFit.expand,
          alignment: AlignmentDirectional.center,
          children: [
            SvgPicture.asset(
              garageModel.isCompleted ? Res.iconRedBorder : Res.iconBlueBorder,
            ),
            Center(
              child: AppText(
                garageModel.isCompleted ? 'Booked' : '109/1000',
                fontWeight: FontWeight.bold,
                color: garageModel.isCompleted ? Colors.white : Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
