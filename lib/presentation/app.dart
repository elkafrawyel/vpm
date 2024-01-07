import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

import '../app/config/environment.dart';
import '../app/util/focus_remover.dart';
import '../app/util/language/translation.dart';
import '../data/providers/storage/local_provider.dart';
import 'controller/app_config_controller.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AppConfigController appConfigController =
      Get.put(AppConfigController(), permanent: true);

  @override
  Widget build(BuildContext context) {
    String appLanguage = LocalProvider().getAppLanguage();
    return Obx(
      () => FocusRemover(
        child: OKToast(
          child: GetMaterialApp(
            home: Container(color: Theme.of(context).scaffoldBackgroundColor),
            debugShowCheckedModeBanner:
                Environment.appMode == AppMode.staging ||
                    Environment.appMode == AppMode.testing,
            defaultTransition: Transition.cupertino,
            transitionDuration: const Duration(milliseconds: 300),
            title: 'VPM',
            theme: appConfigController.theme.value,
            translations: Translation(),
            locale: Locale(appLanguage),
            fallbackLocale: Locale(appLanguage),
            supportedLocales: appConfigController.supportedLocales,
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            builder: (context, navigatorWidget) {
              try {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                    textScaler: const TextScaler.linear(1.0),
                  ),
                  child: navigatorWidget ?? const SizedBox(),
                );
              } catch (e) {
                return navigatorWidget ?? const SizedBox();
              }
            },
          ),
        ),
      ),
    );
  }
}
