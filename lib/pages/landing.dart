import 'package:flutter/material.dart';

import 'package:tracking/auth/sign-in.dart';

// ignore: use_key_in_widget_constructors
class LandingPage extends StatefulWidget {
  // LandingPage({Key key, this.title}) : super(key: key);

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
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: const Text(
                          'Tracking',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                      ),
                      Container(
                        child: const Text(
                          'Asset',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(20.0),
                          // color: Color(0xff01A0C7),
                          color: Colors.black,
                          child: MaterialButton(
                            // minWidth: MediaQuery.of(context).size.width,
                            onPressed: () {
                              //-------- Go To SignIn Page ----
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignInPage()),
                              );
                            },
                            child: const Text(
                              'Sign In',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(20.0),
                          // color: Color(0xff01A0C7),
                          color: Colors.black,
                          child: MaterialButton(
                            // minWidth: MediaQuery.of(context).size.width,
                            onPressed: () {
                              //-------- Go To SignIn Page ----
                            },
                            child: const Text(
                              'Sign Up',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
