import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import 'package:tracking/config/styles.dart';
import 'package:tracking/pages/home_page.dart';
import 'package:tracking/services/auth-provider.dart';
import 'package:tracking/auth/sign-in.dart';

class RecoverPasswordPage extends StatefulWidget {
  const RecoverPasswordPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _RecoverPasswordPageState createState() => _RecoverPasswordPageState();
}

class _RecoverPasswordPageState extends State<RecoverPasswordPage> {
  // Variable
  AppConfig config = AppConfig();
  TextEditingController usernameCtl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  bool isCancelLoading = false;
  bool isChangeLoading = false;

  @override
  void initState() {
    super.initState();
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
      controller: usernameCtl,
      keyboardType: TextInputType.url,
      cursorColor: config.cursorColor,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        hintText: 'https:your_server_url.domain',
        hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
        enabledBorder: config.enabledBorder,
        focusedBorder: config.focusedBorder,
        errorBorder: config.errorBorder,
        filled: config.filled,
        fillColor: config.fillColor,
      ),
    );
    final emailField = TextFormField(
      controller: emailCtrl,
      cursorColor: config.cursorColor,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        hintText: "Email",
        hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
        prefixIcon: Icon(
          // Based on passwordVisible state choose the icon
          Icons.email,
          color: Colors.grey,
          size: 30,
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
                      'Email you used for Signing In',
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
                child: emailField,
              ),
              config.v_gap_md,
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
                      color: config.primary,
                      child: MaterialButton(
                        // minWidth: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignInPage()));
                        },
                        shape: config.rounded_lg,
                        child: isCancelLoading
                            ? const SizedBox(
                                height: 25,
                                width: 25,
                                // ignore: unnecessary_const
                                child: const CircularProgressIndicator(
                                    backgroundColor: Colors.grey,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                    strokeWidth: 3))
                            : Text(
                                'Cancel',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: config.primary,
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
                      color: config.primary,
                      child: MaterialButton(
                        // minWidth: MediaQuery.of(context).size.width,
                        color: config.primary,
                        onPressed: () {
                          changePassword();
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: isChangeLoading
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
              config.v_gap_md,
            ],
          ),
        ),
      ),
    );
  }

  void changePassword() async {
    setState(() {
      isChangeLoading = true;
    });
    if (usernameCtl.text.length > 0 && emailCtrl.text.length > 0) {
    } else {
      setState(() {
        isChangeLoading = false;
      });
      AuthenticateProviderPage.of(context, listen: false)
          .notifyToastDanger(message: "Error, please fill in all inputs!");
    }
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomePage()));
    setState(() {});
  }
}
