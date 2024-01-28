import 'package:vpm/app/util/operation_reply.dart';

abstract class UsersRepository {
  Future<OperationReply> getAllUsers();

  Future<OperationReply> addUser({
    required String name,
    required String phone,
    required String password,
  });

  Future<OperationReply> editUser({
    required int id,
    required String name,
    required String phone,
    required String password,
  });
}
