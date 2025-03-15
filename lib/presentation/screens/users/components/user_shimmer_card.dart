import 'package:flutter/material.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/presentation/widgets/shimmer_widgets/shimmer_effect_ui.dart';

import '../../../../app/config/app_color.dart';

class UserShimmerCard extends StatelessWidget {
  const UserShimmerCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const MyShimmerEffectUI.circular(
            height: 80,
            width: 80,
          ),
          10.pw,
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0),
            child: MyShimmerEffectUI.rectangular(
              height: 12,
              width: 100,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.clear),
            color: errorColor,
          ),
        ],
      ),
    );
  }
}
