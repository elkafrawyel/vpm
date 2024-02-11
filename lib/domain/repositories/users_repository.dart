import 'package:vpm/app/util/operation_reply.dart';
import 'package:vpm/data/models/contacts_response.dart';
import 'package:vpm/data/models/general_response.dart';

abstract class UsersRepository {
  Future<OperationReply<ContactsResponse>> getAllUsers();

  Future<OperationReply<GeneralResponse>> addUser({
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
