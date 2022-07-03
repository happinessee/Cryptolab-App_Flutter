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
      home: const MyHomePage(title: 'happi!'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final isSelected = <bool>[false, false, false];

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

class _MyHomePageState1 extends State<MyHomePage> {
  final isSelected = <bool>[false, false, false];

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
