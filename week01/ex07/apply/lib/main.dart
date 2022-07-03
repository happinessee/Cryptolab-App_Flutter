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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(5),
            ),
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: RichText(
                text: const TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(Icons.check_circle),
                    ),
                    TextSpan(
                      text: '제목1\n',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    WidgetSpan(
                      child: SizedBox(
                        width: 25,
                      ),
                    ),
                    TextSpan(
                      text: '내용>.<\n',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                    WidgetSpan(
                      child: SizedBox(
                        width: 25,
                      ),
                    ),
                    TextSpan(
                      text: '내용^*^',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(5),
            ),
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: RichText(
                text: const TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(Icons.check_circle),
                    ),
                    TextSpan(
                      text: '제목2\n',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    WidgetSpan(
                      child: SizedBox(
                        width: 25,
                      ),
                    ),
                    TextSpan(
                      text: '내용>.<\n',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                    WidgetSpan(
                      child: SizedBox(
                        width: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(5),
            ),
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: RichText(
                text: const TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(Icons.check_circle),
                    ),
                    TextSpan(
                      text: '제목3\n',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    WidgetSpan(
                      child: SizedBox(
                        width: 25,
                      ),
                    ),
                    TextSpan(
                      text: '내용>.<\n',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                    WidgetSpan(
                      child: SizedBox(
                        width: 25,
                      ),
                    ),
                    TextSpan(
                      text: '내용^*^',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(5),
            ),
            margin: const EdgeInsets.all(15),
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: RichText(
                text: const TextSpan(
                  children: [
                    WidgetSpan(
                      child: Icon(Icons.check_circle),
                    ),
                    TextSpan(
                      text: '제목4\n',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    WidgetSpan(
                      child: SizedBox(
                        width: 25,
                      ),
                    ),
                    TextSpan(
                      text: '내용>.<\n',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                    WidgetSpan(
                      child: SizedBox(
                        width: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
