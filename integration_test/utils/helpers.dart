import 'package:flutter/material.dart';
import 'package:credit_card_validator/src/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> pumpAndSettle(WidgetTester tester) async =>
    await tester.pumpAndSettle(const Duration(milliseconds: 200));

Future<void> openDrawer(WidgetTester tester) async {
  await tester.pumpWidget(const MyApp());
  await tester.tap(find.byIcon(Icons.menu));
  await pumpAndSettle(tester);
}

void expectHomePageIsVisible(WidgetTester tester) {
  expect(find.byType(AppBar), findsOneWidget);
  expect(find.byIcon(Icons.menu), findsOneWidget);
}

Future<AppLocalizations> getLocalizations() async =>
    await AppLocalizations.delegate.load(const Locale('en'));
