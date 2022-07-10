import 'dart:io';

import 'package:record/custom_togglebtn.dart';
import 'package:record/custom_textbox.dart';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'record',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const MyHomePage(),
          '/first': (context) => const MyHomePage2(),
        });
  }
}

class MyHomePage2 extends StatefulWidget {
  const MyHomePage2({Key? key, title = 'screen2'}) : super(key: key);

  @override
  State<MyHomePage2> createState() => _MyHomePageState2();
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, title = 'screen1'}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final isSelected = <bool>[true, false];
  int flag = 1;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(5),
                child: const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '제목',
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(5),
                child: const TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '내용',
                  ),
                  maxLines: 7,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(15),
                      child: ElevatedButton(
                        child: const Text('완료'),
                        onPressed: null,
                        style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all(Colors.purple),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ))),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  customToggleBtn1(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget customToggleBtn1() {
    return customToggleBtnWidget(
      onClick: (index) {
        setState(() {
          isSelected[index] = !isSelected[index];
        });
        if (isSelected[0] && flag != 1) {
          Navigator.popAndPushNamed(context, '/');
          isSelected[1] = false;
        } else if (isSelected[1]) {
          Navigator.popAndPushNamed(context, '/first');
          isSelected[0] = false;
        }
      },
      isSelected: isSelected,
    );
  }
}

class _MyHomePageState2 extends State<MyHomePage2> {
  final isSelected = <bool>[false, true];
  int flag = 2;
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  customToggleBtn2(),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget customToggleBtn2() {
    return (customToggleBtnWidget(
      onClick: (index) {
        setState(() {
          isSelected[index] = !isSelected[index];
        });
        if (isSelected[0]) {
          Navigator.popAndPushNamed(context, '/');
          isSelected[1] = false;
        } else if (isSelected[1] && flag != 2) {
          Navigator.popAndPushNamed(context, '/first');
          isSelected[0] = false;
        }
      },
      isSelected: isSelected,
    ));
  }
}
