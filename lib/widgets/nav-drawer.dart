// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:tracking/auth/sign-in.dart';
import 'package:string_to_color/string_to_color.dart';
import 'package:provider/provider.dart';

import 'package:tracking/config/styles.dart';
import 'package:tracking/config/constant.dart';
import 'package:tracking/pages/single-assest.dart';
import 'package:tracking/pages/account.dart';
import 'package:tracking/pages/support.dart';
import 'package:tracking/pages/settings.dart';
import 'package:tracking/services/track-provider.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _NavDrawerState createState() => _NavDrawerState();
}

// ignore: use_key_in_widget_constructors
class _NavDrawerState extends State<NavDrawer> {
  late var token;
  bool dataLoading = false;
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

  static late SharedPreferences _sharedPreferences;

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
  late List<dynamic> filteredAssets = [];
  late List<dynamic> groups = [];
  late List<dynamic> tracks = [];
  late List counts = [];
  TextEditingController searchCtl = TextEditingController();
  AppConfig config = AppConfig();
  void assetFilter() {
    // if (!_filterAwating &
    //     !_filterOnline &
    //     !_filterGPS &
    //     !_filterLost &
    //     !_filterOffline) {
    //   filteredAssets = tracks;
    // } else {
    //   filteredAssets = [];
    //   for (var i = 0; i < tracks.length; i++) {
    //     if (_filterOnline && assests[i][1].toString() == '1') {
    //       filteredAssets.add(assests[i]);
    //     } else if (_filterOffline && assests[i][1].toString() == '2') {
    //       filteredAssets.add(assests[i]);
    //     } else if (_filterGPS && assests[i][1].toString() == '3') {
    //       filteredAssets.add(assests[i]);
    //     } else if (_filterLost && assests[i][1].toString() == '4') {
    //       filteredAssets.add(assests[i]);
    //     } else if (_filterAwating && assests[i][1].toString() == '5') {
    //       filteredAssets.add(assests[i]);
    //     }
    //   }
    // }
    if (searchCtl.text != '') {
      List<List<String>> tmp = [];
      for (var i = 0; i < filteredAssets.length; i++) {
        if (filteredAssets[i]['title'].contains(searchCtl.text)) {
          tmp.add(filteredAssets[i]);
        }
      }
      filteredAssets = tmp;
    }
    getCounts();
  }

  static Future<void> init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static String getToken() {
    return _sharedPreferences.getString('token') ?? '';
  }

  Future<void> setSelectedAssest(String id) async {
    _sharedPreferences.setString('assestID', id);
  }

  Future<void> getGroups() async {
    groups =
        await Provider.of<TrackProvider>(context, listen: false).getGroups();
  }

  Future<void> getTracks() async {
    tracks =
        await Provider.of<TrackProvider>(context, listen: false).getTracks();
    filteredAssets = tracks;
  }

  void getCounts() {
    counts = Provider.of<TrackProvider>(context, listen: false)
        .getCounts(groups, tracks);
  }

  void searchFilter(String value) {
    if (value == '') {
      filteredAssets = tracks;
      assetFilter();
    }
  }

