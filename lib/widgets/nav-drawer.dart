// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'dart:convert';

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
  List<Color> statusColors = [
    Colors.green,
    Colors.red,
    Colors.blue,
    Colors.grey,
    Colors.yellow
  ];

  List<List<String>> assests = [
    ['abc CLIO 01089-105-90 3904 3856 89 AAAAAAAAAA', '1'],
    ['ab CLIO 01089-105-90 3904 3856 89 AAAAAAAAAA', '3'],
    ['adsf CLIO 01089-105-90 3904 3856 89 AAAAAAAAAA', '4'],
    ['gnfg CLIO 01089-105-90 3904 3856 89 AAAAAAAAAA', '2'],
    ['125 CLIO 01089-105-90 3904 3856 89 AAAAAAAAAA', '4'],
    ['tyru CLIO 01089-105-90 3904 3856 89 AAAAAAAAAA', '5'],
    ['zxczc CLIO 01089-105-90 3904 3856 89 AAAAAAAAAA', '3'],
    ['uyiy CLIO 01089-105-90 3904 3856 89 AAAAAAAAAA', '5'],
    ['qwar CLIO 01089-105-90 3904 3856 89 AAAAAAAAAA', '1'],
    ['ipi CLIO 01089-105-90 3904 3856 89 AAAAAAAAAA', '1'],
  ];
  late List<List<String>> filteredAssets = [];
  TextEditingController searchCtl = TextEditingController();
  AppConfig config = AppConfig();
  void assetFilter() {
    if (!_filterAwating &
        !_filterOnline &
        !_filterGPS &
        !_filterLost &
        !_filterOffline) {
      filteredAssets = assests;
    } else {
      filteredAssets = [];
      for (var i = 0; i < assests.length; i++) {
        if (_filterOnline && assests[i][1].toString() == '1') {
          filteredAssets.add(assests[i]);
        } else if (_filterOffline && assests[i][1].toString() == '2') {
          filteredAssets.add(assests[i]);
        } else if (_filterGPS && assests[i][1].toString() == '3') {
          filteredAssets.add(assests[i]);
        } else if (_filterLost && assests[i][1].toString() == '4') {
          filteredAssets.add(assests[i]);
        } else if (_filterAwating && assests[i][1].toString() == '5') {
          filteredAssets.add(assests[i]);
        }
      }
    }
    if (searchCtl.text != '') {
      List<List<String>> tmp = [];
      for (var i = 0; i < filteredAssets.length; i++) {
        print('value');
        if (filteredAssets[i][0].contains(searchCtl.text)) {
          tmp.add(filteredAssets[i]);
        }
      }
      filteredAssets = tmp;
    }
  }

  void searchFilter(String value) {
    if (value == '') {
      filteredAssets = assests;
      assetFilter();
    }
  }

  @override
  void initState() {
    super.initState();
    // state = Provider.of<AppState>(context, listen: false);
    setState(() {
      filteredAssets = assests;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchField = TextFormField(
      controller: searchCtl,
      keyboardType: TextInputType.emailAddress,
      cursorColor: config.cursorColor,
      onChanged: (value) => setState(() {
        assetFilter();
      }),
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
                                              assetFilter();
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
                                              assetFilter();
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
                                              assetFilter();
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
                                              assetFilter();
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
                                              assetFilter();
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
                                              assetFilter();
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
              filteredAssets.isNotEmpty
                  ? ExpansionTile(
                      title: const Text(
                        "Main Group (16)",
                      ), //add icon
                      iconColor: config.primary,
                      textColor: config.primary,
                      childrenPadding:
                          const EdgeInsets.only(left: 15), //children padding

                      children: [
                        for (int x = 0; x < filteredAssets.length; x++) ...[
                          Column(
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
                                          filteredAssets[x][0],
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                    IconTheme(
                                      data: IconThemeData(
                                        color: statusColors[
                                            int.parse(filteredAssets[x][1]) -
                                                1], // set the color of the icon
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
                          config.v_gap_md,
                        ],
                      ],
                    )
                  : ExpansionTile(
                      title: const Text(
                        "Main Group (16)",
                      ), //add icon
                      iconColor: config.primary,
                      textColor: config.primary,
                      childrenPadding:
                          const EdgeInsets.only(left: 15), //children padding
                      children: [Text("No assets")],
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
