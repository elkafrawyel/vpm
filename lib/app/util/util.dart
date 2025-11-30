import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../presentation/widgets/api_state_views/no_connection_view.dart';

class Utils {
  static String getImagePath(String name, {String format = 'png'}) {
    return 'assets/images/$name.$format';
  }

  static void logMessage(String message, {bool isError = false}) {
    if (kDebugMode) {
      Get.log(message, isError: isError);
    }
  }

  static void hideGetXDialog() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }

  static void showNoConnectionDialog({String? text}) {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }

    Get.dialog(const NoConnectionView(), barrierDismissible: false);
  }

  String formatNumbers(
    String number, {
    String? symbol,
    int? digits = 1,
  }) {
    return '${NumberFormat.decimalPatternDigits(
      locale: Get.locale?.languageCode == 'ar' ? 'ar_EG' : 'en_US',
      decimalDigits: digits,
    ).format(
      num.parse(number),
    )} ${symbol ?? (Get.locale?.languageCode == 'ar' ? 'ريال' : 'SAR')}';
  }

  static void callPhoneNumber({required String phoneNumber}) {
    try {
      launchUrlString("tel://$phoneNumber");
    } catch (exception) {
      logMessage(exception.toString());
    }
  }
}
