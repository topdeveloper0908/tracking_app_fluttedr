// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'package:tracking/config/styles.dart';

// ignore: use_key_in_widget_constructors
class PushSettingPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _PushSettingPageState createState() => _PushSettingPageState();
}

// ignore: use_key_in_widget_constructors
class _PushSettingPageState extends State<PushSettingPage> {
  AppConfig config = AppConfig();
  bool push = false;
  bool showLabel = false;
  bool info = false;
  bool incomingMsg = false;
  bool rule = false;
  bool task = false;
  bool status = false;
  bool service = false;
  BoxDecoration item_decoration = BoxDecoration(
      border: Border(
    bottom: BorderSide(width: 1, color: Colors.grey),
  ));
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
          title: const Text('Notifications'),
          backgroundColor: config.primary,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Push notifications',
                      style: TextStyle(fontSize: config.f_md),
                    ),
                    FlutterSwitch(
                      width: 60.0,
                      height: 30.0,
                      valueFontSize: 20.0,
                      toggleSize: 28.0,
                      value: push,
                      borderRadius: 30.0,
                      padding: 5.0,
                      showOnOff: false,
                      activeColor: config.primary,
                      onToggle: (val) {
                        setState(() {
                          push = val;
                        });
                      },
                    )
                  ],
                )),
            Container(
                decoration: const BoxDecoration(
                    border: Border(
                  top: BorderSide(width: 1, color: Colors.grey),
                  bottom: BorderSide(width: 1, color: Colors.grey),
                )),
                child: Row(
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                          border: Border(
                              left: BorderSide(width: 1, color: Colors.black))),
                      child: Text(''),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                              decoration: item_decoration,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Incoming messages',
                                    style: TextStyle(fontSize: config.f_md),
                                  ),
                                  FlutterSwitch(
                                    width: 60.0,
                                    height: 30.0,
                                    valueFontSize: 20.0,
                                    toggleSize: 28.0,
                                    value: incomingMsg,
                                    borderRadius: 30.0,
                                    padding: 5.0,
                                    showOnOff: false,
                                    activeColor: config.primary,
                                    onToggle: (val) {
                                      setState(() {
                                        incomingMsg = val;
                                      });
                                    },
                                  )
                                ],
                              )),
                          Container(
                              decoration: item_decoration,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Rule Notifications',
                                    style: TextStyle(fontSize: config.f_md),
                                  ),
                                  FlutterSwitch(
                                    width: 60.0,
                                    height: 30.0,
                                    valueFontSize: 20.0,
                                    toggleSize: 28.0,
                                    value: rule,
                                    borderRadius: 30.0,
                                    padding: 5.0,
                                    showOnOff: false,
                                    activeColor: config.primary,
                                    onToggle: (val) {
                                      setState(() {
                                        rule = val;
                                      });
                                    },
                                  )
                                ],
                              )),
                          Container(
                              decoration: item_decoration,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Status changes',
                                    style: TextStyle(fontSize: config.f_md),
                                  ),
                                  FlutterSwitch(
                                    width: 60.0,
                                    height: 30.0,
                                    valueFontSize: 20.0,
                                    toggleSize: 28.0,
                                    value: status,
                                    borderRadius: 30.0,
                                    padding: 5.0,
                                    showOnOff: false,
                                    activeColor: config.primary,
                                    onToggle: (val) {
                                      setState(() {
                                        status = val;
                                      });
                                    },
                                  )
                                ],
                              )),
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Service notifications',
                                    style: TextStyle(fontSize: config.f_md),
                                  ),
                                  FlutterSwitch(
                                    width: 60.0,
                                    height: 30.0,
                                    valueFontSize: 20.0,
                                    toggleSize: 28.0,
                                    value: service,
                                    borderRadius: 30.0,
                                    padding: 5.0,
                                    showOnOff: false,
                                    activeColor: config.primary,
                                    onToggle: (val) {
                                      setState(() {
                                        service = val;
                                      });
                                    },
                                  )
                                ],
                              )),
                        ],
                      ),
                    )
                  ],
                ))
          ],
        ));
  }
}
