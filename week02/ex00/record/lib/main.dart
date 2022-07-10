import 'package:flutter/material.dart';
import 'package:record/customToggleBtn.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  child: Text(
                    '1',
                    style: TextStyle(fontSize: 50),
                  ),
                ),
              ]),
              Container(
                child: SizedBox(
                  height: 180,
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  child: Text(
                    '하나',
                    style: TextStyle(fontSize: 120),
                  ),
                ),
              ])
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
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  child: Text(
                    '2',
                    style: TextStyle(fontSize: 50),
                  ),
                ),
              ]),
              Container(
                child: SizedBox(
                  height: 180,
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  child: Text(
                    '둘',
                    style: TextStyle(fontSize: 120),
                  ),
                ),
              ])
            ],
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
