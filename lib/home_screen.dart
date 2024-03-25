import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Completer<GoogleMapController> _controller = Completer();
  static const _initialCameraPosition =
      CameraPosition(target: LatLng(24.861082, 67.036774), zoom: 11);

  List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(24.861082, 67.036774),
      infoWindow: InfoWindow(title: 'My Location'),
    ),
    Marker(
      markerId: MarkerId('2'),
      position: LatLng(24.860966, 66.990501),
      infoWindow: InfoWindow(title: 'Second location'),
    ),
    Marker(
      markerId: MarkerId('3'),
      position: LatLng(24.860735, 67.001137),
      infoWindow: InfoWindow(title: 'My Location'),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          myLocationButtonEnabled: true,
          mapType: MapType.hybrid,
          markers: Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          initialCameraPosition: _initialCameraPosition,
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.location_disabled_outlined),
          onPressed: () async {
            GoogleMapController controller = await _controller.future;
            controller.animateCamera((CameraUpdate.newCameraPosition(
              CameraPosition(
                  target: const LatLng(24.860966, 66.990501), zoom: 14),
            )));
            setState(() {});
          }),
    );
  }
}
