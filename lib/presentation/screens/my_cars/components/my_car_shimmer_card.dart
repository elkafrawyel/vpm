import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/app/res/res.dart';
import 'package:vpm/app/util/constants.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_cached_image.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';
import 'package:vpm/presentation/widgets/shimmer_widgets/shimmer_effect_ui.dart';

class MyCarShimmerCard extends StatelessWidget {
  const MyCarShimmerCard({super.key});

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
          const MyShimmerEffectUI.rectangular(
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
                const MyShimmerEffectUI.rectangular(
                  height: 13,
                  width: 150,
                ),
                10.ph,
                const MyShimmerEffectUI.rectangular(
                  height: 13,
                  width: 130,
                ),
                10.ph,
                const MyShimmerEffectUI.rectangular(
                  height: 13,
                  width: 130,
                ),
                10.ph,
                Row(
                  children: [
                    const MyShimmerEffectUI.rectangular(
                      height: 13,
                      width: 40,
                    ),
                    10.pw,
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: MyShimmerEffectUI.rectangular(
                        height: 13,
                        width: 40,
                      ),
                    ),
                    10.pw,
                    const MyShimmerEffectUI.rectangular(
                      height: 13,
                      width: 40,
                    ),
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
