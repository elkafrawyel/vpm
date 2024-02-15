import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/app/util/constants.dart';
import 'package:vpm/app/util/util.dart';
import 'package:vpm/presentation/controller/wallet_controller/wallet_controller.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_progress_button.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';


class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final WallerController wallerController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('wallet'.tr),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(28),
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(kRadius),
              ),
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  children: [
                    AppText(
                      'account_balance'.tr,
                      fontSize: 20,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    10.ph,
                    GetBuilder<WallerController>(
                      builder: (wallerController) {
                        return AppText(
                          Utils().formatNumbers(
                            wallerController.balance,
                          ),
                          fontSize: 25,
                          fontWeight: FontWeight.w700,
                          color: Theme.of(context).scaffoldBackgroundColor,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            10.ph,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: AppText(
                'select_one_of_the_following_to_recharge'.tr,
                fontWeight: FontWeight.w300,
              ),
            ),
            10.ph,
            GetBuilder<WallerController>(
              builder: (_) => Column(
                children: wallerController.options
                    .map(
                      (e) => Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18.0,
                          vertical: 2.0,
                        ),
                        child: Row(
                          children: [
                            Radio(
                              value: e,
                              groupValue: wallerController.selectedOption,
                              onChanged: (WalletOptions? value) {
                                if (value == null) {
                                  return;
                                }
                                wallerController.changeSelectedAmount(value);
                              },
                            ),
                            AppText(
                              '${'pay'.tr} ${Utils().formatNumbers(
                                e.text,
                              )}',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            )
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            10.ph,
            Padding(
              padding: const EdgeInsets.all(38.0),
              child: AppProgressButton(
                width: MediaQuery.sizeOf(context).width,
                text: 'submit'.tr,
                onPressed: (animationController) async {
                  wallerController.requestRechargeBalance(
                    context,
                    animationController,
                  );
                },
              ),
            ),
            200.ph,
          ],
        ),
      ),
    );
  }
}
