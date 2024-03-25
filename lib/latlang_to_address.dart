import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class LatlangToAddress extends StatefulWidget {
  const LatlangToAddress({Key? key}) : super(key: key);

  @override
  _LatlangToAddressState createState() => _LatlangToAddressState();
}

class _LatlangToAddressState extends State<LatlangToAddress> {
  String stAddress = '', stAdd = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(stAddress),
          Text(stAdd),
          Center(
            child: GestureDetector(
              onTap: () async {
                //final query = "1600 Amphiteatre Parkway, Mountain View";
                List<Location> locations =
                    await locationFromAddress("Gronausestraat 710, Enschede");
                List<Placemark> placemarks =
                    await placemarkFromCoordinates(52.2165157, 6.9437819);

                setState(() {
                  stAddress = locations.last.latitude.toString() +
                      " " +
                      locations.last.longitude.toString();
                  stAdd = placemarks.reversed.last.street.toString();
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(255, 131, 221, 200),
                ),
                height: 35,
                width: 80,
                child: const Center(
                  child: Text('Convert'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
