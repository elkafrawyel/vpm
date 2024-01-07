import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../app/util/constants.dart';
import '../../../app/util/util.dart';
import '../../../presentation/controller/app_config_controller.dart';
import '../../models/user_response.dart';
import '../network/api_provider.dart';

enum LocalProviderKeys {
  intro, // int
  language, //String
  apiToken, //String
  apiTokenType, //String
  notifications, //int
  userModel, //Json String
  loggedInBySocial, //int
  phoneVerified, //int,
  appTheme, //int  0-> light mode , 1-> dark mode
}

class LocalProvider {
  final GetStorage _box = GetStorage();

  init() async {
    await GetStorage.init();
  }

  String getAppLanguage() => get(LocalProviderKeys.language) ?? Constants.mainAppLanguage;

  String? getUserToken() => get(LocalProviderKeys.apiToken);

  bool isLogged() => get(LocalProviderKeys.apiToken) != null;

  bool isAr() => (get(LocalProviderKeys.language) ?? Constants.mainAppLanguage) == 'ar';

  bool isDarkMode() => get(LocalProviderKeys.appTheme) == 1;

  /// ============= ============== ===================  =================
  Future save(LocalProviderKeys localProviderKeys, dynamic value) async {
    await GetStorage().write(localProviderKeys.name, value);
    Utils.logMessage('Setting value to ${localProviderKeys.name} => $value');
  }

  dynamic get(LocalProviderKeys localProviderKeys) {
    dynamic value = GetStorage().read(localProviderKeys.name);
    // Utils.logMessage('Getting value of ${localProviderKeys.name} => $value');
    return value;
  }

  Future<bool> saveUser(UserResponse? userResponse) async {
    try {
      if (userResponse?.token != null) {
        await save(LocalProviderKeys.apiToken, userResponse?.token ?? 'no token');
        await save(LocalProviderKeys.userModel, jsonEncode(userResponse?.user?.toJson())); // userModel jsonString
        APIProvider.instance.updateTokenHeader(userResponse?.token);

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
    //fabricasupport@alqamzi.com
    //fabricacs123456
    //token eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOjEsImlzcyI6Imh0dHBzOi8vYXBpLmFscWFtemkuY29tL2FwaS9sb2dpbiIsImlhdCI6MTY3OTIyODgwOSwiZXhwIjoxNjc5NDAxNjA5LCJuYmYiOjE2NzkyMjg4MDksImp0aSI6Inp2WWZSYnh3VVEzamhZMjYifQ.tMvVqygNO-0JTLF3UmU06pf2koE0SCfvE5i6o7h7I5o
    await _box.erase();
    Get.find<AppConfigController>().isLoggedIn.value = false;
    APIProvider.instance.updateTokenHeader(null);
  }
}
