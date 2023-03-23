import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState extends ChangeNotifier {
  AppState() {
    SharedPreferences.getInstance().then((data) {
      var sp = data;
    });
  }
}
