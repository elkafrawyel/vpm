import 'package:vpm/app/res/res.dart';
import 'package:vpm/app/util/operation_reply.dart';
import 'package:vpm/data/models/contacts_response.dart';
import 'package:vpm/data/models/general_response.dart';
import 'package:vpm/data/providers/network/api_provider.dart';

import '../../domain/repositories/users_repository.dart';

class UserRepositoryImpl extends UsersRepository {
  @override
  Future<OperationReply<GeneralResponse>> addUser({
    required String name,
    required String phone,
    required String password,
  }) {
    return APIProvider.instance.post(
      endPoint: Res.apiCreateContact,
      fromJson: GeneralResponse.fromJson,
      requestBody: {
        "name": name,
        "phone": phone,
        "password": password,
      },
    );
  }

  @override
  Future<OperationReply<GeneralResponse>> editUser({
    required String id,
    required String name,
    required String phone,
  }) {
    return APIProvider.instance.patch(
      endPoint: "${Res.apiCreateContact}/$id",
      fromJson: GeneralResponse.fromJson,
      requestBody: {
        "name": name,
        "phone": phone,
      },
    );
  }

  @override
  Future<OperationReply<ContactsResponse>> getAllUsers() async {
    return APIProvider.instance.get<ContactsResponse>(
      endPoint: "${Res.apiAllContact}?per_page=1000",
      fromJson: ContactsResponse.fromJson,
    );
  }

  @override
  Future<OperationReply<GeneralResponse>> deleteUser({
    required String userId,
  }) async {
    return APIProvider.instance.delete<GeneralResponse>(
      endPoint: '${Res.apiDeleteUser}/$userId',
      fromJson: GeneralResponse.fromJson,
      requestBody: {},
    );
  }
}
