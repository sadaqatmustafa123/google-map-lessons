import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class StyleGoogleMap extends StatefulWidget {
  const StyleGoogleMap({Key? key}) : super(key: key);

  @override
  _StyleGoogleMapState createState() => _StyleGoogleMapState();
}

class _StyleGoogleMapState extends State<StyleGoogleMap> {
  String mapTheme = '';
  final Completer<GoogleMapController> _controller = Completer();
  static const CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(24.798539, 67.135653), zoom: 14);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString('assets/theme/retro_theme.json')
        .then((value) {
      mapTheme = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Style Google Map',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          PopupMenuButton(
              iconColor: Colors.white,
              itemBuilder: (context) => [
                    PopupMenuItem(
                      onTap: () {
                        _controller.future.then((value) {
                          DefaultAssetBundle.of(context)
                              .loadString('assets/theme/silver_theme.json')
                              .then((string) {
                            // ignore: deprecated_member_use
                            value.setMapStyle(string);
                          });
                        });
                      },
                      child: const Text('Silver'),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        _controller.future.then((value) {
                          DefaultAssetBundle.of(context)
                              .loadString('assets/theme/retro_theme.json')
                              .then((string) {
                            // ignore: deprecated_member_use
                            value.setMapStyle(string);
                          });
                        });
                      },
                      child: const Text('Retro'),
                    ),
                    PopupMenuItem(
                      onTap: () {
                        _controller.future.then((value) {
                          DefaultAssetBundle.of(context)
                              .loadString('assets/theme/night_theme.json')
                              .then((string) {
                            // ignore: deprecated_member_use
                            value.setMapStyle(string);
                          });
                        });
                      },
                      child: const Text('Night'),
                    )
                  ])
        ],
        backgroundColor: Colors.blue,
      ),
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        myLocationButtonEnabled: true,
        myLocationEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          // ignore: deprecated_member_use
          controller.setMapStyle(mapTheme);
          _controller.complete(controller);
        },
      ),
    );
  }
}
