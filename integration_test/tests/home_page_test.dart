import 'package:flutter/material.dart';
import 'package:credit_card_validator/src/app.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:credit_card_validator/src/injection_container.dart' as di;

import '../utils/helpers.dart';

void main() {
  setUpAll(() => di.setUp());

  testWidgets(
    'Home page should be displayed with app bar and drawer button',
    (tester) async {
      await tester.pumpWidget(const MyApp());
      expectHomePageIsVisible(tester);
    },
  );

  testWidgets(
    'Drawer with form should be displayed after tapping on menu button',
    (tester) async {
      await openDrawer(tester);
      expect(find.byType(Form), findsOneWidget);
      expect(find.byKey(const ValueKey('save-button')), findsOneWidget);
      expect(find.byKey(const ValueKey('cancel-button')), findsOneWidget);
    },
  );

  testWidgets(
    'Home page should be displayed after tapping on drawer cancel button',
    (tester) async {
      await openDrawer(tester);
      await tester.tap(find.byKey(const ValueKey('cancel-button')));
      await pumpAndSettle(tester);
      expect(find.byType(Form), findsNothing);
      expectHomePageIsVisible(tester);
    },
  );
}
