import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/app/util/constants.dart';
import 'package:vpm/app/util/util.dart';
import 'package:vpm/data/models/payment_options_response.dart';
import 'package:vpm/presentation/controller/wallet_controller/wallet_controller.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_progress_button.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text_field/app_text_field.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final WalletController walletController = Get.find();

  @override
  void dispose() {
    super.dispose();
    walletController.selectedPaymentOption = null;
    walletController.amountController.clear();
  }

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
                    GetBuilder<WalletController>(
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
              child: AppText('type_amount'.tr),
            ),
            AppTextFormField(
              controller: walletController.amountController,
              hintText: 'amount'.tr,
              horizontalPadding: 28,
              keyboardType: TextInputType.phone,
            ),
            20.ph,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: AppText(
                'select_one_of_the_following_to_recharge'.tr,
                fontWeight: FontWeight.w300,
              ),
            ),
            GetBuilder<WalletController>(
              builder: (_) => Column(
                children: walletController.paymentOptions
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
                              groupValue: walletController.selectedPaymentOption,
                              onChanged: (PaymentOptionModel? value) {
                                if (value == null) {
                                  return;
                                }
                                walletController.changeSelectedAmount(value);
                              },
                            ),
                            AppText(
                              '${'pay'.tr} ${Utils().formatNumbers(
                                e.price.toString(),
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
            Center(
              child: Padding(
                padding: const EdgeInsets.all(38.0),
                child: AppProgressButton(
                  width: MediaQuery.sizeOf(context).width,
                  text: 'submit'.tr,
                  onPressed: (animationController) async {
                    walletController.requestRechargeBalance(
                      context,
                      animationController,
                    );
                  },
                ),
              ),
            ),
            200.ph,
          ],
        ),
      ),
    );
  }
}
