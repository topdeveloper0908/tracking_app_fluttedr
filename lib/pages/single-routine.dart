// ignore_for_file: non_constant_identifier_names, unused_field, use_key_in_widget_constructors, prefer_final_fields

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Polyline example',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: SingleRoutine(),
    );
  }
}

class SingleRoutine extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SingleRoutineState();
}

class SingleRoutineState extends State<SingleRoutine> {
  double _originLatitude = 37.422131,
      _originLongitude = -122.084801,
      _destLatitude = 37.415768808487435,
      _destLongitude = -122.084801;
  final Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  String googleAPIKey = "AIzaSyCc59PXGa9wUC2-1SsUYmebgnhSL-RomL8";

  // this will hold the generated polylines
  final Set<Polyline> _polylines = {};
  // this will hold each polyline coordinate as Lat and Lng pairs
  List<LatLng> polylineCoordinates = [];
  // this is the key object - the PolylinePoints
  // which generates every polyline between start and finish
  PolylinePoints polylinePoints = PolylinePoints();

  @override
  void initState() {
    addCustomIcon();
    setPolylines();
    super.initState();
  }

  void addCustomIcon() {
    BitmapDescriptor.fromAssetImage(const ImageConfiguration(),
            "assets/images/destination_map_marker.png")
        .then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  setPolylines() async {
    List<PointLatLng> result =
        (await polylinePoints?.getRouteBetweenCoordinates(
            googleAPIKey,
            _originLatitude,
            _originLongitude,
            _destLatitude,
            _destLongitude)) as List<PointLatLng>;
    if (result.isNotEmpty) {
      // loop through all PointLatLng points and convert them
      // to a list of LatLng, required by the Polyline
      result.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }

    setState(() {
      // create a Polyline instance
      // with an id, an RGB color and the list of LatLng pairs
      Polyline polyline = Polyline(
          polylineId: const PolylineId("poly"),
          color: Colors.red,
          points: polylineCoordinates);

      // add the constructed polyline as a set of points
      // to the polyline set, which will eventually
      // end up showing up on the map
      _polylines.add(polyline);
    });
  }

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(Utils.mapStyles);
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF2FB1A8),
        title: const Text('Tracking'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(_originLatitude, _originLongitude),
          zoom: 16,
        ),
        polylines: _polylines,
        onMapCreated: onMapCreated,
        markers: {
          Marker(
            markerId: const MarkerId("marker1"),
            position: LatLng(_originLatitude, _originLongitude),
            // icon: markerIcon,
          ),
          Marker(
            markerId: const MarkerId("marker2"),
            position: LatLng(_destLatitude, _destLongitude),
            // icon: markerIcon,
          ),
        },
      ),
    );
  }
}

// class SingleRoutineState extends State<SingleRoutine> {
//   final Completer<GoogleMapController> _controller = Completer();
//   BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
//   BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
//   // this set will hold my markers
//   // ignore: prefer_final_fields
//   Set<Marker> _markers = {};
//   // this will hold the generated polylines
//   final Set<Polyline> _polylines = {};
//   // this will hold each polyline coordinate as Lat and Lng pairs
//   List<LatLng> polylineCoordinates = [];
//   // this is the key object - the PolylinePoints
//   // which generates every polyline between start and finish
//   PolylinePoints polylinePoints = PolylinePoints();

//   double CAMERA_ZOOM = 15;
//   double CAMERA_TILT = 0;
//   double CAMERA_BEARING = 30;
//   LatLng SOURCE_LOCATION = const LatLng(42.7477863, -71.1699932);
//   LatLng DEST_LOCATION = const LatLng(42.6871386, -71.2143403);
//   // ignore: prefer_final_fields
//   double _originLatitude = 26.48424, _originLongitude = 50.04551;
//   // ignore: prefer_final_fields
//   double _destLatitude = 26.46423, _destLongitude = 50.06358;

//   String googleAPIKey = "AIzaSyCc59PXGa9wUC2-1SsUYmebgnhSL-RomL8";
//   // for my custom icons

