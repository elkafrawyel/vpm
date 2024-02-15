import '../../app/util/operation_reply.dart';

abstract class WalletRepository{

  Future<OperationReply<String>> getBalance();
}