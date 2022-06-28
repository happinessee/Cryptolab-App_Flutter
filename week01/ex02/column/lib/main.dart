import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '코동이'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: const Text(
            '코동이',
            style: TextStyle(color: Colors.black, fontFamily: 'summer'),
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.error,
                color: Colors.black,
              ),
              onPressed: () => {},
            ),
          ],
        ),
        body: Column(children: [
          Container(
            color: Colors.red,
            height: 70,
          ),
          Container(
            color: Colors.green,
            height: 70,
          ),
          Container(
            color: Colors.blue,
            height: 70,
          ),
        ]));
  }
}