//   @override
//   void initState() {
//     super.initState();
//     setSourceAndDestinationIcons();
//   }

//   void setSourceAndDestinationIcons() async {
//     await BitmapDescriptor.fromAssetImage(
//             const ImageConfiguration(devicePixelRatio: 2.5),
//             'assets/images/driving_pin.png')
//         .then((icon) {
//       setState(() {
//         sourceIcon = icon;
//       });
//     });
//     await BitmapDescriptor.fromAssetImage(
//             const ImageConfiguration(devicePixelRatio: 2.5),
//             'assets/images/destination_map_marker.png')
//         .then((icon) {
//       setState(() {
//         destinationIcon = icon;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     CameraPosition initialLocation = CameraPosition(
//         zoom: CAMERA_ZOOM,
//         bearing: CAMERA_BEARING,
//         tilt: CAMERA_TILT,
//         target: LatLng(_originLatitude, _originLongitude));
//     return GoogleMap(
//         myLocationEnabled: true,
//         compassEnabled: true,
//         tiltGesturesEnabled: false,
//         markers: {
//           Marker(
//             markerId: const MarkerId("marker1"),
//             position: const LatLng(37.422131, -122.084801),
//             draggable: true,
//             onDragEnd: (value) {
//               // value is the new position
//             },
//           ),
//           Marker(
//             markerId: const MarkerId("marker2"),
//             position: const LatLng(37.415768808487435, -122.08440050482749),
//           )
//         },
//         polylines: _polylines,
//         mapType: MapType.normal,
//         initialCameraPosition: initialLocation,
//         onMapCreated: onMapCreated);
//   }

//   void onMapCreated(GoogleMapController controller) {
//     controller.setMapStyle(Utils.mapStyles);
//     _controller.complete(controller);
//     setPolylines();
//   }

//   setPolylines() async {
//     List<PointLatLng> result =
//         (await polylinePoints?.getRouteBetweenCoordinates(
//             googleAPIKey,
//             _originLatitude,
//             _originLongitude,
//             _destLatitude,
//             _originLongitude)) as List<PointLatLng>;
//     if (result.isNotEmpty) {
//       // loop through all PointLatLng points and convert them
//       // to a list of LatLng, required by the Polyline
//       result.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//     }

//     setState(() {
//       // create a Polyline instance
//       // with an id, an RGB color and the list of LatLng pairs
//       Polyline polyline = Polyline(
//           polylineId: const PolylineId("poly"),
//           color: const Color.fromARGB(255, 40, 122, 198),
//           points: polylineCoordinates);

//       // add the constructed polyline as a set of points
//       // to the polyline set, which will eventually
//       // end up showing up on the map
//       _polylines.add(polyline);
//     });
//   }
// }

class Utils {
  static String mapStyles = '''[
  {
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "elementType": "labels.icon",
    "stylers": [
      {
        "visibility": "off"
      }
    ]
  },
  {
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "elementType": "labels.text.stroke",
    "stylers": [
      {
        "color": "#f5f5f5"
      }
    ]
  },
  {
    "featureType": "administrative.land_parcel",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#bdbdbd"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "poi",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]
  },
  {
    "featureType": "poi.park",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "road",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#ffffff"
      }
    ]
  },
  {
    "featureType": "road.arterial",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#757575"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#dadada"
      }
    ]
  },
  {
    "featureType": "road.highway",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#616161"
      }
    ]
  },
  {
    "featureType": "road.local",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  },
  {
    "featureType": "transit.line",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#e5e5e5"
      }
    ]Todo
  },
  {
    "featureType": "transit.station",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#eeeeee"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "geometry",
    "stylers": [
      {
        "color": "#c9c9c9"
      }
    ]
  },
  {
    "featureType": "water",
    "elementType": "labels.text.fill",
    "stylers": [
      {
        "color": "#9e9e9e"
      }
    ]
  }
]''';
}
