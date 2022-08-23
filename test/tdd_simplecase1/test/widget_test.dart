import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:tdd_simplecase1/main.dart';

void main() {
  testWidgets('create homepage and AppBar', (tester) async {
    final testWidget = HomePage();
    await tester.pumpWidget(testWidget);
    await tester.pumpAndSettle();
    expect(find.widgetWithText(AppBar, 'test'), findsNWidgets(1));
    expect(find.widgetWithIcon(AppBar, Icons.save), findsOneWidget);
    expect(find.text('test용 앱입니다.'), findsOneWidget);
    expect(find.widgetWithText(Column, 'happy'), findsOneWidget);
    expect(find.widgetWithIcon(Column, Icons.dangerous), findsOneWidget);
  });
}
