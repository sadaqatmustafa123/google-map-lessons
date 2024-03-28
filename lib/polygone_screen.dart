import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:collection';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygoneScreen extends StatefulWidget {
  const PolygoneScreen({Key? key}) : super(key: key);

  @override
  _PolygoneScreenState createState() => _PolygoneScreenState();
}

class _PolygoneScreenState extends State<PolygoneScreen> {
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _kGooglePlex =
      const CameraPosition(target: LatLng(24.798539, 67.135653), zoom: 14);

  Set<Polygon> _polygon = HashSet<Polygon>();

  List<LatLng> points = [
    const LatLng(24.793537, 67.136137),
    const LatLng(24.796920, 67.140549),
    const LatLng(24.801212, 67.140549),
    //const LatLng(24.793537, 67.136137),
  ];

  @override
  void initState() {
    super.initState();
    _polygon.add(
      Polygon(
        polygonId: const PolygonId('1'),
        points: points,
        fillColor: Colors.red.withOpacity(0.1),
        strokeColor: Colors.deepOrange,
        strokeWidth: 2,
        geodesic: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Polygon'),
      ),
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        polygons: _polygon,
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
