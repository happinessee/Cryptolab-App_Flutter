//import 'package:flutter_test/flutter_test.dart';
//import 'package:flutter/material.dart';
//import 'package:tdd_simplecase1/main.dart';

//void main() {
//  testWidgets('create homepage and AppBar', (tester) async {
//    final testWidget = HomePage();
//    await tester.pumpWidget(testWidget);
//    await tester.pumpAndSettle();
//    expect(find.widgetWithText(AppBar, 'test'), findsNWidgets(1));
//    expect(find.widgetWithIcon(AppBar, Icons.save), findsOneWidget);
//    expect(find.text('test용 앱입니다.'), findsOneWidget);
//    expect(find.widgetWithText(Column, 'happy'), findsOneWidget);
//    expect(find.widgetWithIcon(Column, Icons.dangerous), findsOneWidget);
//  });
//}

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_simplecase1/main.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'widget_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  group('fetchAlbum', () {
    test('returns an Album if the http call completes successfully', () async {
      final client = MockClient();

      // Use Mockito to return a successful response when it calls the
      // provided http.Client.
      when(client
              .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer((_) async =>
              http.Response('{"userId": 1, "id": 2, "title": "mock"}', 200));

      expect(await fetchAlbum(client), isA<Album>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();

      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client
              .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/1')))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(fetchAlbum(client), throwsException);
    });
  });
}
