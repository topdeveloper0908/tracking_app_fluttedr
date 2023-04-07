// ignore_for_file: unused_local_variable, prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import 'package:tracking/config/styles.dart';
import 'package:tracking/component/radio-option.dart';

// ignore: use_key_in_widget_constructors
class TrackerSettingPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _TrackerSettingPageState createState() => _TrackerSettingPageState();
}

// ignore: use_key_in_widget_constructors
class _TrackerSettingPageState extends State<TrackerSettingPage> {
  AppConfig config = AppConfig();
  TextEditingController groupNamectl = TextEditingController();
  TextEditingController timeGPSctl = TextEditingController();
  TextEditingController distanceGPSctl = TextEditingController();
  TextEditingController minsctl = TextEditingController();
  TextEditingController speedctl = TextEditingController();
  bool status = false;
  bool turnings = false;
  bool igitionState = false;
  String gpsUpdateStatus = '';
  double _currentLBSValue = 3;
  final List<String> groupItems = [
    'Main Group',
    'Group Entertain',
    'PARC ROULANT',
  ];
  String player = 'Group Entertain';

  TextStyle cardTitlestyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 24,
  );

  ValueChanged<String?> gpsUpdateHandler() {
    return (value) => setState(() {
          gpsUpdateStatus = value!;
        });
  }

  @override
  // ignore: must_call_super
  void initState() {
    gpsUpdateStatus = 'time';
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final groupNameField = TextFormField(
      controller: groupNamectl,
      cursorColor: config.primary,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        hintText: "New Group",
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
        enabledBorder: config.enabledBorder,
        focusedBorder: config.focusedBorder,
        errorBorder: config.errorBorder,
        filled: true,
        fillColor: Colors.white,
      ),
    );
    final timeField = TextFormField(
      controller: timeGPSctl,
      keyboardType: TextInputType.number,
      enabled: gpsUpdateStatus == 'time' ? true : false,
      cursorColor: config.primary,
      decoration: InputDecoration(
        enabledBorder: config.u_enabledBorder,
        focusedBorder: config.u_focusedBorder,
        suffixIcon: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Text('seconds',
              style: TextStyle(
                  fontSize: 18,
                  color:
                      gpsUpdateStatus == 'time' ? Colors.black : Colors.grey)),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        hintText: gpsUpdateStatus == 'time' ? '30' : '',
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
        filled: true,
        fillColor: Colors.white,
      ),
    );
    ;
    final distanceField = TextFormField(
      controller: timeGPSctl,
      keyboardType: TextInputType.number,
      enabled: gpsUpdateStatus == 'distance' ? true : false,
      cursorColor: config.primary,
      decoration: InputDecoration(
        enabledBorder: config.u_enabledBorder,
        focusedBorder: config.u_focusedBorder,
        suffixIcon: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Text('meters',
              style: TextStyle(
                  fontSize: 18,
                  color: gpsUpdateStatus == 'distance'
                      ? Colors.black
                      : Colors.grey)),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        hintText: gpsUpdateStatus == 'distance' ? '30' : '',
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
        filled: true,
        fillColor: Colors.white,
      ),
    );
    final degreeField = TextFormField(
      controller: timeGPSctl,
      keyboardType: TextInputType.number,
      cursorColor: config.primary,
      decoration: InputDecoration(
        enabledBorder: config.u_enabledBorder,
        focusedBorder: config.u_focusedBorder,
        suffixIcon: Container(
            width: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'degrees',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
                IconButton(
                  onPressed: () => {},
                  icon: Icon(
                    Icons.close_outlined,
                  ),
                  focusColor: config.primary,
                  hoverColor: config.primary,
                  highlightColor: Colors.white,
                  splashColor: Colors.white,
                )
              ],
            )),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        hintText: '10',
        hintStyle: const TextStyle(color: Colors.black, fontSize: 18),
        filled: true,
        fillColor: Colors.white,
      ),
    );

    final minsField = TextFormField(
      controller: minsctl,
      keyboardType: TextInputType.number,
      cursorColor: config.primary,
      decoration: InputDecoration(
        enabledBorder: config.u_enabledBorder,
        focusedBorder: config.u_focusedBorder,
        suffixIcon: Container(
            width: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'minutes',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
                IconButton(
                  onPressed: () => {},
                  icon: Icon(Icons.close_outlined),
                  focusColor: config.primary,
                  hoverColor: config.primary,
                  highlightColor: Colors.white,
                  splashColor: Colors.white,
                )
              ],
            )),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        hintText: '10',
        hintStyle: const TextStyle(color: Colors.black, fontSize: 18),
        filled: true,
        fillColor: Colors.white,
      ),
    );

    final speedField = TextFormField(
      controller: speedctl,
      keyboardType: TextInputType.number,
      cursorColor: config.primary,
      decoration: InputDecoration(
        enabledBorder: config.u_enabledBorder,
        focusedBorder: config.u_focusedBorder,
        focusColor: config.primary,
        suffixIcon: Container(
            width: 120,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Km/h',
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                ),
                IconButton(
                  onPressed: () => {},
                  icon: Icon(Icons.close_outlined),
                  focusColor: config.primary,
                  hoverColor: config.primary,
                  highlightColor: Colors.white,
                  splashColor: Colors.white,
                )
              ],
            )),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        hintText: '3',
        hintStyle: const TextStyle(color: Colors.black, fontSize: 18),
        filled: true,
        fillColor: Colors.white,
      ),
    );
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tracker Setting'),
          backgroundColor: config.primary,
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Column(
            children: [
              Card(
                  shape: config.rounded_xs,
                  elevation: 2,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text('Group', style: cardTitlestyle),
                        config.v_gap_md,
                        Row(
                          children: [
                            Expanded(
                              child: DropdownButtonHideUnderline(
                                  child: DropdownButton2(
                                buttonElevation: 2,
                                style: const TextStyle(
                                  color: Colors.white, //<-- SEE HERE
                                  fontSize: 20,
                                ),
                                iconEnabledColor: Colors.white,
                                dropdownDecoration:
                                    BoxDecoration(color: config.primary),
                                buttonDecoration: BoxDecoration(
                                  color: config.primary,
                                ),
                                buttonPadding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 8),
                                items: groupItems
                                    .map((item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(item),
                                        ))
                                    .toList(),
                                value: player,
                                onChanged: (value) {
                                  setState(() {
                                    player = value!;
                                  });
                                },
                                buttonHeight: 45,
                                buttonWidth: 60,
                                itemHeight: 40,
                              )),
                            )
                          ],
                        ),
                        config.v_gap_md,
                        Text(
                          'If you track numerou objects you can divide them into different groups for your convinence',
                          style: TextStyle(fontSize: 17, color: Colors.grey),
                        ),
                        config.v_gap_md,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Container(
                              child: groupNameField,
                            )),
                            SizedBox(
                              width: 20,
                            ),
                            MaterialButton(
                                // minWidth: MediaQuery.of(context).size.width,
                                color: config.primary,
                                onPressed: () {},
                                shape: config.rounded_xs,
                                padding: EdgeInsets.symmetric(vertical: 13.5),
                                child: status
                                    ? const SizedBox(
                                        height: 25,
                                        width: 25,
                                        // ignore: unnecessary_const
                                        child: const CircularProgressIndicator(
                                            backgroundColor: Colors.grey,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white),
                                            strokeWidth: 3))
                                    : const SizedBox(
                                        child: Text(
                                          'Save',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ))
                          ],
                        )
                      ],
                    ),
                  )),
              config.v_gap_xs,
              Card(
                  shape: config.rounded_xs,
                  elevation: 2,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text('Tracking Mode', style: cardTitlestyle),
                        config.v_gap_md,
                        const Text('Update GPS Location',
                            style: TextStyle(
                              fontSize: 20,
                            )),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 100,
                              child: MyRadioOption<String>(
                                value: 'time',
                                groupValue: gpsUpdateStatus,
                                onChanged: gpsUpdateHandler(),
                                label: '1',
                                text: 'Every',
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: timeField,
                            )
                          ],
                        ),
                        config.v_gap_sm,
                        Row(children: [
                          Container(
                            width: 100,
                            child: MyRadioOption<String>(
                              value: 'distance',
                              groupValue: gpsUpdateStatus,
                              onChanged: gpsUpdateHandler(),
                              label: '2',
                              text: 'Every',
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: distanceField,
                          )
                        ]),
                        config.v_gap_md,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FlutterSwitch(
                              width: 60.0,
                              height: 30.0,
                              valueFontSize: 20.0,
                              toggleSize: 28.0,
                              value: turnings,
                              borderRadius: 30.0,
                              padding: 5.0,
                              showOnOff: false,
                              activeColor: config.primary,
                              onToggle: (val) {
                                setState(() {
                                  turnings = val;
                                });
                              },
                            ),
                            Container(
                                height: 45,
                                width: 180,
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                child: Center(
                                  child: Text(
                                    'Include turnings',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ))
                          ],
                        ),
                        config.v_gap_sm,
                        degreeField
                      ],
                    ),
                  )),
              config.v_gap_xs,
              Card(
                  shape: config.rounded_xs,
                  elevation: 2,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text('LBS detection radius', style: cardTitlestyle),
                        config.v_gap_md,
                        Text(
                          'Set tracker detection radius in LBS tracking mode.',
                          style: TextStyle(fontSize: 17, color: Colors.grey),
                        ),
                        Text(
                          'Location data with an error more than specified above will be ignored',
                          style: TextStyle(fontSize: 17, color: Colors.grey),
                        ),
                        config.v_gap_md,
                        Container(
                          margin: EdgeInsets.only(left: 22),
                          child: Text((_currentLBSValue.toString() + ' Km'),
                              style: TextStyle(
                                fontSize: 18,
                              )),
                        ),
                        Slider(
                          thumbColor: config.primary,
                          activeColor: config.primary,
                          inactiveColor: Color.fromARGB(99, 179, 255, 249),
                          value: _currentLBSValue,
                          max: 5,
                          divisions: 10,
                          onChanged: (double value) {
                            setState(() {
                              _currentLBSValue = value;
                            });
                          },
                        ),
                        config.v_gap_xs,
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(
                                        top: BorderSide(
                                            width: 1, color: Colors.black))),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 15,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            left: BorderSide(
                                                width: 1,
                                                color: Colors.black))),
                                  ),
                                  Container(
                                    height: 15,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            left: BorderSide(
                                                width: 1,
                                                color: Colors.black))),
                                  ),
                                  Container(
                                    height: 15,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            left: BorderSide(
                                                width: 1,
                                                color: Colors.black))),
                                  ),
                                ],
                              ),
                              config.v_gap_xs,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '0 km',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  Text(
                                    '2.5 km',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  Text(
                                    '5 km',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        config.v_gap_md,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MaterialButton(
                                // minWidth: MediaQuery.of(context).size.width,
                                color: config.primary,
                                onPressed: () {},
                                shape: config.rounded_xs,
                                padding: EdgeInsets.symmetric(vertical: 13.5),
                                child: status
                                    ? const SizedBox(
                                        height: 25,
                                        width: 25,
                                        // ignore: unnecessary_const
                                        child: const CircularProgressIndicator(
                                            backgroundColor: Colors.grey,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white),
                                            strokeWidth: 3))
                                    : const SizedBox(
                                        child: Text(
                                          'Save',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ))
                          ],
                        )
                      ],
                    ),
                  )),
              config.v_gap_xs,
              Card(
                  shape: config.rounded_xs,
                  elevation: 2,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        Text('Parking Detection', style: cardTitlestyle),
                        const SizedBox(
                          height: 25,
                        ),
                        const Text('Min idle Detection',
                            style: TextStyle(
                              fontSize: 18,
                            )),
                        config.v_gap_sm,
                        minsField,
                        const SizedBox(
                          height: 40,
                        ),
                        const Text('Max Idle Speed',
                            style: TextStyle(
                              fontSize: 18,
                            )),
                        config.v_gap_sm,
                        speedField,
                        config.v_gap_md,
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FlutterSwitch(
                              width: 60.0,
                              height: 30.0,
                              valueFontSize: 20.0,
                              toggleSize: 28.0,
                              value: igitionState,
                              borderRadius: 30.0,
                              padding: 5.0,
                              showOnOff: false,
                              activeColor: config.primary,
                              onToggle: (val) {
                                setState(() {
                                  igitionState = val;
                                });
                              },
                            ),
                            Container(
                                height: 45,
                                margin: const EdgeInsets.only(right: 10),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                child: Center(
                                  child: Text(
                                    'Consider igition state',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ))
                          ],
                        ),
                        config.v_gap_sm,
                        InkWell(
                            onTap: () => {},
                            splashColor: Colors.white,
                            hoverColor: Colors.white,
                            focusColor: Colors.white,
                            highlightColor: Colors.white,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 1, color: config.primary))),
                              child: Text(
                                'Default Settings',
                                style: TextStyle(
                                    fontSize: 18, color: config.primary),
                              ),
                            )),
                        config.v_gap_md,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MaterialButton(
                                // minWidth: MediaQuery.of(context).size.width,
                                color: config.primary,
                                onPressed: () {},
                                padding: EdgeInsets.symmetric(vertical: 13.5),
                                shape: config.rounded_xs,
                                child: status
                                    ? const SizedBox(
                                        height: 25,
                                        width: 25,
                                        // ignore: unnecessary_const
                                        child: const CircularProgressIndicator(
                                            backgroundColor: Colors.grey,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    Colors.white),
                                            strokeWidth: 3))
                                    : const SizedBox(
                                        child: Text(
                                          'Save',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ))
                          ],
                        )
                      ],
                    ),
                  )),
              config.v_gap_xs,
            ],
          ),
        )));
  }
}
