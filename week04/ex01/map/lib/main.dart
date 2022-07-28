import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

import 'dart:ffi';
import 'dart:async';

import 'package:map/db/db_helper.dart';
import 'package:map/db/locate_model.dart';
import 'package:map/auth/secret.dart';

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
  int idx = 0; // db에 저장할 id, 1씩 늘려주면서 사용할 것이다.
  int markeridx = 1;
  Completer<GoogleMapController> myController = Completer();
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;

  // 초기 카메라 위치
  static CameraPosition kAnyang = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.4108359, 126.9123497),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  // currentPosition의 초기 값을 지정해주기 위함.
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
        markers: _markers,
        //polylines: _polylines,
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
    _markers.add(Marker(
      markerId: MarkerId(markeridx.toString()),
      position: LatLng(currentPosition.latitude, currentPosition.longitude),
    ));
    save(currentPosition);
    markeridx++;
  }

  Future<void> save(dynamic currentPosition) async {
    DBHelper hp = DBHelper();
    var time = DateTime.now();
    var locate = Location(
      id: idx++,
      year: time.year,
      month: time.month,
      day: time.day,
      hour: time.hour,
      minute: time.minute,
      latitude: currentPosition.latitude,
      longitude: currentPosition.longitude,
    );
    await hp.insertLocate(locate);
  }

  setPolylines() async {
    var locationList = await DBHelper().getAllLocation();
    if (locationList.length < 1) return ;
    List<PointLatLng> result = await polylinePoints?.getRouteBetweenCoordinates(
        '$androidgoogleMapApiKey',
        (SOURCE_LOCATION.latitude,
        SOURCE_LOCATION.longitude),
        (DEST_LOCATION.latitude,
        DEST_LOCATION.longitude));
    if (result.isNotEmpty) {
      // loop through all PointLatLng points and convert them
      // to a list of LatLng, required by the Polyline
      result.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    setState(() {
      // create a Polyline instance
      // with an id, an RGB color and the list of LatLng pairs
      Polyline polyline = Polyline(
          polylineId: PolylineId('poly'),
          color: Color.fromARGB(255, 40, 122, 198),
          points: polylineCoordinates);

      // add the constructed polyline as a set of points
      // to the polyline set, which will eventually
      // end up showing up on the map
      _polylines.add(polyline);
    });
  }
}
