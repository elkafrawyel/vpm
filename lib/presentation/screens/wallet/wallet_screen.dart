import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:vpm/app/extensions/space.dart';
import 'package:vpm/app/util/constants.dart';
import 'package:vpm/app/util/information_viewer.dart';
import 'package:vpm/presentation/screens/payment/payment_screen.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_progress_button.dart';
import 'package:vpm/presentation/widgets/app_widgets/app_text.dart';

import '../../../app/res/res.dart';
import '../../widgets/dialogs_view/app_dialog_view.dart';

class WalletOptions {
  String text;
  bool selected;

  WalletOptions(this.text, this.selected);
}

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  List<WalletOptions> options = [
    WalletOptions('Pay 40 SAR', false),
    WalletOptions('Pay 60 SAR', false),
    WalletOptions('Pay 80 SAR', false),
    WalletOptions('Pay 100 SAR', false),
  ];

  WalletOptions? selectedOption;
  String balance = '200';

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
                    AppText(
                      '$balance SAR',
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).scaffoldBackgroundColor,
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
            ...options
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
                          groupValue: selectedOption,
                          onChanged: (WalletOptions? value) {
                            setState(() {
                              selectedOption = value;
                            });
                          },
                        ),
                        AppText(
                          e.text,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        )
                      ],
                    ),
                  ),
                )
                .toList(),
            10.ph,
            Padding(
              padding: const EdgeInsets.all(38.0),
              child: AppProgressButton(
                width: MediaQuery.sizeOf(context).width,
                text: 'submit'.tr,
                onPressed: (animationController) async {
                  if (selectedOption == null) {
                    InformationViewer.showSnackBar(
                        'select_one_of_the_following_to_recharge'.tr);
                    return;
                  }
                  await PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: PaymentScreen(
                      paymentUrl: 'https://www.google.com',
                      onPaymentSuccess: () {
                        Get.dialog(
                          AppDialogView(
                            svgName: Res.iconSuccess,
                            title: 'Congratulations!',
                            message: 'Payment Successful!',
                            actionText: 'Go to Homepage',
                            onActionClicked: () {
                              /// this to close this dialog
                              Get.back();

                              /// this to close the payment screen
                              Navigator.of(context).pop();
                            },
                          ),
                        );
                      },
                      onPaymentFailed: () {
                        Get.dialog(
                          AppDialogView(
                            svgName: Res.iconError,
                            title: 'Sorry!!',
                            message: 'Payment UnSuccessful!',
                            actionText: 'Go to Homepage',
                            onActionClicked: () {
                              /// this to close this dialog
                              Get.back();

                              /// this to close the payment screen
                              Navigator.of(context).pop();
                            },
                          ),
                        );
                      },
                      screenTitle: 'charge_your_account'.tr,
                    ),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );

                  /// todo load the balance
                  setState(() {
                    selectedOption = null;
                    balance = '1000';
                  });
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
