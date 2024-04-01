import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemap/custom_marker_info_window.dart';
import 'package:googlemap/network_image_custom_marker.dart';
import 'package:googlemap/polygone_screen.dart';
import 'package:googlemap/polyline_screen.dart';
import 'package:googlemap/style_google_map.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Google Maps',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const StyleGoogleMap(),
    );
  }
}
