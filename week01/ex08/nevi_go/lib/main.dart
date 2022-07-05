import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'nevi_go!',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const MyHomePage(),
          '/first': (context) => const MyHomePage2(),
          '/second': (context) => const MyHomePage3(),
        });
  }
}

// TODO : 버튼 클래스화 시켜서 코드 간편하게 만들기, 방안 생각하기.
class MyHomePage3 extends StatefulWidget {
  const MyHomePage3({Key? key, title = 'screen3'}) : super(key: key);

  @override
  State<MyHomePage3> createState() => _MyHomePageState3();
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
  final isSelected = <bool>[true, false, false];
  int flag = 1;
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
                  Container(
                    margin: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: ToggleButtons(
                      disabledColor: Colors.white,
                      renderBorder: false,
                      borderRadius: BorderRadius.circular(10),
                      borderWidth: 0,
                      borderColor: Colors.white,
                      selectedBorderColor: Colors.white,
                      fillColor: Colors.white,
                      color: Colors.grey,
                      selectedColor: Colors.black,
                      children: [
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 35),
                            child: Text(
                              '1',
                              style: TextStyle(
                                fontFamily: 'summer',
                                fontSize: 24,
                              ),
                            )),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 35),
                          child: Text(
                            '2',
                            style: TextStyle(
                              fontFamily: 'summer',
                              fontSize: 24,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 35),
                          child: Text(
                            '3',
                            style: TextStyle(
                              fontFamily: 'summer',
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ],
                      isSelected: isSelected,
                      onPressed: (index) {
                        setState(() {
                          isSelected[index] = !isSelected[index];
                          if (isSelected[0] && flag != 1) {
                            Navigator.popAndPushNamed(context, '/');
                            isSelected[1] = false;
                            isSelected[2] = false;
                          } else if (isSelected[1]) {
                            Navigator.popAndPushNamed(context, '/first');
                            isSelected[0] = false;
                            isSelected[2] = false;
                          } else if (isSelected[2]) {
                            Navigator.popAndPushNamed(context, '/second');
                            isSelected[0] = false;
                            isSelected[1] = false;
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MyHomePageState2 extends State<MyHomePage2> {
  final isSelected = <bool>[false, true, false];
  int flag = 2;

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
                  Container(
                    margin: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: ToggleButtons(
                      disabledColor: Colors.white,
                      renderBorder: false,
                      borderRadius: BorderRadius.circular(10),
                      borderWidth: 0,
                      borderColor: Colors.white,
                      selectedBorderColor: Colors.white,
                      fillColor: Colors.white,
                      color: Colors.grey,
                      selectedColor: Colors.black,
                      children: [
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 35),
                            child: Text(
                              '1',
                              style: TextStyle(
                                fontFamily: 'summer',
                                fontSize: 24,
                              ),
                            )),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 35),
                          child: Text(
                            '2',
                            style: TextStyle(
                              fontFamily: 'summer',
                              fontSize: 24,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 35),
                          child: Text(
                            '3',
                            style: TextStyle(
                              fontFamily: 'summer',
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ],
                      isSelected: isSelected,
                      onPressed: (index) {
                        setState(() {
                          isSelected[index] = !isSelected[index];
                          if (isSelected[0]) {
                            Navigator.popAndPushNamed(context, '/');
                            isSelected[1] = false;
                            isSelected[2] = false;
                          } else if (isSelected[1] && flag != 2) {
                            Navigator.popAndPushNamed(context, '/first');
                            isSelected[0] = false;
                            isSelected[2] = false;
                          } else if (isSelected[2]) {
                            Navigator.popAndPushNamed(context, '/second');
                            isSelected[0] = false;
                            isSelected[1] = false;
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MyHomePageState3 extends State<MyHomePage3> {
  final isSelected = <bool>[false, false, true];
  int flag = 3;
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
                    '3',
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
                    '셋',
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
                  Container(
                    margin: EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(5),
                      ),
                    ),
                    child: ToggleButtons(
                      disabledColor: Colors.white,
                      renderBorder: false,
                      borderRadius: BorderRadius.circular(10),
                      borderWidth: 0,
                      borderColor: Colors.white,
                      selectedBorderColor: Colors.white,
                      fillColor: Colors.white,
                      color: Colors.grey,
                      selectedColor: Colors.black,
                      children: [
                        const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 35),
                            child: Text(
                              '1',
                              style: TextStyle(
                                fontFamily: 'summer',
                                fontSize: 24,
                              ),
                            )),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 35),
                          child: Text(
                            '2',
                            style: TextStyle(
                              fontFamily: 'summer',
                              fontSize: 24,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 35),
                          child: Text(
                            '3',
                            style: TextStyle(
                              fontFamily: 'summer',
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ],
                      isSelected: isSelected,
                      onPressed: (index) {
                        setState(() {
                          isSelected[index] = !isSelected[index];
                          if (isSelected[0]) {
                            Navigator.popAndPushNamed(context, '/');
                            isSelected[1] = false;
                            isSelected[2] = false;
                          } else if (isSelected[1]) {
                            Navigator.popAndPushNamed(context, '/first');
                            isSelected[0] = false;
                            isSelected[2] = false;
                          } else if (isSelected[2] && flag != 3) {
                            Navigator.popAndPushNamed(context, '/second');
                            isSelected[0] = false;
                            isSelected[1] = false;
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
