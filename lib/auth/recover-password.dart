import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:provider/provider.dart';

import 'package:tracking/pages/home_page.dart';
import 'package:tracking/auth/sign-in.dart';

class RecoverPasswordPage extends StatefulWidget {
  const RecoverPasswordPage({super.key});

  // RecoverPasswordPage({Key key, this.title}) : super(key: key);

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
  _RecoverPasswordPageState createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  bool status = false;

  TextEditingController usernameCtl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
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
      keyboardType: TextInputType.url,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        hintText: 'https:your_server_url.domain',
        hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.grey)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.green)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.redAccent)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
    final emailField = TextFormField(
      style: style,
      controller: emailCtrl,
      decoration: const InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        hintText: "Email",
        hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
        prefixIcon: Icon(
          // Based on passwordVisible state choose the icon
          Icons.email,
          color: Colors.grey,
          size: 30,
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.grey)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.green)),
        errorBorder: OutlineInputBorder(
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
                      'Email you used for Signing In',
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
                    child: emailField,
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
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: 45,
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(50.0),
                      // color: Color(0xff01A0C7),
                      color: Colors.green,
                      child: MaterialButton(
                        // minWidth: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignInPage()));
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
                            : const Text(
                                'Cancel',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                      ),
                    ),
                  ),
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
                                        Color.fromARGB(255, 27, 13, 13)),
                                    strokeWidth: 3))
                            : const Text(
                                'Change',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                      ),
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
