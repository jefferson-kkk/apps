import 'package:ativdade/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('A app inicia neutra e alterna entre emoções ao apertar o botão',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: InterruptorApp()));

    expect(find.byIcon(Icons.sentiment_neutral), findsOneWidget);
    expect(find.text('Mudar emoção'), findsOneWidget);

    await tester.tap(find.text('Mudar emoção'));
    await tester.pump();
    expect(find.byIcon(Icons.sentiment_satisfied), findsOneWidget);

    await tester.tap(find.text('Mudar emoção'));
    await tester.pump();
    expect(find.byIcon(Icons.sentiment_very_dissatisfied), findsOneWidget);

    await tester.tap(find.text('Mudar emoção'));
    await tester.pump();
    expect(find.byIcon(Icons.sentiment_neutral), findsOneWidget);
  });
}
