import '../../app/util/operation_reply.dart';
import '../../data/models/balance_response.dart';
import '../../data/models/charge_balance_response.dart';
import '../../data/models/payment_options_response.dart';

abstract class WalletRepository {
  Future<OperationReply<BalanceResponse>> getBalance();

  Future<OperationReply<PaymentOptionsResponse>> getPaymentOptions();

  Future<OperationReply<ChargeBalanceResponse>> chargeBalance({required String amount});
}
