import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:vpm/app/util/operation_reply.dart';
import 'package:vpm/data/models/balance_response.dart';
import 'package:vpm/data/models/charge_balance_response.dart';
import 'package:vpm/data/models/payment_options_response.dart';
import 'package:vpm/data/repositories/wallet_repository.dart';

import '../../app/res/res.dart';
import '../../app/util/information_viewer.dart';
import '../screens/payment/payment_screen.dart';
import '../widgets/dialogs_view/app_dialog_view.dart';

class WalletController extends GetxController {
  final WalletRepositoryImpl _walletRepository = WalletRepositoryImpl();
  final TextEditingController amountController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getWalletBalance();
    getPaymentOptions();
  }

  @override
  void dispose() {
    super.dispose();
    amountController.dispose();
  }

  String balance = '0';

  List<PaymentOptionModel> paymentOptions = [];

  PaymentOptionModel? selectedPaymentOption;

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    update();
  }

  Future getWalletBalance() async {
    loading = true;

    OperationReply operationReply = await _walletRepository.getBalance();

    if (operationReply.isSuccess()) {
      BalanceResponse balanceResponse = operationReply.result;
      balance = balanceResponse.data?.currentBalance?.toString() ?? '0';
    }
    loading = false;
  }

  Future getPaymentOptions() async {
    OperationReply<PaymentOptionsResponse> operationReply =
        await _walletRepository.getPaymentOptions();

    if (operationReply.isSuccess()) {
      PaymentOptionsResponse? paymentOptionsResponse = operationReply.result;
      paymentOptions = paymentOptionsResponse?.data ?? [];
    } else {
      InformationViewer.showSnackBar(operationReply.message);
    }
    update();
  }

  void changeSelectedAmount(PaymentOptionModel value) {
    selectedPaymentOption = value;
    amountController.text = value.price ?? '';

    update();
  }

  void requestRechargeBalance(
      BuildContext context, AnimationController animationController) async {
    if (amountController.text.isEmpty) {
      InformationViewer.showSnackBar(
          'select_one_of_the_following_to_recharge'.tr);
      return;
    }
    animationController.forward();

    OperationReply operationReply =
        await _walletRepository.chargeBalance(amount: amountController.text);

    if (operationReply.isSuccess()) {
      ChargeBalanceResponse chargeBalanceResponse = operationReply.result;

      String paymentLink =
          chargeBalanceResponse.data?.paymentLink ?? 'Payment Link null';

      if (!context.mounted) return;

      await PersistentNavBarNavigator.pushNewScreen(
        context,
        screen: PaymentScreen(
          paymentUrl: paymentLink,
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
      amountController.clear();
      selectedPaymentOption = null;
      getWalletBalance();
    } else {
      InformationViewer.showSnackBar(operationReply.message);
    }
  }
}
