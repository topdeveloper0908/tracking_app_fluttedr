import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'package:tracking/config/styles.dart';
import 'package:tracking/config/constant.dart';
import 'package:tracking/auth/recover-password.dart';
import 'package:tracking/services/auth-provider.dart';
import 'package:tracking/pages/home_page.dart';
import 'package:tracking/services/track-provider.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  // Variables
  AppConfig config = AppConfig();
  TextEditingController usernameCtl = TextEditingController();
  TextEditingController passwordCtl = TextEditingController();
  bool isLoading = false;
  bool _passwordVisible = true;

  @override
  void initState() {
    super.initState();
    // state = Provider.of<AppState>(context, listen: false);
    _passwordVisible = true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> setToken(val) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.setString("token", val);
  }

  Future<void> getGroups(String token) async {
    var uri = Uri.parse('${ApiURL.GROUPS_URL}');
    var headers = {'Content-Type': 'application/json', 'X-Auth-Token': token};
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      await Provider.of<TrackProvider>(context, listen: false)
          .setGroups(response.body.toString());
    }
  }

  Future<void> getTracks(String token) async {
    var uri = Uri.parse('${ApiURL.TRACKERS_URL}');
    var headers = {'Content-Type': 'application/json', 'X-Auth-Token': token};
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      await Provider.of<TrackProvider>(context, listen: false)
          .setTracks(response.body.toString());
    }
  }

  Future<void> _handlelogin() async {
    setState(() {
      isLoading = true;
    });
    if (usernameCtl.text.length > 0 && passwordCtl.text.length > 0) {
      setState(() {
        isLoading = true;
      });
      try {
        var uri = Uri.parse('${ApiURL.LOGIN_URL}');
        var headers = {'Content-Type': 'application/json'};
        var body = {
          'username': usernameCtl.text,
          'password': passwordCtl.text,
        };
        var response =
            await http.post(uri, headers: headers, body: jsonEncode(body));
        if (response.statusCode == 200) {
          setToken(response.headers['x-auth-token']);
          await getGroups(response.headers['x-auth-token'] ?? '');
          await getTracks(response.headers['x-auth-token'] ?? '');
          setState(() {
            isLoading = false;
          });
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const HomePage()));
        } else {
          AuthenticateProviderPage.of(context, listen: false)
              .notifyToastDanger(message: "Invalid User");
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        AuthenticateProviderPage.of(context, listen: false)
            .notifyToastDanger(message: "Sign in error. please try again.");
      }
    } else {
      setState(() {
        isLoading = false;
      });
      if (usernameCtl.text.length > 0) {
        AuthenticateProviderPage.of(context, listen: false)
            .notifyToastDanger(message: "Error, Password is required!");
      } else {
        AuthenticateProviderPage.of(context, listen: false)
            .notifyToastDanger(message: "Error, email is required!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final usernameField = TextFormField(
      controller: usernameCtl,
      keyboardType: TextInputType.emailAddress,
      cursorColor: config.cursorColor,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        hintText: "Email",
        hintStyle: config.hintStyle,
        prefixIcon: IconButton(
          icon: const Icon(
            // Based on passwordVisible state choose the icon
            Icons.person,
            color: Colors.grey,
            size: 30,
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
        enabledBorder: config.enabledBorder,
        focusedBorder: config.focusedBorder,
        errorBorder: config.errorBorder,
        filled: config.filled,
        fillColor: config.fillColor,
      ),
    );
    final passwordField = TextFormField(
      obscureText: _passwordVisible,
      controller: passwordCtl,
      cursorColor: config.cursorColor,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        hintText: "Password",
        hintStyle: config.hintStyle,
        prefixIcon: IconButton(
          icon: const Icon(
            // Based on passwordVisible state choose the icon
            Icons.key,
            color: Colors.grey,
            size: 30,
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
            size: 24,
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
        enabledBorder: config.enabledBorder,
        focusedBorder: config.focusedBorder,
        errorBorder: config.errorBorder,
        filled: config.filled,
        fillColor: config.fillColor,
      ),
    );
    ToastContext().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: SingleChildScrollView(
        child: Column(
          children: [
            // ignore: avoid_unnecessary_containers
            Image.asset(
              config.logoUrl,
              width: config.logoWitdh,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05),
                  child: const Text(
                    'Login with your existing account',
                    style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.normal,
                        fontSize: 16),
                  ),
                )
              ],
            ),
            config.v_gap_md,
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: usernameField,
            ),
            config.v_gap_md,
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: passwordField,
            ),
            config.v_gap_md,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 20),
                    child: ElevatedButtonTheme(
                        data: ElevatedButtonThemeData(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all(0),
                            overlayColor:
                                MaterialStateProperty.all(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white),
                          ),
                        ),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.white,
                              shadowColor: Colors.white,
                              padding: const EdgeInsets.all(0),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RecoverPasswordPage()));
                            },
                            child: Text(
                              'Recover Password',
                              style: TextStyle(
                                  color: config.primary,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18),
                            )))),
                Container(
                  margin: const EdgeInsets.only(right: 20),
                  width: MediaQuery.of(context).size.width * 0.3,
                  height: 45,
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(50.0),
                    // color: Color(0xff01A0C7),
                    color: config.primary,
                    child: MaterialButton(
                        // minWidth: MediaQuery.of(context).size.width,
                        color: config.primary,
                        onPressed: () {
                          _handlelogin();
                          // _handleLogin();
                        },
                        shape: config.rounded_xs,
                        child: isLoading
                            ? const SizedBox(
                                height: 25,
                                width: 25,
                                // ignore: unnecessary_const
                                child: const CircularProgressIndicator(
                                    backgroundColor: Colors.white,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.grey),
                                    strokeWidth: 3))
                            : SizedBox(
                                child: Text(
                                  'signin'.tr,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.normal),
                                ),
                              )),
                  ),
                ),
              ],
            ),
            config.v_gap_md,
          ],
        ),
      )),
    );
  }
}
