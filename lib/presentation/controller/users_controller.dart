import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:vpm/app/util/information_viewer.dart';
import 'package:vpm/app/util/operation_reply.dart';
import 'package:vpm/data/models/contacts_response.dart';
import 'package:vpm/data/models/general_response.dart';
import 'package:vpm/data/repositories/users_repository.dart';

import 'my_controllers/general_controller.dart';

class UsersController extends GeneralController {
  final UserRepositoryImpl _userRepositoryImpl;

  UsersController(this._userRepositoryImpl);

  @override
  void onInit() {
    super.onInit();
    getAllContacts();
  }

  List<ContactModel> usersList = [];

  Future getAllContacts({bool loading = true}) async {
    if (loading) {
      operationReply = OperationReply.loading();
    }
    operationReply = await _userRepositoryImpl.getAllUsers();

    if (operationReply.isSuccess()) {
      ContactsResponse contactsResponse = operationReply.result;
      usersList = contactsResponse.data ?? [];

      if (usersList.isEmpty) {
        operationReply = OperationReply.empty(
          message: 'There are no contacts',
        );
      } else {
        operationReply = OperationReply.success();
      }
    }
  }

  Future<OperationReply> addUser({
    String? userId,
    required String name,
    required String phone,
    required String password,
    required AnimationController animationController,
    required BuildContext context,
  }) async {
    animationController.forward();

    OperationReply operationReply = userId == null
        ? await _userRepositoryImpl.addUser(
            name: name,
            phone: phone,
            password: password,
          )
        : await _userRepositoryImpl.editUser(
            id: userId,
            name: name,
            phone: phone,
          );
    animationController.reverse();

    return operationReply;
  }

  @override
  Future<void> refreshApiCall() async {
    getAllContacts();
  }

  void deleteUser(ContactModel user) async {
    EasyLoading.show();
    OperationReply operationReply = await _userRepositoryImpl.deleteUser(
      userId: user.id!,
    );
    EasyLoading.dismiss();
    if (operationReply.isSuccess()) {
      GeneralResponse generalResponse = operationReply.result;
      InformationViewer.showSnackBar(generalResponse.message);
      usersList.remove(user);
      if (usersList.isEmpty) {
        this.operationReply = OperationReply.empty();
      }
      update();
    } else {
      InformationViewer.showSnackBar(operationReply.message);
    }
  }
}