  void _handleLogout() async {
    var uri = Uri.parse('${ApiURL.LOGOUT_URL}');
    var headers = {
      'Content-Type': 'application/json',
      'X-Auth-Token': _sharedPreferences.getString('token')
    };
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      _sharedPreferences.remove('token');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const SignInPage()));
    }
  }

  @override
  void initState() {
    super.initState();
    init();
    // state = Provider.of<AppState>(context, listen: false);
    mainFunc();
  }

  @override
  void dispose() {
    super.dispose();
  }

  mainFunc() async {
    await getGroups();
    await getTracks();
    getCounts();
    setState(() => {dataLoading = true});
  }

  toColor(value) {
    var hexString = value;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
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
              if (dataLoading)
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
                                    top: BorderSide(
                                        width: 1, color: Colors.grey),
                                    bottom: BorderSide(
                                        width: 1, color: Colors.grey),
                                    left: BorderSide(
                                        width: 1, color: Colors.grey),
                                    right: BorderSide(
                                        width: 1, color: Colors.grey),
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
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
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
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border:
                        Border(top: BorderSide(width: 1, color: Colors.grey)),
                  )),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 10,
                    height: 60,
                    color: Colors.black,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        counts[groups.length] == 0
                            ? ExpansionTile(
                                title: Text(
                                  'Main Group',
                                ), //add icon
                                iconColor: config.primary,
                                textColor: config.primary,
                                childrenPadding: const EdgeInsets.only(
                                    left: 15), //children padding
                                children: [
                                  Text('No Assets'),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              )
                            : ExpansionTile(
                                title: Text(
                                  'Main Group',
                                ), //add icon
                                iconColor: config.primary,
                                textColor: config.primary,
                                childrenPadding: const EdgeInsets.only(
                                    left: 15), //children padding
                                children: [
                                  for (int y = 0;
                                      y < filteredAssets.length;
                                      y++) ...[
                                    filteredAssets[y]['groupId'] == null
                                        ? Column(
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
                                                          filteredAssets[y]
                                                              ['title'],
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        )),
                                                    IconTheme(
                                                      data: IconThemeData(
                                                        color: statusColors[
                                                            3], // set the color of the icon
                                                        size:
                                                            16.0, // set the size of the icon
                                                      ),
                                                      child: Icon(Icons
                                                          .circle), // replace "Icons.star" with your desired icon
                                                    ),
                                                  ],
                                                ),
                                                onTap: () {
                                                  setSelectedAssest(
                                                      filteredAssets[y]['id']);
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const SingleAssest()));
                                                },
                                              ),
                                              config.v_gap_md,
                                            ],
                                          )
                                        : SizedBox.shrink(),
                                  ],
                                ],
                              ),
                        // Container(
                        //     decoration: BoxDecoration(
                        //   border: Border(
                        //       top: BorderSide(width: 1, color: Colors.grey)),
                        // ))
                      ],
                    ),
                  ),
                ],
              ),
              for (int x = 0; x < groups.length; x++) ...[
                // Container(
                //   width: 10,
                // ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 10,
                      height: 60,
                      color: toColor(groups[x]['colour']),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          counts[x] == 0
                              ? ExpansionTile(
                                  title: Text(
                                    groups[x]['name'],
                                  ), //add icon
                                  iconColor: config.primary,
                                  textColor: config.primary,
                                  childrenPadding: const EdgeInsets.only(
                                      left: 15), //children padding
                                  children: [
                                    Text('No Assets'),
                                    SizedBox(
                                      height: 10,
                                    )
                                  ],
                                )
                              : ExpansionTile(
                                  title: Text(
                                    groups[x]['name'],
                                  ), //add icon
                                  iconColor: config.primary,
                                  textColor: config.primary,
                                  childrenPadding: const EdgeInsets.only(
                                      left: 15), //children padding
                                  children: [
                                    for (int y = 0;
                                        y < filteredAssets.length;
                                        y++) ...[
                                      groups[x]['id'] ==
                                              filteredAssets[y]['groupId']
                                          ? Column(
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
                                                            filteredAssets[y]
                                                                ['title'],
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          )),
                                                      IconTheme(
                                                        data: IconThemeData(
                                                          color: statusColors[
                                                              3], // set the color of the icon
                                                          size:
                                                              16.0, // set the size of the icon
                                                        ),
                                                        child: Icon(Icons
                                                            .circle), // replace "Icons.star" with your desired icon
                                                      ),
                                                    ],
                                                  ),
                                                  onTap: () {
                                                    setSelectedAssest(
                                                        filteredAssets[y]
                                                            ['id']);
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const SingleAssest()));
                                                  },
                                                ),
                                                config.v_gap_md,
                                              ],
                                            )
                                          : SizedBox.shrink(),
                                    ],
                                  ],
                                ),
                          // Container(
                          //     decoration: BoxDecoration(
                          //   border: Border(
                          //       top: BorderSide(width: 1, color: Colors.grey)),
                          // ))
                        ],
                      ),
                    ),
                  ],
                )
              ],
              // filteredAssets.isNotEmpty
              //     ? ExpansionTile(
              //         title: const Text(
              //           "Main Group (16)",
              //         ), //add icon
              //         iconColor: config.primary,
              //         textColor: config.primary,
              //         childrenPadding:
              //             const EdgeInsets.only(left: 15), //children padding

              //         children: [
              //           for (int x = 0; x < filteredAssets.length; x++) ...[
              //             Column(
              //               children: [
              //                 InkWell(
              //                   child: Row(
              //                     children: [
              //                       SizedBox(
              //                         width: 10,
              //                       ),
              //                       SizedBox(
              //                           width: 189,
              //                           child: Text(
              //                             filteredAssets[x][0],
              //                             overflow: TextOverflow.ellipsis,
              //                           )),
              //                       IconTheme(
              //                         data: IconThemeData(
              //                           color: statusColors[
              //                               int.parse(filteredAssets[x][1]) -
              //                                   1], // set the color of the icon
              //                           size: 16.0, // set the size of the icon
              //                         ),
              //                         child: Icon(Icons
              //                             .circle), // replace "Icons.star" with your desired icon
              //                       ),
              //                     ],
              //                   ),
              //                   onTap: () {
              //                     Navigator.push(
              //                         context,
              //                         MaterialPageRoute(
              //                             builder: (context) =>
              //                                 const SingleAssest()));
              //                   },
              //                 )
              //               ],
              //             ),
              //             config.v_gap_md,
              //           ],
              //         ],
              //       )
              //     : ExpansionTile(
              //         title: const Text(
              //           "Main Group (16)",
              //         ), //add icon
              //         iconColor: config.primary,
              //         textColor: config.primary,
              //         childrenPadding:
              //             const EdgeInsets.only(left: 15), //children padding
              //         children: [Text("No assets")],
              //       ),
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
                onTap: () => {_handleLogout()},
              ),
            ],
          ),
        ));
  }
}
