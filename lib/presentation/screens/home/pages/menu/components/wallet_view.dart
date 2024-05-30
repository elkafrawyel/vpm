import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/app/util/util.dart';
import 'package:vpm/presentation/controller/wallet_controller.dart';

import '../../../../../widgets/app_widgets/app_text.dart';
import '../../../../../widgets/shimmer_widgets/shimmer_effect_ui.dart';
import '../../../../wallet/wallet_screen.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      splashColor: Colors.transparent,
      leading: const Icon(Icons.wallet),
      title: Text('wallet'.tr),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          GetBuilder<WalletController>(
            init: WalletController(),
            builder: (walletController) {
              return walletController.loading
                  ? const MyShimmerEffectUI.rectangular(
                      height: 13,
                      width: 100,
                    )
                  : AppText(
                      Utils().formatNumbers(walletController.balance),
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    );
            },
          ),
          10.pw,
          Icon(
            Icons.arrow_forward_ios,
            color: Theme.of(context).dividerColor,
            size: 20,
          ),
        ],
      ),
      onTap: () {
        PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: const WalletScreen(),
          withNavBar: true,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
    );
  }
}
