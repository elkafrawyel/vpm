import 'package:vpm/app/res/res.dart';
import 'package:vpm/app/util/operation_reply.dart';
import 'package:vpm/data/models/balance_response.dart';
import 'package:vpm/data/models/charge_balance_response.dart';
import 'package:vpm/data/models/payment_options_response.dart';
import 'package:vpm/data/providers/network/api_provider.dart';
import 'package:vpm/domain/repositories/wallet_repository.dart';

class WalletRepositoryImpl extends WalletRepository {
  @override
  Future<OperationReply<BalanceResponse>> getBalance() async {
    return APIProvider.instance.get(
      endPoint: Res.apiGetBalance,
      fromJson: BalanceResponse.fromJson,
    );
  }

  @override
  Future<OperationReply<PaymentOptionsResponse>> getPaymentOptions() {
    return APIProvider.instance.get<PaymentOptionsResponse>(
      endPoint: Res.apiGetPaymentOptions,
      fromJson: PaymentOptionsResponse.fromJson,
    );
  }

  @override
  Future<OperationReply<ChargeBalanceResponse>> chargeBalance({required String amount}) async {
    return APIProvider.instance.post<ChargeBalanceResponse>(
      endPoint: Res.apiChargeBalance,
      fromJson: ChargeBalanceResponse.fromJson,
      requestBody: {'amount': amount},
    );
  }
}
