import 'package:flutter/material.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/presentation/widgets/shimmer_widgets/shimmer_effect_ui.dart';

class ServiceShimmerCard extends StatelessWidget {
  const ServiceShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const MyShimmerEffectUI.rectangular(
          width: 140,
          height: 120,
          radius: 8,
        ),
        10.pw,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MyShimmerEffectUI.rectangular(
                height: 13,
              ),
              10.ph,
              const Padding(
                padding: EdgeInsetsDirectional.only(end: 28.0),
                child: MyShimmerEffectUI.rectangular(
                  height: 13,
                ),
              ),
              5.ph,
              const Padding(
                padding: EdgeInsetsDirectional.only(end: 28.0),
                child: MyShimmerEffectUI.rectangular(
                  height: 13,
                ),
              ), 5.ph,
              const Padding(
                padding: EdgeInsetsDirectional.only(end: 28.0),
                child: MyShimmerEffectUI.rectangular(
                  height: 13,
                ),
              ),
              10.ph,
              const MyShimmerEffectUI.rectangular(
                width: 100,
                height: 14,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
