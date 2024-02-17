import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:vpm/app/extensions/space.dart';

import '../../../../../../app/res/res.dart';
import '../../../../../widgets/app_widgets/app_text.dart';

class ServicesEmptyView extends StatelessWidget {
  const ServicesEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SvgPicture.asset(
            Res.iconEmptyServices,
            height: 250,
          ),
          20.ph,
          AppText(
            "empty_services".tr,
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).primaryColor,
            centerText: true,
          ),
        ],
      ),
    );
  }
}
