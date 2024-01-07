import '../../app/util/operation_reply.dart';

abstract class HomeRepository {
  Future<OperationReply<bool>> get();
}
