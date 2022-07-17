import 'dart:io';
import 'dart:async';
import 'dart:convert';

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
      return '글이 없습니다.';
    }
  }

  Future<File> writeStorage(Future<File> fileName, String content) async {
    final file = await fileName;
    return file.writeAsString('$content\n', mode: FileMode.append);
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
  String titleData = '';
  String contentData = '';
  Future<File> _saveTitle() {
    Future<File> title = widget.storage._localTitle;
    return widget.storage.writeStorage(title, titleData);
  }

  Future<File> _saveContent() {
    Future<File> content = widget.storage._localContent;
    return widget.storage.writeStorage(content, contentData);
  }

  void btnPressed() {
    setState(() {
      titleData += controllerTitle.text;
      contentData += controllerContent.text;
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
                        child: const Text('완료'),
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
  late Future<List<String>> title;
  late Future<List<String>> content;
  late List<Widget> lst;

  @override
  void initState() {
    super.initState();
    title = readTitle();
    content = readContent();
  }

  Future<List<String>> readTitle() async {
    List<String> tmp = [];
    File title = await widget.storage._localTitle;
    title
        .openRead()
        .map(utf8.decode)
        .transform(const LineSplitter())
        .forEach((l) => tmp.add(l));
    print('title ok');
    return (tmp);
  }

  Future<List<String>> readContent() async {
    List<String> tmp = [];
    File content = await widget.storage._localContent;
    content
        .openRead()
        .map(utf8.decode)
        .transform(const LineSplitter())
        .forEach((l) => tmp.add(l));
    print('content ok');
    return (tmp);
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
                future: Future.wait([title, content]),
                builder: (BuildContext context,
                    AsyncSnapshot<List<List<String>>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.none) {
                    return customTextBox(
                      title: 'FutureBuilder Error\n',
                      content: ' ',
                    );
                  } else if (snapshot.hasData == false) {
                    return (customTextBox(
                        content: '내용이 없습니다.', title: '내용이 없습니다.\n'));
                  } else {
                    int i = 0;
                    while (i < snapshot.data![0].length + 1) {
                      lst[i] = customTextBox(
                        title: snapshot.data![0][i],
                        content: snapshot.data![1][i],
                      );
                      i++;
                    }
                    return Column(
                      children: lst,
                    );
                  }
                },
              )
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
