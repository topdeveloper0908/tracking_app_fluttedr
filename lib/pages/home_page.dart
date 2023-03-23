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
        primarySwatch: Colors.green,
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
        return Scaffold(
            drawer: NavDrawer(),
            appBar: AppBar(
                centerTitle: true,
                title: Row(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const Text('Homeage'),
                  ],
                )),
            body: const GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(37.7749, -122.4194),
                zoom: 12,
              ),
            ));
      },
    );
  }
}
