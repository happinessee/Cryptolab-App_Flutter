import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:ffi';
import 'dart:async';

void main() async {
  // apiKey의 호출을 위함.
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  //var currentLocationAddress;
  Completer<GoogleMapController> myController = Completer();

  static CameraPosition kAnyang = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.4108359, 126.9123497),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: kAnyang,
        onMapCreated: (GoogleMapController controller) {
          myController.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          changeCamera();
        },
        label: const Text('current My location'),
        icon: const Icon(Icons.gps_fixed),
      ),
    );
  }

  getCurrentLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        currentPosition = position;
        //getCurrentLocationAddress();
      });
    }).catchError((e) {
      print(e);
    });
  }

  changeCamera() async {
    getCurrentLocation();
    GoogleMapController controller = await myController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(currentPosition.latitude, currentPosition.longitude),
          zoom: 14.4746,
        ),
      ),
    );
  }

  //getCurrentLocationAddress() async {
  //  try {
  //    List<Placemark> listPlaceMarks = await placemarkFromCoordinates(
  //        currentPosition.latitude, currentPosition.longitude);
  //    Placemark place = listPlaceMarks[0];

  //    setState(() {
  //      currentLocationAddress =
  //          '${place.locality}, ${place.postalCode}, ${place.country}';
  //    });
  //  } catch (e) {
  //    print(e);
  //  }
  //}
}

//import 'dart:async';

//import 'package:flutter/material.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';

//void main() => runApp(MyApp());

//class MyApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Flutter Google Maps Demo',
//      home: MapSample(),
//    );
//  }
//}

//class MapSample extends StatefulWidget {
//  @override
//  State<MapSample> createState() => MapSampleState();
//}

//class MapSampleState extends State<MapSample> {
//  Completer<GoogleMapController> _controller = Completer();

//  static final CameraPosition _kGooglePlex = CameraPosition(
//    target: LatLng(37.42796133580664, -122.085749655962),
//    zoom: 14.4746,
//  );

//  static final CameraPosition _kLake = CameraPosition(
//      bearing: 192.8334901395799,
//      target: LatLng(37.43296265331129, -122.08832357078792),
//      tilt: 59.440717697143555,
//      zoom: 19.151926040649414);

//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      body: GoogleMap(
//        mapType: MapType.hybrid,
//        initialCameraPosition: _kGooglePlex,
//        onMapCreated: (GoogleMapController controller) {
//          _controller.complete(controller);
//        },
//      ),
//      floatingActionButton: FloatingActionButton.extended(
//        onPressed: _goToTheLake,
//        label: Text('To the lake!'),
//        icon: Icon(Icons.directions_boat),
//      ),
//    );
//  }

//  Future<void> _goToTheLake() async {
//    final GoogleMapController controller = await _controller.future;
//    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
//  }
//}
