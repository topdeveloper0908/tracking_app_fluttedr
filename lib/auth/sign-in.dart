import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:provider/provider.dart';

import 'package:tracking/auth/recover-password.dart';
import 'package:tracking/store/index.dart';
import 'package:tracking/pages/home_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  // SignInPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  // final String title;

  @override
  // ignore: library_private_types_in_public_api
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool status = false;
  TextEditingController usernameCtl = TextEditingController();
  TextEditingController passwordCtl = TextEditingController();
  TextStyle style = const TextStyle(fontSize: 18);
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
    double statusBarHeight = MediaQuery.of(context).padding.top;
    final usernameField = TextFormField(
      style: style,
      controller: usernameCtl,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        hintText: "Email",
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
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
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.grey)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.green)),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.redAccent)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
    final passwordField = TextFormField(
      obscureText: _passwordVisible,
      style: style,
      controller: passwordCtl,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        hintText: "Password",
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
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
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.grey)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.green)),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.redAccent)),
        filled: false,
        fillColor: Colors.white,
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: const Text(
                      'Welcome to',
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 35,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: const Text(
                      'Assest Track',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.w400,
                          color: Colors.green),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.07),
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
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: usernameField,
                  ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: passwordField,
                  ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
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
                              child: const Text(
                                'Recover Password',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 16),
                              )))),
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 45,
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(50.0),
                      // color: Color(0xff01A0C7),
                      color: Colors.green,
                      child: MaterialButton(
                          // minWidth: MediaQuery.of(context).size.width,
                          color: Colors.green,
                          onPressed: () {
                            goToHomepage();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          child: status
                              ? const SizedBox(
                                  height: 25,
                                  width: 25,
                                  // ignore: unnecessary_const
                                  child: const CircularProgressIndicator(
                                      backgroundColor: Colors.grey,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
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
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      )),
    );
  }

  void goToHomepage() async {
    setState(() {
      status = true;
    });
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
    setState(() {
      status = false;
    });
  }
}
