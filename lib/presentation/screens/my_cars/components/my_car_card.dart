import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vpm/app/config/app_color.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/app/res/res.dart';
import 'package:vpm/app/util/constants.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_cached_image.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';

class MyCarCard extends StatelessWidget {
  const MyCarCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      color: Color(0xffF4F4F4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kRadius),
      ),
      child: Row(
        children: [
          const AppCachedImage(
            imageUrl:
                'https://imageio.forbes.com/specials-images/imageserve/5d35eacaf1176b0008974b54/2020-Chevrolet-Corvette-Stingray/0x0.jpg?format=jpg&crop=4560,2565,x790,y784,safe&width=960',
            width: 130,
            height: 120,
            radius: 4,
          ),
          10.pw,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppText(
                  'Car Title',
                  fontSize: 16,
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w700,
                ),
                const AppText(
                  '4x4 Truck',
                  fontSize: 14,
                  // color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w400,
                ),
                const AppText(
                  'AFD 6397',
                  color: hintColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                ),
                Row(
                  children: [
                    AppText(
                      'Edit',
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w700,
                      underLine: true,
                    ),
                    10.pw,
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AppText(
                        'Scan',
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w700,
                        underLine: true,
                      ),
                    ),
                    10.pw,
                    AppText(
                      'Delete',
                      color: Theme.of(context).colorScheme.error,
                      fontWeight: FontWeight.w700,
                      underLine: true,
                    ),
                    // InkWell(
                    //   child: SvgPicture.asset(Res.iconScan),
                    // ),
                  ],
                ),
              ],
            ),
          ),
          10.ph,
        ],
      ),
    );
  }
}
