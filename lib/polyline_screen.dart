import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:flutter/material.dart';

class PolylineScreen extends StatefulWidget {
  const PolylineScreen({Key? key}) : super(key: key);

  @override
  _PolylineScreenState createState() => _PolylineScreenState();
}

class _PolylineScreenState extends State<PolylineScreen> {
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _kGooglePlex =
      const CameraPosition(target: LatLng(24.798539, 67.135653), zoom: 14);
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyLine = {};

  List<LatLng> latlng = [
    const LatLng(24.793537, 67.136137),
    const LatLng(24.796920, 67.140549),
    const LatLng(24.792234, 67.144925),
    const LatLng(24.788067, 67.130320),
    const LatLng(24.793537, 67.136137),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (int i = 0; i < latlng.length; i++) {
      _markers.add(Marker(
        markerId: MarkerId(i.toString()),
        position: latlng[i],
        infoWindow: InfoWindow(title: 'A point', snippet: '5 star rating'),
        icon: BitmapDescriptor.defaultMarker,
      ));
      setState(() {});
      _polyLine.add(Polyline(
        polylineId: PolylineId('1'),
        color: Colors.orange,
        points: latlng,
        width: 3,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Polyline Screen'),
      ),
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        markers: _markers,
        mapType: MapType.normal,
        polylines: _polyLine,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
