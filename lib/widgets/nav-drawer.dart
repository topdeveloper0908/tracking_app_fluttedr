// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:tracking/config/styles.dart';
import 'package:tracking/pages/single-assest.dart';
import 'package:tracking/pages/account.dart';
import 'package:tracking/pages/support.dart';
import 'package:tracking/pages/settings.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _NavDrawerState createState() => _NavDrawerState();
}

// ignore: use_key_in_widget_constructors
class _NavDrawerState extends State<NavDrawer> {
  bool _filterAll = false;
  bool _filterOnline = false;
  bool _filterOffline = false;
  bool _filterGPS = false;
  bool _filterLost = false;
  bool _filterAwating = false;
  TextEditingController searchCtl = TextEditingController();
  AppConfig config = AppConfig();

  @override
  Widget build(BuildContext context) {
    final searchField = TextFormField(
      controller: searchCtl,
      keyboardType: TextInputType.emailAddress,
      cursorColor: config.cursorColor,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        hintText: "Search...",
        hintStyle: config.hintStyle,
        enabledBorder: config.enabledBorder,
        focusedBorder: config.focusedBorder,
        errorBorder: config.errorBorder,
        filled: config.filled,
        fillColor: config.fillColor,
      ),
    );
    return Container(
        width: 250,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: Image(image: AssetImage(config.logoUrl)),
              ),
              SizedBox(
                height: 10,
              ),
              ExpansionTile(
                  title: const Text(
                    "Filters",
                  ), //add icon
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: searchField,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(width: 1, color: Colors.grey),
                                  bottom:
                                      BorderSide(width: 1, color: Colors.grey),
                                  left:
                                      BorderSide(width: 1, color: Colors.grey),
                                  right:
                                      BorderSide(width: 1, color: Colors.grey),
                                ),
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              children: [
                                Container(
                                    height: 40,
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          checkColor: Colors.white,
                                          activeColor: config.primary,
                                          value: _filterAll,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              _filterAll = value!;
                                              _filterOnline = value!;
                                              _filterOffline = value!;
                                              _filterGPS = value!;
                                              _filterLost = value!;
                                              _filterAwating = value!;
                                            });
                                          },
                                        ),
                                        Text('All')
                                      ],
                                    )),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                      border: Border(
                                          bottom: BorderSide(
                                              width: 1, color: Colors.grey))),
                                ),
                                Container(
                                    height: 35,
                                    padding: EdgeInsets.zero,
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          checkColor: Colors.white,
                                          activeColor: config.primary,
                                          value: _filterOnline,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              _filterOnline = value!;
                                            });
                                          },
                                        ),
                                        Expanded(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Text('Online'),
                                            ),
                                            const IconTheme(
                                              data: IconThemeData(
                                                color: Colors
                                                    .green, // set the color of the icon
                                                size:
                                                    16.0, // set the size of the icon
                                              ),
                                              child: Icon(Icons
                                                  .circle), // replace "Icons.star" with your desired icon
                                            ),
                                            SizedBox(
                                              width: 15,
                                            )
                                          ],
                                        ))
                                      ],
                                    )),
                                Container(
                                    height: 35,
                                    padding: EdgeInsets.zero,
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          checkColor: Colors.white,
                                          activeColor: config.primary,
                                          value: _filterOffline,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              _filterOffline = value!;
                                            });
                                          },
                                        ),
                                        Expanded(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Text('Offline'),
                                            ),
                                            const IconTheme(
                                              data: IconThemeData(
                                                color: Colors
                                                    .red, // set the color of the icon
                                                size:
                                                    16.0, // set the size of the icon
                                              ),
                                              child: Icon(Icons
                                                  .circle), // replace "Icons.star" with your desired icon
                                            ),
                                            SizedBox(
                                              width: 15,
                                            )
                                          ],
                                        ))
                                      ],
                                    )),
                                Container(
                                    height: 35,
                                    padding: EdgeInsets.zero,
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          checkColor: Colors.white,
                                          activeColor: config.primary,
                                          value: _filterGPS,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              _filterGPS = value!;
                                            });
                                          },
                                        ),
                                        Expanded(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Text('GPS not updated'),
                                            ),
                                            const IconTheme(
                                              data: IconThemeData(
                                                color: Colors
                                                    .blue, // set the color of the icon
                                                size:
                                                    16.0, // set the size of the icon
                                              ),
                                              child: Icon(Icons
                                                  .circle), // replace "Icons.star" with your desired icon
                                            ),
                                            SizedBox(
                                              width: 15,
                                            )
                                          ],
                                        ))
                                      ],
                                    )),
                                Container(
                                    height: 35,
                                    padding: EdgeInsets.zero,
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          checkColor: Colors.white,
                                          activeColor: config.primary,
                                          value: _filterLost,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              _filterLost = value!;
                                            });
                                          },
                                        ),
                                        Expanded(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Text('Connection Lost'),
                                            ),
                                            const IconTheme(
                                              data: IconThemeData(
                                                color: Colors
                                                    .grey, // set the color of the icon
                                                size:
                                                    16.0, // set the size of the icon
                                              ),
                                              child: Icon(Icons
                                                  .circle), // replace "Icons.star" with your desired icon
                                            ),
                                            SizedBox(
                                              width: 15,
                                            )
                                          ],
                                        ))
                                      ],
                                    )),
                                Container(
                                    height: 35,
                                    padding: EdgeInsets.zero,
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          checkColor: Colors.white,
                                          activeColor: config.primary,
                                          value: _filterAwating,
                                          onChanged: (bool? value) {
                                            setState(() {
                                              _filterAwating = value!;
                                            });
                                          },
                                        ),
                                        Expanded(
                                            child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child:
                                                  Text('Awaiting Connection'),
                                            ),
                                            const IconTheme(
                                              data: IconThemeData(
                                                color: Colors
                                                    .yellow, // set the color of the icon
                                                size:
                                                    16.0, // set the size of the icon
                                              ),
                                              child: Icon(Icons
                                                  .circle), // replace "Icons.star" with your desired icon
                                            ),
                                            SizedBox(
                                              width: 15,
                                            )
                                          ],
                                        ))
                                      ],
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ]),
              Container(
                  decoration: BoxDecoration(
                border: Border(top: BorderSide(width: 1, color: Colors.grey)),
              )),
              ExpansionTile(
                title: const Text(
                  "Main Group (16)",
                ), //add icon
                iconColor: config.primary,
                textColor: config.primary,
                childrenPadding:
                    const EdgeInsets.only(left: 15), //children padding
                children: [
                  Container(
                    child: Column(
                      children: [
                        InkWell(
                          child: Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                  width: 189,
                                  child: Text(
                                    'CLIO 01089-105-90 3904 3856 89 AAAAAAAAAA',
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              const IconTheme(
                                data: IconThemeData(
                                  color:
                                      Colors.blue, // set the color of the icon
                                  size: 16.0, // set the size of the icon
                                ),
                                child: Icon(Icons
                                    .circle), // replace "Icons.star" with your desired icon
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SingleAssest()));
                          },
                        )
                      ],
                    ),
                  ),
                  config.v_gap_md
                ],
              ),
              ListTile(
                leading: const Icon(Icons.add),
                minLeadingWidth: 5,
                title: const Text('Add asset'),
                onTap: () => {},
              ),
              ListTile(
                leading: const Icon(Icons.account_box_outlined),
                title: const Text('Account'),
                minLeadingWidth: 5,
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AccountPage()))
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                minLeadingWidth: 5,
                title: const Text('Settings'),
                onTap: () => {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SettingPage()))
                },
              ),
              ListTile(
                leading: const Icon(Icons.help_center_outlined),
                minLeadingWidth: 5,
                title: const Text('Support'),
                onTap: () => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SupportPage()))
                },
              ),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                minLeadingWidth: 5,
                title: const Text('Sign Out'),
                onTap: () => {Navigator.of(context).pop()},
              ),
            ],
          ),
        ));
  }
}
