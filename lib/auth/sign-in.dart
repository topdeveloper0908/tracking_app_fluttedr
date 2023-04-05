import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'package:tracking/config/styles.dart';
import 'package:tracking/auth/recover-password.dart';
import 'package:tracking/services/auth-provider.dart';
import 'package:tracking/pages/home_page.dart';

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
                          goToHomepage();
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
                            : const SizedBox(
                                child: Text(
                                  'Sign In',
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

  void goToHomepage() async {
    setState(() {
      isLoading = true;
    });
    if (usernameCtl.text.length > 0 && passwordCtl.text.length > 0) {
      try {
        final result = true;
        setState(() {
          isLoading = false;
        });
        AuthenticateProviderPage.of(context, listen: false).isAuthenticated =
            true;
        AuthenticateProviderPage.of(context, listen: false).userName =
            usernameCtl.text;
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
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
}
