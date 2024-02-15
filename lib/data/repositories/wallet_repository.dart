import 'package:vpm/app/util/operation_reply.dart';
import 'package:vpm/domain/repositories/wallet_repository.dart';

class WalletRepositoryImpl extends WalletRepository {
  @override
  Future<OperationReply<String>> getBalance() async {
    return OperationReply.success(result: '5000');
  }
}
