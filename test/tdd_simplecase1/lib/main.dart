import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:async';

void main() {
  runApp(HomePage());
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('test'),
          leading: const Icon(Icons.save),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Center(child: Text('test용 앱입니다.')),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton.icon(
                icon: const Icon(Icons.dangerous),
                label: const Text('happy'),
                onPressed: sendMessage)
          ],
        ),
      ),
    );
  }

  Future<void> sendMessage() async {
    if (!await launchUrl(Uri.parse(
        'sms:+821095720542?body=지금 접근금지명령을 받은 종현님이 효혁님에게 100m 내로 접근해 위험한 상황입니다. 현재 위치는 서울대학교 25동 입니다.'))) {
      throw ('Could not launch this');
    }
  }
}

//import 'dart:async';
//import 'dart:convert';

//import 'package:flutter/material.dart';
//import 'package:http/http.dart' as http;

//Future<Album> fetchAlbum(http.Client client) async {
//  final response = await client
//      .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1'));

//  if (response.statusCode == 200) {
//    // If the server did return a 200 OK response,
//    // then parse the JSON.
//    return Album.fromJson(jsonDecode(response.body));
//  } else {
//    // If the server did not return a 200 OK response,
//    // then throw an exception.
//    throw Exception('Failed to load album');
//  }
//}

//class Album {
//  final int userId;
//  final int id;
//  final String title;

//  const Album({required this.userId, required this.id, required this.title});

//  factory Album.fromJson(Map<String, dynamic> json) {
//    return Album(
//      userId: json['userId'],
//      id: json['id'],
//      title: json['title'],
//    );
//  }
//}

//void main() => runApp(const MyApp());

//class MyApp extends StatefulWidget {
//  const MyApp({super.key});

//  @override
//  State<MyApp> createState() => _MyAppState();
//}

//class _MyAppState extends State<MyApp> {
//  late final Future<Album> futureAlbum;

//  @override
//  void initState() {
//    super.initState();
//    futureAlbum = fetchAlbum(http.Client());
//  }

//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      title: 'Fetch Data Example',
//      theme: ThemeData(
//        primarySwatch: Colors.blue,
//      ),
//      home: Scaffold(
//        appBar: AppBar(
//          title: const Text('Fetch Data Example'),
//        ),
//        body: Center(
//          child: FutureBuilder<Album>(
//            future: futureAlbum,
//            builder: (context, snapshot) {
//              if (snapshot.hasData) {
//                return Text(snapshot.data!.title);
//              } else if (snapshot.hasError) {
//                return Text('${snapshot.error}');
//              }

//              // By default, show a loading spinner.
//              return const CircularProgressIndicator();
//            },
//          ),
//        ),
//      ),
//    );
//  }
//}
