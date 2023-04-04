import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:template/config/res/generated/i18n.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      navigatorKey: Get.key,
      translations: Messages(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('zh', 'CN'),
      defaultTransition: Transition.native,
      getPages: AppPages.routes,
      initialRoute: AppPages.INITIAL,
      theme: FlexThemeData.light(scheme: FlexScheme.blue),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.blue),
      themeMode: ThemeMode.system,
    );
  }
}
