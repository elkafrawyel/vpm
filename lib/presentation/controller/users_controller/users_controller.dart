import 'package:get/get.dart';
import 'package:vpm/data/repositories/users_repository.dart';

class UsersController extends GetxController {
  final UserRepositoryImpl _userRepositoryImpl;

  UsersController(this._userRepositoryImpl);

  Future addUser({
    required String name,
    required String phone,
    required String password,
  }) async {
    _userRepositoryImpl.addUser(
      name: name,
      phone: phone,
      password: password,
    );
  }
}
