import 'package:flutter/material.dart';

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
                onPressed: () {})
          ],
        ),
      ),
    );
  }
}
