import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

class NetworkImageCustomMarker extends StatefulWidget {
  const NetworkImageCustomMarker({Key? key}) : super(key: key);

  @override
  _NetworkImageCustomMarkerState createState() =>
      _NetworkImageCustomMarkerState();
}

class _NetworkImageCustomMarkerState extends State<NetworkImageCustomMarker> {
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _kGooglePlex =
      const CameraPosition(target: LatLng(24.798539, 67.135653), zoom: 14);

  final List<Marker> _markers = <Marker>[];

  List<LatLng> _latlng = [
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
    loadData();
  }

  loadData() async {
    for (int i = 0; i < _latlng.length; i++) {
      Uint8List? image = await loadNetworkImage(
          'https://images.pexels.com/photos/1681010/pexels-photo-1681010.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1');

      final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
        image!.buffer.asUint8List(),
        targetHeight: 100,
        targetWidth: 100,
      );
      final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();
      final ByteData? byteData = await frameInfo.image.toByteData(
        format: ui.ImageByteFormat.png,
      );

      final Uint8List resizedImageMarker = byteData!.buffer.asUint8List();
      _markers.add(Marker(
        markerId: MarkerId(i.toString()),
        icon: BitmapDescriptor.fromBytes(resizedImageMarker),
        infoWindow: InfoWindow(title: 'Marker Id: ' + i.toString()),
        position: _latlng[i],
      ));
      setState(() {});
    }
  }

  Future<Uint8List?> loadNetworkImage(String path) async {
    final completer = Completer<ImageInfo>();
    var image = NetworkImage(path);

    image.resolve(ImageConfiguration()).addListener(
        ImageStreamListener((info, _) => completer.complete(info)));
    final imageInfo = await completer.future;

    final byteData =
        await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Custom Image Marker'),
        centerTitle: false,
        backgroundColor: Colors.blue,
      ),
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        mapType: MapType.normal,
        markers: Set<Marker>.of(_markers),
        myLocationButtonEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
