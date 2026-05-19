import 'package:flutter_test/flutter_test.dart';

import 'package:gestao_predial/main.dart';

void main() {
  testWidgets('abre a tela de login pela home', (tester) async {
    await tester.pumpWidget(const GestaoPredialApp());

    expect(find.text('Gestao Predial'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);

    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(find.text('Bem-vindo de volta'), findsOneWidget);
    expect(find.text('Avançar'), findsOneWidget);
  });
}
