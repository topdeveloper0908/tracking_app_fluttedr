import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tracking/store/index.dart';
import 'package:tracking/pages/landing.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(new MultiProvider(
      providers: [ChangeNotifierProvider.value(value: AppState())],
      child: new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new LandingPage(),
      )));
}
