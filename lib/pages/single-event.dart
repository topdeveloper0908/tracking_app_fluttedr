// ignore_for_file: prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:label_marker/label_marker.dart';

import 'package:tracking/component/timline/data-model.dart';

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

// ignore: use_key_in_widget_constructors
class SingleEventPage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _SingleEventPageState createState() => _SingleEventPageState();
}

// ignore: use_key_in_widget_constructors
class _SingleEventPageState extends State<SingleEventPage>
    with TickerProviderStateMixin {
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
  CameraPosition initialLocation = CameraPosition(
      zoom: CAMERA_ZOOM,
      bearing: CAMERA_BEARING,
      tilt: CAMERA_TILT,
      target: SOURCE_LOCATION);
  PinInformation currentlySelectedPin = PinInformation(
      pinPath: '',
      avatarPath: '',
      location: LatLng(50, 50),
      locationName: '',
      labelColor: Colors.grey);
  late PinInformation sourcePinInfo;
  late PinInformation destinationPinInfo;

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
    _controller.complete(controller);
    setMapPins();
  }

  void setMapPins() {
    // add the source marker to the list of markers
    _markers.add(Marker(
        markerId: MarkerId('sourcePin'),
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

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Traquer etent ot perte de la connexion'),
          backgroundColor: const Color(0xFF2FB1A8),
        ),
        body: Stack(
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
// wrap it inside a Container so we can provide the
// background white and rounded corners
// and nice breathing room with margins, a fixed height
// and a nice subtle shadow for a depth effect
                    child: Container(
                        margin: const EdgeInsets.all(20),
                        height: 70,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text(
                                      'Traquer etent ot perte de la connexion',
                                      style: TextStyle(color: Colors.red)),
                                  const Text('Latitude: 50',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey)),
                                  const Text('Longtitude: 50',
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.grey))
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
      ),
    );
  }
}
