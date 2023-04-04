// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

class AppConfig {
  // logo
  String logoUrl = 'assets/images/logo.png';
  double logoWitdh = 250;
  // Colors
  Color primary = Color(0xFF2FB1A8);

  // Input
  OutlineInputBorder enabledBorder =
      OutlineInputBorder(borderSide: BorderSide(width: 1, color: Colors.grey));
  OutlineInputBorder focusedBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: Color(0xFF2FB1A8)));
  OutlineInputBorder errorBorder = OutlineInputBorder(
      borderSide: BorderSide(width: 1, color: Colors.redAccent));
  UnderlineInputBorder u_enabledBorder = UnderlineInputBorder(
      borderSide: BorderSide(width: 1, color: Colors.grey));
  UnderlineInputBorder u_focusedBorder = UnderlineInputBorder(
      borderSide: BorderSide(width: 1, color: Color(0xFF2FB1A8)));
  bool filled = false;
  Color fillColor = Colors.white;
  Color cursorColor = Color(0xFF2FB1A8);
  TextStyle hintStyle = TextStyle(color: Colors.grey, fontSize: 18);

  // Font Size
  double f_xl = 24;
  double f_lg = 20;
  double f_md = 18;
  double f_sm = 16;

  // Gaps
  SizedBox v_gap_xs = SizedBox(
    height: 5,
  );
  SizedBox v_gap_sm = SizedBox(
    height: 10,
  );
  SizedBox v_gap_md = SizedBox(
    height: 20,
  );
  // Shapes
  RoundedRectangleBorder rounded_xs = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(5.0),
  );
  RoundedRectangleBorder rounded_md = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10.0),
  );
  RoundedRectangleBorder rounded_lg = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(50.0),
  );
  RoundedRectangleBorder rounded_xl = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(100.0),
  );

  // Version
  String version = '2.4.6(202210222034)';
  // Button
  TextStyle buttonTextStyle = TextStyle(
      color: Color(0xFF2FB1A8), fontWeight: FontWeight.normal, fontSize: 18);

  String mapStyles = '''[
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
