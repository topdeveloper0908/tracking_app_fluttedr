import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import 'package:tracking/services/auth-provider.dart';
import 'package:tracking/services/app-translation.dart';
import 'package:tracking/auth/sign-in.dart';
import 'package:tracking/services/change-language.dart';

class MyApp extends StatefulWidget {
  // final SharedPreferences sharedPreferences;
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  Future<void> init() async {
    Get.put(MyLanguageController());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // _authProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    init();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthenticateProviderPage(),
        ),
      ],
      child: GetMaterialApp(
        navigatorKey: Get.key,
        title: 'Flutter Demo',
        translations: AppTranslation(),
        locale: Locale('en'),
        fallbackLocale: Locale('en'),
        home: const SignInPage(),
      ),
    );
  }
}
