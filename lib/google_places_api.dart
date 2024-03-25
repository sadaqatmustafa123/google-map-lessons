import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GooglePlacesApi extends StatefulWidget {
  const GooglePlacesApi({Key? key}) : super(key: key);

  @override
  _GooglePlacesApiState createState() => _GooglePlacesApiState();
}

class _GooglePlacesApiState extends State<GooglePlacesApi> {
  TextEditingController _textEditingController = TextEditingController();
  var uuid = const Uuid();
  String _sessionToken = '123456789';

  List <dynamic> = _placesList = []; 

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _textEditingController.addListener(() {
      onChange();
    });
  }

  void onChange() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggesion(_textEditingController.text);
  }

  void getSuggesion(String input) async {
    String kPLACES_API_KEY = "AIzaSyAA2Bcb609GfT3iicTOx2-YA2mtRrI9Q6o";
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACES_API_KEY&sessiontoken=$_sessionToken';

    var response = await http.get(Uri.parse(request));
    var data = response.body.toString();
    
    print(response.body.toString());
    if (response.statusCode = 200) {
      setState(() {
        _placesList = jsonDecode(response.body.toString() ['predictions']);
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueAccent,
          title: const Text('Google Maps API'),
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Column(
            children: [
              TextFormField(
                controller: _textEditingController,
                decoration:
                    InputDecoration(hintText: ('Search places with name')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
