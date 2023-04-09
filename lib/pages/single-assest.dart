// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:motion_tab_bar_v2/motion-badge.widget.dart';

import 'package:tracking/config/styles.dart';
import 'package:tracking/component/timline/data-model.dart';
import 'package:tracking/component/timline/custom-list-tracking.dart';
import 'package:tracking/pages/tracker-setting.dart';
import 'package:tracking/widgets/nav-drawer.dart';
import 'package:tracking/pages/single-routine.dart';
import 'package:tracking/pages/single-event.dart';

const double CAMERA_ZOOM = 13;
const double CAMERA_TILT = 0;
const double CAMERA_BEARING = 30;
const LatLng SOURCE_LOCATION = LatLng(42.7477863, -71.1699932);
const LatLng DEST_LOCATION = LatLng(42.6871386, -71.2143403);

class PinInformation {
  String pinPath;
  String avatarPath;
  LatLng location;
  String locationName;
  Color labelColor;
  PinInformation(
      {required this.pinPath,
      required this.avatarPath,
      required this.location,
      required this.locationName,
      required this.labelColor});
}

class SingleAssest extends StatelessWidget {
  const SingleAssest({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SingleAssestPage(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class SingleAssestPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SingleAssestPageState createState() => _SingleAssestPageState();
}

// ignore: use_key_in_widget_constructors
class _SingleAssestPageState extends State<SingleAssestPage>
    with TickerProviderStateMixin {
  AppConfig config = AppConfig();
  List<DataModel> listExample = [];
  TabController? _tabController;
  GoogleMapController? controller;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  MarkerId? selectedMarker;
  Set<Marker> tmp = {};

  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = {};
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  double pinPillPosition = 0;
  CameraPosition initialLocation = const CameraPosition(
      zoom: CAMERA_ZOOM,
      bearing: CAMERA_BEARING,
      tilt: CAMERA_TILT,
      target: SOURCE_LOCATION);
  PinInformation currentlySelectedPin = PinInformation(
      pinPath: '',
      avatarPath: '',
      location: const LatLng(50, 50),
      locationName: '',
      labelColor: Colors.grey);
  late PinInformation sourcePinInfo;
  late PinInformation destinationPinInfo;
  TextEditingController renameCtrl = TextEditingController();
  bool renameStatus = false;

  // Card
  TextStyle Card_Titlestyle = TextStyle(
    color: Colors.black87,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  TextStyle Card_subTitlestyle = TextStyle(fontSize: 16, color: Colors.grey);
  // Bottom Sheet
  double bottomSheet_width = double.infinity;
  BoxDecoration bottomSheet_decoration = const BoxDecoration(
      border: Border(top: BorderSide(width: 1, color: Colors.grey)));
  TextStyle bottomSheet_textstyle =
      TextStyle(fontSize: 20, color: Color(0xFF2FB1A8));
  @override
  // ignore: must_call_super
  void initState() {
    setSourceAndDestinationIcons();
    _tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
    setMapPins();
    listExample.add(DataModel(
        title: "Approved",
        isSecond: "false",
        desc: "This task was approved by your manager",
        dateTime: "08:55"));

    listExample.add(DataModel(
        title: "Warning",
        isSecond: "true",
        desc: "This task was got yellow notice by your manager",
        dateTime: "10:05"));
  }

  void setSourceAndDestinationIcons() async {
    await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(devicePixelRatio: 2.5),
            'assets/images/driving_pin.png')
        .then((icon) {
      setState(() {
        sourceIcon = icon;
      });
    });
  }

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(Utils.mapStyles);
    _controller.complete(controller);
    setMapPins();
  }

  void setMapPins() {
    // add the source marker to the list of markers
    _markers.add(Marker(
        markerId: const MarkerId('sourcePin'),
        position: SOURCE_LOCATION,
        icon: sourceIcon,
        onTap: () {}));
    // populate the sourcePinInfo object
    sourcePinInfo = PinInformation(
        locationName: 'Start Location',
        location: SOURCE_LOCATION,
        pinPath: 'assets/images/driving_pin.png',
        avatarPath: 'assets/images/driving_pin.jpg',
        labelColor: Colors.blueAccent);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final renameField = TextFormField(
      controller: renameCtrl,
      keyboardType: TextInputType.text,
      cursorColor: config.cursorColor,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        hintText: "Enter name",
        hintStyle: config.hintStyle,
        enabledBorder: config.enabledBorder,
        focusedBorder: config.focusedBorder,
        errorBorder: config.errorBorder,
        filled: config.filled,
        fillColor: config.fillColor,
      ),
    );
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          drawer: NavDrawer(),
          appBar: AppBar(
            title: const Text('CLIO 01089-105-90 3904-3856-89'),
            backgroundColor: config.primary,
          ),
          bottomNavigationBar: MotionTabBar(
            initialSelectedTab: "Location",
            useSafeArea: true, // default: true, apply safe area wrapper
            labels: const ["Location", "Information", "Routine", "Events"],
            icons: const [
              Icons.dashboard,
              Icons.home,
              Icons.people_alt,
              Icons.settings
            ],
            tabSize: 50,
            tabBarHeight: 55,
            textStyle: const TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            tabIconColor: config.primary,
            tabIconSize: 28.0,
            tabIconSelectedSize: 26.0,
            tabSelectedColor: config.primary,
            tabIconSelectedColor: Colors.white,
            tabBarColor: Colors.grey[200],
            onTabItemSelected: (int value) {
              setState(() {
                _tabController!.index = value;
              });
            },
          ),
          body: OrientationBuilder(
            builder: (context, orientation) {
              return TabBarView(
                physics:
                    const NeverScrollableScrollPhysics(), // swipe navigation handling is not supported
                controller: _tabController,
                children: [
                  Stack(
                    children: <Widget>[
                      GoogleMap(
                        myLocationEnabled: true,
                        compassEnabled: true,
                        tiltGesturesEnabled: false,
                        markers: _markers,
                        mapType: MapType.normal,
                        initialCameraPosition: initialLocation,
                        onMapCreated: onMapCreated,
                        // handle the tapping on the map
                        // to dismiss the info pill by
                        // resetting its position
                        onTap: (LatLng location) {
                          setState(() {
                            pinPillPosition = -100;
                          });
                        },
                      ),
                      AnimatedPositioned(
                          bottom: pinPillPosition,
                          right: 0,
                          left: 0,
                          duration: const Duration(milliseconds: 200),
                          // wrap it inside an Alignment widget to force it to be
                          // aligned at the bottom of the screen
                          child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                  margin: const EdgeInsets.all(20),
                                  height: 70,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50)),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                            blurRadius: 20,
                                            offset: Offset.zero,
                                            color: Colors.grey.withOpacity(0.5))
                                      ]),
                                  child: Row(children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            const Text(
                                                'CLIO 01089-105-90 3904-3856-89',
                                                style: TextStyle(
                                                    color: Colors.red)),
                                            const Text('Latitude: 50',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey)),
                                            const Text('Longtitude: 50',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey))
                                          ], // end of Column Widgets
                                        ), // end of Column
                                      ),
                                    ), // second widget
                                    Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: Image.asset(
                                            'assets/images/driving_pin.png')) // third widget
                                  ])) // end of Container
                              ) // end of Align
                          )
                    ],
                  ),
                  SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 5),
                      child: InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Card(
                                        shape: config.rounded_md,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 15),
                                                width: bottomSheet_width,
                                                child: const Text(
                                                    'Choose action:',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.grey,
                                                    ))),
                                            Container(
                                              width: bottomSheet_width,
                                              decoration:
                                                  bottomSheet_decoration,
                                              child: TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                    showModalBottomSheet(
                                                        context: context,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        builder: (context) {
                                                          return Column(
                                                            children: [
                                                              Card(
                                                                shape: config
                                                                    .rounded_md,
                                                                child: Column(
                                                                  children: <
                                                                      Widget>[
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                    Container(
                                                                        padding: const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                20,
                                                                            vertical:
                                                                                5),
                                                                        width:
                                                                            bottomSheet_width,
                                                                        child: const Text(
                                                                            'Enter new name',
                                                                            textAlign:
                                                                                TextAlign.center,
                                                                            style: TextStyle(
                                                                              fontSize: 20,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: Colors.black87,
                                                                            ))),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    Container(
                                                                        padding: const EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                20,
                                                                            vertical:
                                                                                5),
                                                                        width:
                                                                            bottomSheet_width,
                                                                        child:
                                                                            renameField),
                                                                    SizedBox(
                                                                      height:
                                                                          10,
                                                                    ),
                                                                    MaterialButton(
                                                                        // minWidth: MediaQuery.of(context).size.width,
                                                                        color: config
                                                                            .primary,
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        shape: config
                                                                            .rounded_xs,
                                                                        padding:
                                                                            EdgeInsets.symmetric(vertical: 10.5),
                                                                        child: renameStatus
                                                                            ? const SizedBox(
                                                                                height: 25,
                                                                                width: 25,
                                                                                // ignore: unnecessary_const
                                                                                child: const CircularProgressIndicator(backgroundColor: Colors.grey, valueColor: AlwaysStoppedAnimation<Color>(Colors.white), strokeWidth: 3))
                                                                            : const SizedBox(
                                                                                child: Text(
                                                                                  'Save',
                                                                                  textAlign: TextAlign.center,
                                                                                  style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.normal),
                                                                                ),
                                                                              )),
                                                                    SizedBox(
                                                                      height:
                                                                          20,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        });
                                                  },
                                                  child: Text(
                                                    'Rename',
                                                    style:
                                                        bottomSheet_textstyle,
                                                  )),
                                            ),
                                            Container(
                                              width: bottomSheet_width,
                                              decoration:
                                                  bottomSheet_decoration,
                                              child: TextButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                TrackerSettingPage()));
                                                  },
                                                  child: Text(
                                                    'Settings',
                                                    style:
                                                        bottomSheet_textstyle,
                                                  )),
                                            )
                                          ],
                                        ),
                                      ),
                                      Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            Container(
                                              width: bottomSheet_width,
                                              child: TextButton(
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                  child: Text(
                                                    'Cancel',
                                                    style:
                                                        bottomSheet_textstyle,
                                                  )),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                });
                          },
                          child: Column(
                            children: [
                              Card(
                                  shape: config.rounded_xs,
                                  elevation: 2,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 30, horizontal: 20),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.electric_bolt_outlined,
                                                color: config.primary,
                                                size: 40.0,
                                                semanticLabel:
                                                    'Text to announce in accessibility modes',
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                // ignore: prefer_const_literals_to_create_immutables
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        screenSize.width * 0.6,
                                                    child: const Text(
                                                      "Yaris 00779-109-05 DFC BENG",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                  ),
                                                  config.v_gap_xs,
                                                  const Text(
                                                    "Now",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 120,
                                              child: const Text(
                                                'Model: ',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              'Concox GT06N',
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 120,
                                              child: const Text(
                                                'Plan: ',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              'Fleet Management',
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 120,
                                              child: const Text(
                                                'Cost: ',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              '21600,00DZD / Year',
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 120,
                                              child: const Text(
                                                'PayDate: ',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              '17 Nov 2023',
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 120,
                                              child: const Text(
                                                'DeviceID: ',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              '35370195858470',
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 120,
                                              child: const Text(
                                                'Status: ',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: const [
                                                Text(
                                                  'GPS not updated',
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                IconTheme(
                                                  data: IconThemeData(
                                                    color: Colors
                                                        .blue, // set the color of the icon
                                                    size:
                                                        16.0, // set the size of the icon
                                                  ),
                                                  child: Icon(Icons
                                                      .circle), // replace "Icons.star" with your desired icon
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              config.v_gap_xs,
                              Card(
                                  shape: config.rounded_xs,
                                  elevation: 2,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 30, horizontal: 20),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.location_city_outlined,
                                                color: config.primary,
                                                size: 40.0,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                // ignore: prefer_const_literals_to_create_immutables
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        screenSize.width * 0.5,
                                                    child: const Text(
                                                      "Location",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                  ),
                                                  config.v_gap_xs,
                                                  Text(
                                                    "1h 14min ago",
                                                    style: Card_subTitlestyle,
                                                  )
                                                ],
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.local_activity_outlined,
                                                  color: config.primary,
                                                  size: 40,
                                                ),
                                                onPressed: () {
                                                  // Perform some action
                                                },
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 120,
                                              child: const Text(
                                                'Signal : ',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              'GPS 50%',
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 120,
                                              child: const Text(
                                                'Status : ',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              'Stopped',
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 120,
                                              child: const Text(
                                                'Speed : ',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              '0 km/h',
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 120,
                                              child: const Text(
                                                'Coordinates: ',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Banta DG-05, Algere, 05000',
                                                  style: Card_Titlestyle,
                                                ),
                                                Text(
                                                  '(35.56798 / 6.18106)',
                                                  style: Card_Titlestyle,
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              config.v_gap_xs,
                              Card(
                                  shape: config.rounded_xs,
                                  elevation: 2,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 30, horizontal: 20),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.wifi_outlined,
                                                color: config.primary,
                                                size: 40.0,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                // ignore: prefer_const_literals_to_create_immutables
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        screenSize.width * 0.6,
                                                    child: const Text(
                                                      "GSM",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                  ),
                                                  config.v_gap_xs,
                                                  Text(
                                                    "Now",
                                                    style: Card_subTitlestyle,
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 120,
                                              child: const Text(
                                                'Signal : ',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              '100%',
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 120,
                                              child: const Text(
                                                'Carrier : ',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              'Mobilis',
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              config.v_gap_xs,
                              Card(
                                  shape: config.rounded_xs,
                                  elevation: 2,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 30, horizontal: 20),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.wifi_outlined,
                                                color: config.primary,
                                                size: 40.0,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                // ignore: prefer_const_literals_to_create_immutables
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        screenSize.width * 0.6,
                                                    child: const Text(
                                                      "Energy",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                  ),
                                                  config.v_gap_xs,
                                                  Text(
                                                    "Now",
                                                    style: Card_subTitlestyle,
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 120,
                                              child: const Text(
                                                'Battery : ',
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              '100%',
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 16,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              config.v_gap_xs,
                              Card(
                                  shape: config.rounded_xs,
                                  elevation: 2,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 30, horizontal: 20),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.wifi_outlined,
                                                color: config.primary,
                                                size: 40.0,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                // ignore: prefer_const_literals_to_create_immutables
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        screenSize.width * 0.6,
                                                    child: const Text(
                                                      "Inputs",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                  ),
                                                  config.v_gap_xs,
                                                  Text(
                                                    "Now",
                                                    style: Card_subTitlestyle,
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                IconTheme(
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
                                                  width: 10,
                                                ),
                                                Text(
                                                  'Alarme de voiture: Inactive',
                                                  style: Card_Titlestyle,
                                                ),
                                              ],
                                            ),
                                            config.v_gap_sm,
                                            Row(
                                              children: [
                                                IconTheme(
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
                                                  width: 10,
                                                ),
                                                Text(
                                                  'Allumage: Active',
                                                  style: Card_Titlestyle,
                                                ),
                                              ],
                                            ),
                                            config.v_gap_sm,
                                            Row(
                                              children: [
                                                IconTheme(
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
                                                  width: 10,
                                                ),
                                                Text(
                                                  'Chargement: Active',
                                                  style: Card_Titlestyle,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                              config.v_gap_xs,
                              Card(
                                  shape: config.rounded_xs,
                                  elevation: 2,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 30, horizontal: 20),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.wifi_outlined,
                                                color: config.primary,
                                                size: 40.0,
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                // ignore: prefer_const_literals_to_create_immutables
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        screenSize.width * 0.6,
                                                    child: const Text(
                                                      "Events",
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color:
                                                              Colors.black87),
                                                    ),
                                                  ),
                                                  config.v_gap_xs,
                                                  Text(
                                                    "Now",
                                                    style: Card_subTitlestyle,
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                IconTheme(
                                                  data: IconThemeData(
                                                    color: Colors
                                                        .green, // set the color of the icon
                                                    size:
                                                        16.0, // set the size of the icon
                                                  ),
                                                  child: Icon(Icons
                                                      .location_pin), // replace "Icons.star" with your desired icon
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  '14:09 - Coupure de courant exteme',
                                                  style: Card_Titlestyle,
                                                ),
                                              ],
                                            ),
                                            config.v_gap_sm,
                                            Row(
                                              children: [
                                                IconTheme(
                                                  data: IconThemeData(
                                                    color: Colors
                                                        .green, // set the color of the icon
                                                    size:
                                                        16.0, // set the size of the icon
                                                  ),
                                                  child: Icon(Icons
                                                      .location_pin), // replace "Icons.star" with your desired icon
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  '14:09 - Coupure de courant exteme',
                                                  style: Card_Titlestyle,
                                                ),
                                              ],
                                            ),
                                            config.v_gap_sm,
                                          ],
                                        ),
                                      ],
                                    ),
                                  )),
                            ],
                          )),
                    ),
                  ),
                  DefaultTabController(
                      length: 4, // length of tabs
                      initialIndex: 0,
                      child: Scaffold(
                          appBar: AppBar(
                            automaticallyImplyLeading: false,
                            backgroundColor: Colors.white,
                            elevation: 0,
                            bottom: PreferredSize(
                              preferredSize: const Size.fromHeight(0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xffEBECEE),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                height: 35,
                                width: MediaQuery.of(context).size.width * 0.95,
                                child: TabBar(
                                  unselectedLabelColor: const Color(0xffB4BABF),
                                  labelColor: Colors.black,
                                  unselectedLabelStyle: const TextStyle(
                                    fontFamily: 'M_PLUS',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  labelStyle: const TextStyle(
                                    fontFamily: 'M_PLUS',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  indicator: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: const EdgeInsets.all(2),
                                  tabs: const [
                                    Tab(
                                      text: 'Today',
                                    ),
                                    Tab(text: 'Yestrd'),
                                    Tab(text: 'Week'),
                                    Tab(text: 'interval'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          body: TabBarView(children: <Widget>[
                            SingleChildScrollView(
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 5),
                                    child: Column(
                                      children: [
                                        config.v_gap_xs,
                                        Card(
                                            child: InkWell(
                                          onTap: () => {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SingleRoutine()))
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 10),
                                            child: Column(
                                              children: [
                                                Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: CustomListTracking<
                                                            DataModel>(
                                                        listItem: listExample,
                                                        valueTextOfTitle: (e) =>
                                                            e.dateTime!,
                                                        valueTextOfDesc: (e) =>
                                                            e.desc!,
                                                        colorCircleTimeline:
                                                            (e) => Colors.grey,
                                                        showLeftWidget: false)),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          50, 0, 30, 0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: const [
                                                      Text(
                                                        '38.55Km',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        '1h 55min',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )),
                                        config.v_gap_xs,
                                        Card(
                                            child: InkWell(
                                          onTap: () => {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SingleRoutine()))
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 0, 0, 10),
                                            child: Column(
                                              children: [
                                                Container(
                                                    margin:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: CustomListTracking<
                                                            DataModel>(
                                                        listItem: listExample,
                                                        valueTextOfTitle: (e) =>
                                                            e.dateTime!,
                                                        valueTextOfDesc: (e) =>
                                                            e.desc!,
                                                        colorCircleTimeline:
                                                            (e) => Colors.grey,
                                                        showLeftWidget: false)),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          50, 0, 30, 0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: const [
                                                      Text(
                                                        '38.55Km',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        '1h 55min',
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ))
                                      ],
                                    ))),
                            Container(
                              child: const Center(
                                child: Text('No Events',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Container(
                              child: const Center(
                                child: Text('No Events',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Container(
                              child: const Center(
                                child: Text('No Events',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ]))),
                  DefaultTabController(
                      length: 4, // length of tabs
                      initialIndex: 0,
                      child: Scaffold(
                          appBar: AppBar(
                            automaticallyImplyLeading: false,
                            backgroundColor: Colors.white,
                            elevation: 0,
                            bottom: PreferredSize(
                              preferredSize: const Size.fromHeight(0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xffEBECEE),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                height: 35,
                                width: MediaQuery.of(context).size.width * 0.95,
                                child: TabBar(
                                  unselectedLabelColor: const Color(0xffB4BABF),
                                  labelColor: Colors.black,
                                  unselectedLabelStyle: const TextStyle(
                                    fontFamily: 'M_PLUS',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  labelStyle: const TextStyle(
                                    fontFamily: 'M_PLUS',
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  indicator: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  padding: const EdgeInsets.all(2),
                                  tabs: const [
                                    Tab(
                                      text: 'Today',
                                    ),
                                    Tab(text: 'Yestrd'),
                                    Tab(text: 'Week'),
                                    Tab(text: 'Month'),
                                    Tab(text: 'interval'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          body: TabBarView(children: <Widget>[
                            SingleChildScrollView(
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 5),
                                    child: Column(
                                      children: [
                                        config.v_gap_xs,
                                        Card(
                                            child: InkWell(
                                          onTap: () => {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SingleEventPage()))
                                          },
                                          child: const ListTile(
                                            minLeadingWidth: 10,
                                            leading: SizedBox(
                                                width: 20,
                                                child: Icon(Icons.alarm,
                                                    size: 20)),
                                            title: Text(
                                              'Traquer etent ot perte de la connexion',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            trailing: Text(
                                              '11:30',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey),
                                            ),
                                          ),
                                        )),
                                      ],
                                    ))),
                            Container(
                              child: const Center(
                                child: Text('Display Tab 2',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Container(
                              child: const Center(
                                child: Text('Display Tab 3',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Container(
                              child: const Center(
                                child: Text('Display Tab 4',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            Container(
                              child: const Center(
                                child: Text('Display Tab 4',
                                    style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                          ]))),
                ],
              );
            },
          )),
    );
  }
}
