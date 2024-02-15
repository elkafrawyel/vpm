import 'package:flutter/cupertino.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:vpm/app/util/operation_reply.dart';
import 'package:vpm/data/repositories/wallet_repository.dart';

import '../../../app/res/res.dart';
import '../../../app/util/information_viewer.dart';
import '../../screens/payment/payment_screen.dart';
import '../../widgets/dialogs_view/app_dialog_view.dart';

class WalletOptions {
  String text;
  bool selected;

  WalletOptions(this.text, this.selected);
}

class WallerController extends GetxController {
  final WalletRepositoryImpl _walletRepository = WalletRepositoryImpl();

  @override
  void onInit() {
    super.onInit();
    getWalletBalance();
  }

  String balance = '';
  bool _loading = false;

  List<WalletOptions> options = [
    WalletOptions('40', false),
    WalletOptions('60', false),
    WalletOptions('80', false),
    WalletOptions('100', false),
  ];

  WalletOptions? selectedOption;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    update();
  }

  void getWalletBalance() async {
    loading = true;

    OperationReply operationReply = await _walletRepository.getBalance();

    if (operationReply.isSuccess()) {
      balance = operationReply.result;
    }
    loading = false;
  }

  void changeSelectedAmount(WalletOptions value) {
    selectedOption = value;
    update();
  }

  void requestRechargeBalance(
    BuildContext context,
    AnimationController animationController,
  ) async {
    if (selectedOption == null) {
      InformationViewer.showSnackBar('select_one_of_the_following_to_recharge'.tr);
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
    getWalletBalance();

    balance = selectedOption?.text ?? '';
  }
}
