import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:intl/intl.dart';
import 'package:path/path.dart';

import 'package:background_locator_2/auto_stop_handler.dart';
import 'package:background_locator_2/background_locator.dart';
import 'package:background_locator_2/callback_dispatcher.dart';
import 'package:background_locator_2/keys.dart';
import 'package:background_locator_2/location_dto.dart';
import 'package:background_locator_2/settings/android_settings.dart'
    as andSetting;
import 'package:background_locator_2/settings/ios_settings.dart';
import 'package:background_locator_2/settings/locator_settings.dart'
    as locAccuracy;
import 'package:background_locator_2/utils/settings_util.dart';

import 'dart:ffi';
import 'dart:async';
import 'dart:io' show Platform;
import 'dart:isolate';
import 'dart:ui';

import 'package:map/db/db_helper.dart';
import 'package:map/db/locate_model.dart';
import 'package:map/auth/secret.dart';
import 'package:map/location_callback_handler.dart';
import 'package:map/location_service_repository.dart';

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
      home: Maps(),
    );
  }
}

class Maps extends StatefulWidget {
  MapState createState() => MapState();
}

class MapState extends State<Maps> {
  var month = DateTime.now().month;
  var day = DateTime.now().day;
  var currentPosition;
  int idx = 101010;
  int markeridx = 1;
  int polylineidx = 1;
  Completer<GoogleMapController> myController = Completer();
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = Set<Polyline>();
  final isSelected = <bool>[false, false, false];

  static const String _isolateName = "LocatorIsolate";
  ReceivePort port = ReceivePort();

  // 초기 카메라 위치
  static CameraPosition kAnyang = const CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.488163, 127.064671),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  // currentPosition의 초기 값을 지정해주기 위함.
  @override
  initState() {
    super.initState();
    getCurrentLocation();
    initMarker();
    initPolyline();
    initPlatformState();
    startLocationService();
  }

  Future<void> initPlatformState() async {
    await BackgroundLocator.initialize();
  }

  static void callback(LocationDto locationDto) async {
    final SendPort? send = IsolateNameServer.lookupPortByName(_isolateName);
    send?.send(locationDto);
  }

  //Optional
  static void notificationCallback() {
    print('User clicked on the notification');
  }

  void startLocationService() {
    Map<String, dynamic> data = {'countInit': 1};
    BackgroundLocator.registerLocationUpdate(
      LocationCallbackHandler.callback,
      initCallback: LocationCallbackHandler.initCallback,
      initDataCallback: data,
      disposeCallback: LocationCallbackHandler.disposeCallback,
      autoStop: false,
      iosSettings: const IOSSettings(
        accuracy: locAccuracy.LocationAccuracy.NAVIGATION,
        distanceFilter: 0,
      ),
      androidSettings: const andSetting.AndroidSettings(
        accuracy: locAccuracy.LocationAccuracy.NAVIGATION,
        interval: 300,
        distanceFilter: 0,
        androidNotificationSettings: andSetting.AndroidNotificationSettings(
          notificationChannelName: 'Location tracking',
          notificationTitle: 'Start Location Tracking',
          notificationMsg: 'Track location in background',
          notificationBigMsg:
              'Background location is on to keep the app up-tp-date with your location. This is required for main features to work properly when the app is not running.',
          notificationIcon: '',
          notificationIconColor: Colors.grey,
          notificationTapCallback: LocationCallbackHandler.notificationCallback,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GoogleMap(
            mapType: MapType.hybrid,
            initialCameraPosition: kAnyang,
            onMapCreated: (GoogleMapController controller) {
              myController.complete(controller);
            },
            markers: _markers,
            polylines: _polylines,
          ),
          Container(
            margin: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ToggleButtons(
              isSelected: isSelected,
              onPressed: (int index) {
                setState(() {
                  isSelected[index] = !isSelected[index];
                  if (isSelected[0]) {
                    day -= 1;
                    if (day <= 0) {
                      month -= 1;
                      day = 31;
                    }
                    isSelected[0] = false;
                  } else if (isSelected[2]) {
                    day += 1;
                    if (day >= 32) {
                      month += 1;
                      day = 1;
                    }
                    isSelected[1] = false;
                  }
                  initMarker();
                  initPolyline();
                });
              },
              color: Colors.grey,
              disabledColor: Colors.white,
              renderBorder: false,
              borderWidth: 0,
              borderColor: Colors.white,
              selectedColor: Colors.black,
              borderRadius: BorderRadius.circular(10),
              fillColor: Colors.white,
              selectedBorderColor: Colors.white,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Icon(Icons.arrow_back),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    '$month월 $day일',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          changeCamera();
        },
        label: const Text(''),
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

  // db에서 위치정보를 불러와 앱 처음 시작할때도 marker를 찍어주기 위한 함수
  initMarker() async {
    var locationList = await getDayLocation();
    print('marker, locationlength: ${locationList.length}');
    if (locationList.isEmpty) return;
    setState(() {
      _markers.clear();
      for (int i = 0; i < locationList.length; i++) {
        _markers.add(Marker(
          markerId: MarkerId((i).toString()),
          position: LatLng(locationList[i].latitude, locationList[i].longitude),
        ));
      }
    });
  }

  getDayLocation() async {
    var locationList = await DBHelper().getAllLocation();
    List<Location> dayLocation = [];
    if (locationList.isEmpty) return;
    for (int i = 0; i < locationList.length; i++) {
      if (locationList[i].day == day && locationList[i].month == month) {
        dayLocation.add(locationList[i]);
      }
    }
    print('dayLocation length: ${dayLocation.length}');
    return dayLocation;
  }

  // db에서 위치정보를 불러와 앱이 처음 시작할 때 polyline을 그려주기 위한 함수이다.
  initPolyline() async {
    var locationList = await getDayLocation();
    List<LatLng> loc = [];
    print('polyline, locationlength: ${locationList.length}');
    if (locationList.isEmpty) return;
    if (locationList.length < 2) return;
    for (int i = 0; i < locationList.length - 1; i++) {
      loc.add(LatLng(locationList[i].latitude, locationList[i].longitude));
    }
    setState(() {
      _polylines.add(Polyline(
        polylineId: PolylineId((polylineidx).toString()),
        points: loc,
        color: Colors.lightBlue,
      ));
    });
  }

  changeCamera() async {
    getCurrentLocation();
    GoogleMapController controller = await myController.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(currentPosition.latitude, currentPosition.longitude),
          zoom: 30,
        ),
      ),
    );
    _markers.add(Marker(
      markerId: MarkerId(markeridx.toString()),
      position: LatLng(currentPosition.latitude, currentPosition.longitude),
    ));
    save(currentPosition.latitude, currentPosition.longitude);
    markeridx++;
    initPolyline();
  }

  Future<void> save(dynamic lat, dynamic lot) async {
    print('id: ${DateTime.now().millisecondsSinceEpoch ~/ 1000}');
    DBHelper hp = DBHelper();
    var time = DateTime.now();
    var locate = Location(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      year: time.year,
      month: time.month,
      day: time.day,
      hour: time.hour,
      minute: time.minute,
      latitude: lat,
      longitude: lot,
    );

    await hp.insertLocate(locate);
  }
}
