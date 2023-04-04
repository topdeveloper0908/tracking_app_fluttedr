import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:toast/toast.dart';

class AuthenticateProviderPage extends ChangeNotifier {
  static AuthenticateProviderPage of(BuildContext context,
          {bool listen = false}) =>
      Provider.of<AuthenticateProviderPage>(context, listen: listen);

  int _signVal = 0;
  bool _isAuthenticated = false;
  String _verificationTitle = "";
  String _verificationTool = "";
  String _password = "";
  String _userName = "";

  get password => _password;
  get userName => _userName;
  get isAuthenticated => _isAuthenticated;
  get signVal => _signVal;
  get verificationTitle => _verificationTitle;
  get verificationTool => _verificationTool;

  set password(val) {
    _password = val;
    notifyListeners();
  }

  set userName(val) {
    _userName = val;
    setUserName(val);
    notifyListeners();
  }

  set isAuthenticated(val) {
    _isAuthenticated = val;
    setLoginStatus(val);
    notifyListeners();
  }

  set verificationTitle(val) {
    _verificationTitle = val;
    notifyListeners();
  }

  set signVal(val) {
    _signVal = val;
    notifyListeners();
  }

  set verificationTool(val) {
    _verificationTool = val;
    notifyListeners();
  }

  void notifyToast({message}) {
    Toast.show(message, duration: Toast.lengthLong, gravity: Toast.bottom);
  }

  void notifyToastDanger({message}) {
    Toast.show(message,
        duration: Toast.lengthLong,
        gravity: Toast.bottom,
        backgroundColor: Colors.red,
        webTexColor: Colors.white);
  }

  void notifyToastSuccess(message) {
    Toast.show(message,
        duration: Toast.center,
        gravity: Toast.bottom,
        backgroundColor: Colors.green,
        webTexColor: Colors.white);
  }

  // Future<bool> isUserSignedIn() async {
  //   final result = await Amplify.Auth.fetchAuthSession();
  //   return result.isSignedIn;
  // }

  // Future<AuthUser> getCurrentUser() async {
  //   final user = await Amplify.Auth.getCurrentUser();
  //   return user;
  // }

  Future<void> setLoginStatus(val) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.setBool("loginStatus", val);
  }

  Future<bool> getLoginStatus() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    var value = sharedPreference.getBool("loginStatus") ?? false;
    return Future<bool>.value(value);
  }

  Future<void> setUserName(val) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.setBool("user", val);
  }

  Future<String> getUserName(val) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    var value = sharedPreference.getString("user") ?? '';
    return Future<String>.value(value);
  }
}
