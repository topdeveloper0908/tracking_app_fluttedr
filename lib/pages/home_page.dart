import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:tracking/widgets/nav-drawer.dart';

void main() => runApp(const HomePage());

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: const Color(0xFF2FB1A8),
      ),
      home: MyHomePage(),
    );
  }
}

// ignore: use_key_in_widget_constructors
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return new WillPopScope(
            child: Scaffold(
                drawer: NavDrawer(),
                appBar: AppBar(
                  backgroundColor: const Color(0xFF2FB1A8),
                  title: const Text('Homeage'),
                ),
                body: const GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(37.7749, -122.4194),
                    zoom: 12,
                  ),
                )),
            onWillPop: () => Future.value(false));
      },
    );
  }
}
