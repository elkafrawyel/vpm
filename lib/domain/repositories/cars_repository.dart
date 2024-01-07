import '../../app/util/operation_reply.dart';

abstract class CarsRepository {
  Future<OperationReply<bool>> get();
  Future<OperationReply<bool>> update();
  Future<OperationReply<bool>> delete();
}
