// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:tracking/config/styles.dart';
import 'package:tracking/pages/push-settings.dart';

import 'package:tracking/pages/push-settings.dart';

// ignore: use_key_in_widget_constructors
class SettingPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  SettingPageState createState() => SettingPageState();
}

// ignore: use_key_in_widget_constructors
class SettingPageState extends State<SettingPage> {
  AppConfig config = AppConfig();
  bool showLabel = false;
  @override
  // ignore: must_call_super
  void initState() {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          backgroundColor: config.primary,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
                decoration: const BoxDecoration(
                    border: Border(
                  top: BorderSide(width: 1, color: Colors.grey),
                  bottom: BorderSide(width: 1, color: Colors.grey),
                )),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1, color: Colors.grey),
                              )),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Push Notification',
                                    style: TextStyle(fontSize: config.f_md),
                                  ),
                                  ElevatedButtonTheme(
                                      data: ElevatedButtonThemeData(
                                        style: ButtonStyle(
                                          elevation:
                                              MaterialStateProperty.all(0),
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  Colors.white),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  Colors.white),
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
                                                      PushSettingPage()));
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              'Enable',
                                              style: TextStyle(
                                                  color: config.primary,
                                                  fontSize: config.f_md),
                                            ), // <-- Text
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Icon(
                                              // <-- Icon
                                              Icons.keyboard_arrow_right,
                                              size: 24.0,
                                              color: Colors.grey,
                                            ),
                                          ],
                                        ),
                                      )),
                                ],
                              )),
                          Container(
                              decoration: const BoxDecoration(
                                  border: Border(
                                bottom:
                                    BorderSide(width: 1, color: Colors.grey),
                              )),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Labels on Map',
                                    style: TextStyle(fontSize: config.f_md),
                                  ),
                                  FlutterSwitch(
                                    width: 60.0,
                                    height: 30.0,
                                    valueFontSize: 20.0,
                                    toggleSize: 28.0,
                                    value: showLabel,
                                    borderRadius: 15,
                                    padding: 4.0,
                                    showOnOff: false,
                                    activeColor: config.primary,
                                    onToggle: (val) {
                                      setState(() {
                                        showLabel = val;
                                      });
                                    },
                                  )
                                ],
                              )),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 14),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Version',
                                    style: TextStyle(fontSize: config.f_md),
                                  ),
                                  Text(
                                    config.version,
                                    style: TextStyle(fontSize: config.f_md),
                                  ),
                                ],
                              ))
                        ],
                      ),
                    )
                  ],
                ))
          ],
        ));
  }
}
