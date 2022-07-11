import 'dart:io';

import 'package:record/custom_togglebtn.dart';
import 'package:record/custom_textbox.dart';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class StorageFile {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localTitle async {
    final path = await _localPath;
    return File('$path/title.txt');
  }

  Future<File> get _localContent async {
    final path = await _localPath;
    return File('$path/content.txt');
  }

  Future<String> readStorage(Future<File> fileName) async {
    try {
      final file = await fileName;
      final contents = await file.readAsString();
      return contents;
    } catch (e) {
      return 'error';
    }
  }

  Future<File> writeStorage(Future<File> fileName, String content) async {
    final file = await fileName;
// 파일 쓰기
    return file.writeAsString(content);
  }
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
          '/': (context) => MyHomePage(
                storage: StorageFile(),
              ),
          '/first': (context) => MyHomePage2(
                storage: StorageFile(),
              ),
        });
  }
}

class MyHomePage2 extends StatefulWidget {
  const MyHomePage2({Key? key, title = 'screen2', required this.storage})
      : super(key: key);
  final StorageFile storage;
  @override
  State<MyHomePage2> createState() => _MyHomePageState2();
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, title = 'screen1', required this.storage})
      : super(key: key);
  final StorageFile storage;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final isSelected = <bool>[true, false];
  int flag = 1;
  int index = 0;

  late TextEditingController controllerTitle = TextEditingController();
  late TextEditingController controllerContent = TextEditingController();

  Future<File> _saveTitle() {
    Future<File> title = widget.storage._localTitle;
    return widget.storage.writeStorage(title, controllerTitle.text);
  }

  Future<File> _saveContent() {
    Future<File> content = widget.storage._localContent;
    return widget.storage.writeStorage(content, controllerContent.text);
  }

  String data = 'x';

  void btnPressed() {
    setState(() {
      _saveTitle();
      _saveContent();
    });
  }

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
                child: TextField(
                  controller: controllerTitle,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '제목',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(5),
                child: TextField(
                  controller: controllerContent,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '내용',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
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
                        onPressed: btnPressed,
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
  int count = 0;
  late Future<String> future;

  @override
  void initState() {
    super.initState();
    future = readTitle();
  }

  Future<String> readTitle() {
    Future<File> title = widget.storage._localTitle;
    return (widget.storage.readStorage(title));
  }

  Future<String> readTitleToString() async {
    final title = await readTitle();
    return title;
  }

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
              FutureBuilder(
                  future: future,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasData) {
                      return customTextBox(
                        title: '${snapshot.data.toString()}\n',
                        content: 'no...',
                      );
                    } else if (snapshot.hasData == false) {
                      return const Text('dont have data');
                    } else if (snapshot.hasError) {
                      return const Text('error');
                    } else {
                      return const Text('뭐지...');
                    }
                  })
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
