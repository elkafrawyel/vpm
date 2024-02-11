import 'package:flutter/cupertino.dart';
import 'package:vpm/app/util/operation_reply.dart';
import 'package:vpm/data/models/contacts_response.dart';
import 'package:vpm/data/repositories/users_repository.dart';

import '../general_controller.dart';

class UsersController extends GeneralController {
  final UserRepositoryImpl _userRepositoryImpl;

  UsersController(this._userRepositoryImpl);

  @override
  void onInit() {
    super.onInit();
    getAllContacts();
  }

  List<ContactModel> contactsList = [];

  Future getAllContacts() async {
    operationReply = OperationReply.loading();
    operationReply = await _userRepositoryImpl.getAllUsers();

    if (operationReply.isSuccess()) {
      ContactsResponse contactsResponse = operationReply.result;
      contactsList = contactsResponse.data ?? [];

      if (contactsList.isEmpty) {
        operationReply = OperationReply.empty(
          message: 'There are no contacts',
        );
      } else {
        operationReply = OperationReply.success();
      }
    }
  }

  Future<OperationReply> addUser({
    required String name,
    required String phone,
    required String password,
    required AnimationController animationController,
    required BuildContext context,
  }) async {
    animationController.forward();
    OperationReply operationReply = await _userRepositoryImpl.addUser(
      name: name,
      phone: phone,
      password: password,
    );
    animationController.reverse();

    return operationReply;
  }

  @override
  Future<void> refreshApiCall() async {
    getAllContacts();
  }
}
