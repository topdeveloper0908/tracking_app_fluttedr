// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:tracking/config/styles.dart';
import 'package:tracking/pages/push-settings.dart';
import 'package:tracking/services/change-language.dart';
import 'package:tracking/services/storage.dart';

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
  final List<String> countries = [
    'en',
    'fr',
  ];

  String? country = Get.locale.toString();
  @override
  // ignore: must_call_super
  void initState() {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final MyLanguageController _controller = Get.find<MyLanguageController>();
    return Scaffold(
        appBar: AppBar(
          title: Text('settings.title'.tr),
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
                                    'settings.pushTitle'.tr,
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
                                              'settings.pushEnable'.tr,
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
                                    'settings.label'.tr,
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
                                    'settings.language'.tr,
                                    style: TextStyle(fontSize: config.f_md),
                                  ),
                                  DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                    buttonElevation: 2,
                                    style: const TextStyle(
                                      color: Colors.black, //<-- SEE HERE
                                      fontSize: 20,
                                    ),
                                    iconEnabledColor: Colors.black,
                                    // dropdownDecoration:
                                    //     BoxDecoration(color: config.primary),
                                    // buttonDecoration: BoxDecoration(
                                    //   color: config.primary,
                                    // ),
                                    buttonPadding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 0),
                                    items: countries
                                        .map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: Image(
                                                  width: 40,
                                                  image: AssetImage(
                                                      'assets/images/$item.png')),
                                            ))
                                        .toList(),
                                    value: country,
                                    onChanged: (value) {
                                      setState(() {
                                        country = value!;
                                        if (value == 'en') {
                                          _controller.changeLanuage('en');
                                        } else {
                                          _controller.changeLanuage('fr');
                                        }
                                      });
                                    },
                                    buttonHeight: 30,
                                    buttonWidth: 65,
                                    itemHeight: 30,
                                    itemPadding:
                                        EdgeInsets.symmetric(horizontal: 10),
                                  ))
                                  // FlutterSwitch(
                                  //   width: 60.0,
                                  //   height: 30.0,
                                  //   valueFontSize: 20.0,
                                  //   toggleSize: 28.0,
                                  //   value: english,
                                  //   borderRadius: 15,
                                  //   padding: 4.0,
                                  //   showOnOff: false,
                                  //   activeColor: config.primary,
                                  //   onToggle: (val) {
                                  //     setState(() {

                                  //     });
                                  //   },
                                  // )
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
                                    'settings.version'.tr,
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
