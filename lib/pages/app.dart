import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tracking/services/auth-provider.dart';
import 'package:tracking/auth/sign-in.dart';

class MyApp extends StatefulWidget {
  // final SharedPreferences sharedPreferences;
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthenticateProviderPage(),
        ),
      ],
      child: Builder(
        builder: (context) {
          return ChangeNotifierProvider<AuthenticateProviderPage>(
            create: (BuildContext context) => AuthenticateProviderPage(),
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                primaryColor: Color(0xFF2FB1A8),
                primarySwatch: Colors.blue,
              ),
              home: const SignInPage(),
            ),
          );
        },
      ),
    );
  }
}
