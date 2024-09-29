import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../app/util/constants.dart';
import '../../../app/util/util.dart';
import '../../../domain/entities/models/user_model.dart';
import '../../../presentation/controller/app_config_controller.dart';
import '../network/api_provider.dart';

enum LocalProviderKeys {
  introScreen, // bool
  language, //String
  notifications, //int
  userModel, //Json String
  loggedInBySocial, //int
  phoneVerified, //int,
  appTheme, //int  0-> light mode , 1-> dark mode
  rememberMe,
  phone,
  password,
}

class LocalProvider {
  final GetStorage _box = GetStorage();

  Future init() async {
    await GetStorage.init();
    //set keys default values
    dynamic language = get(LocalProviderKeys.language);
    if (language == null) {
      save(LocalProviderKeys.language, Constants.mainAppLanguage);
    }

    dynamic intro = get(LocalProviderKeys.introScreen);
    if (intro == null) {
      save(LocalProviderKeys.introScreen, 0);
    }

    dynamic rememberMe = get(LocalProviderKeys.rememberMe);
    if (rememberMe == null) {
      save(LocalProviderKeys.rememberMe, false);
    }

    dynamic notifications = get(LocalProviderKeys.notifications);
    if (notifications == null) {
      save(LocalProviderKeys.notifications, true);
    }

    debugPrint('LocalProvider initialization.');
  }

  String getAppLanguage() => get(LocalProviderKeys.language) ?? 'en';

  bool isLogged() => get(LocalProviderKeys.userModel) != null;

  bool isAr() => get(LocalProviderKeys.language) == 'ar';

  bool isDarkMode() => get(LocalProviderKeys.appTheme) == 1;

  /// ============= ============== ===================  =================
  Future save(LocalProviderKeys localProviderKeys, dynamic value) async {
    await GetStorage().write(localProviderKeys.name, value);
    Utils.logMessage('Setting value to ${localProviderKeys.name} => $value');
  }

  dynamic get(LocalProviderKeys localProviderKeys) {
    // Utils.logMessage('Getting value of ${localProviderKeys.name} => $value');

    return GetStorage().read(localProviderKeys.name);
  }

  Future saveUserCredentials({
    required String phone,
    required String password,
  }) async {
    await save(LocalProviderKeys.rememberMe, true);
    await save(LocalProviderKeys.phone, phone);
    await save(LocalProviderKeys.password, password);
  }

  Future<bool> saveUser(UserModel? userModel) async {
    try {
      if (userModel != null && userModel.token != null) {
        await save(
          LocalProviderKeys.userModel,
          jsonEncode(userModel.toJson()),
        ); // userModel jsonString
        APIProvider.instance.updateTokenHeader(
          userModel.token,
        );
        return true;
      } else {
        Utils.logMessage('Failed to save user...');
        return false;
      }
    } catch (e) {
      Utils.logMessage(e.toString());
      return false;
    }
  }

  UserModel? getUser() {
    String? userModelString = get(LocalProviderKeys.userModel);
    if (userModelString == null) {
      return null;
    }
    UserModel userModel = UserModel.fromJson(jsonDecode(userModelString));
    return userModel;
  }

  Future<void> signOut() async {
    bool rememberMe = get(LocalProviderKeys.rememberMe);
    bool intro = get(LocalProviderKeys.introScreen) == 1;
    String? email, password;
    if (rememberMe) {
      email = get(LocalProviderKeys.phone);
      password = get(LocalProviderKeys.password);
    }
    await _box.erase();
    await save(LocalProviderKeys.phone, email);
    await save(LocalProviderKeys.password, password);
    await save(LocalProviderKeys.rememberMe, rememberMe);
    await save(LocalProviderKeys.introScreen, intro);
    Get.find<AppConfigController>().isLoggedIn.value = false;
    APIProvider.instance.updateTokenHeader(null);
    Utils.logMessage('User Logged Out Successfully');
  }
}
