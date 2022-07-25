import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_config/flutter_config.dart';
import 'dart:ffi';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geolocation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Map(),
    );
  }
}

class Map extends StatefulWidget {
  MapState createState() => MapState();
}

class MapState extends State<Map> {
  var currentPosition;
  var currentLocationAddress;
  var apiKey = FlutterConfig.get('apiKey');

  @override
  initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (currentPosition != null)
            Text(
              'LAT: ${currentPosition.latitude}',
              style: TextStyle(fontSize: 23),
            ),
          SizedBox(height: 15),
          if (currentPosition != null)
            Text(
              'LONG: ${currentPosition.longitude}',
              style: TextStyle(fontSize: 23),
            ),
          SizedBox(height: 15),
          if (currentLocationAddress != null)
            Text(
              currentLocationAddress,
              style: TextStyle(fontSize: 23),
            ),
          SizedBox(height: 25),
          ElevatedButton(
            child: Text('Get Current Location',
                style: TextStyle(fontSize: 22, color: Colors.white)),
            onPressed: () {
              getCurrentLocation();
            },
            style: ElevatedButton.styleFrom(primary: Colors.red),
          ),
        ],
      ),
    ));
  }

  getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        currentPosition = position;
        getCurrentLocationAddress();
      });
    }).catchError((e) {
      print(e);
    });
  }

  getCurrentLocationAddress() async {
    try {
      List<Placemark> listPlaceMarks = await placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);
      Placemark place = listPlaceMarks[0];

      setState(() {
        currentLocationAddress =
            '${place.locality}, ${place.postalCode}, ${place.country}';
      });
    } catch (e) {
      print(e);
    }
  }
}
