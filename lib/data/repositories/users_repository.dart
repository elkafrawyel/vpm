import 'package:vpm/app/util/operation_reply.dart';

import '../../domain/repositories/users_repository.dart';

class UserRepositoryImpl extends UsersRepository {
  @override
  Future<OperationReply> addUser({
    required String name,
    required String phone,
    required String password,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<OperationReply> editUser({
    required int id,
    required String name,
    required String phone,
    required String password,
  }) {
    throw UnimplementedError();
  }

  @override
  Future<OperationReply> getAllUsers() {
    throw UnimplementedError();
  }
}
