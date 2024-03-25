import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetUserLocation extends StatefulWidget {
  const GetUserLocation({Key? key}) : super(key: key);

  @override
  _GetUserLocationState createState() => _GetUserLocationState();
}

class _GetUserLocationState extends State<GetUserLocation> {
  final Completer<GoogleMapController> _controller = Completer();

  static const _initialCameraPosition =
      CameraPosition(target: LatLng(24.861082, 67.036774), zoom: 11);

  final List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(24.861082, 67.036774),
      infoWindow: InfoWindow(title: 'My Location'),
    )
  ];

  Future<Position> getUserLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      print('error' + error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        initialCameraPosition: _initialCameraPosition,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getUserLocation().then((value) async {
            print('My current location');
            print(value.latitude.toString() + " " + value.longitude.toString());
          });
        },
        child: const Icon(Icons.star),
      ),
    );
  }
}
