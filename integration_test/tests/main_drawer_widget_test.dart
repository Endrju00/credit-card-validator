import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:credit_card_validator/src/injection_container.dart' as di;
import 'package:flutter_test/flutter_test.dart';

import '../utils/helpers.dart';

void main() {
  late AppLocalizations localizations;

  setUpAll(() async {
    di.setUp();
    localizations = await getLocalizations();
  });

  const tCardNumber = '4111111111111111';
  const tExpiryDate = '1299';
  const tCvv = '123';
  const tCardHolderName = 'John Doe';

  testWidgets(
    'Form should have all required fields and buttons',
    (tester) async {
      await openDrawer(tester);
      expect(find.byType(Form), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(4));
      expect(find.text('Card number'), findsOneWidget);
      expect(find.text('Expiry date'), findsOneWidget);
      expect(find.text('CVV'), findsOneWidget);
      expect(find.text('Card holder name'), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(OutlinedButton), findsOneWidget);
    },
  );

  testWidgets(
    'Form should be validated in real time',
    (tester) async {
      var key = const ValueKey('card-number-field');
      await openDrawer(tester);

      await tester.enterText(find.byKey(key), tCardNumber.substring(0, 4));
      await tester.pump();
      expect(find.text(localizations.invalidCardNumber), findsOneWidget);
      await tester.enterText(find.byKey(key), tCardNumber);
      await tester.pump();
      expect(find.text(localizations.invalidCardNumber), findsNothing);

      key = const ValueKey('expiry-date-field');
      await tester.enterText(find.byKey(key), tExpiryDate.substring(0, 2));
      await tester.pump();
      expect(find.text(localizations.invalidExpiryDate), findsOneWidget);
      await tester.enterText(find.byKey(key), tExpiryDate);
      await tester.pump();
      expect(find.text(localizations.invalidExpiryDate), findsNothing);

      key = const ValueKey('cvv-field');
      await tester.enterText(find.byKey(key), tCvv.substring(0, 2));
      await tester.pump();
      expect(find.text(localizations.invalidCvv), findsOneWidget);
      await tester.enterText(find.byKey(key), tCvv);
      await tester.pump();
      expect(find.text(localizations.invalidCvv), findsNothing);

      key = const ValueKey('card-holder-name-field');
      await tester.enterText(find.byKey(key), tCardHolderName.substring(0, 1));
      await tester.pump();
      expect(find.text(localizations.invalidCardHolderName), findsOneWidget);
      await tester.enterText(find.byKey(key), tCardHolderName);
      await tester.pump();
      expect(find.text(localizations.invalidCardHolderName), findsNothing);
    },
  );

  testWidgets(
    'Form should be validated after tap on save button',
    (tester) async {
      await openDrawer(tester);
      await tester.tap(find.byKey(const ValueKey('save-button')));
      await pumpAndSettle(tester);
      expect(find.text(localizations.invalidCardNumber), findsOneWidget);
      expect(find.text(localizations.invalidExpiryDate), findsOneWidget);
      expect(find.text(localizations.invalidCvv), findsOneWidget);
      expect(find.text(localizations.invalidCardHolderName), findsOneWidget);
    },
  );

  testWidgets(
    'Success snackbar should be displayed after saving validated form',
    (tester) async {
      await openDrawer(tester);
      await tester.enterText(
          find.byKey(const ValueKey('card-number-field')), tCardNumber);
      await tester.enterText(
          find.byKey(const ValueKey('expiry-date-field')), tExpiryDate);
      await tester.enterText(find.byKey(const ValueKey('cvv-field')), tCvv);
      await tester.enterText(
          find.byKey(const ValueKey('card-holder-name-field')),
          tCardHolderName);
      await tester.tap(find.byKey(const ValueKey('save-button')));
      await pumpAndSettle(tester);
      expect(find.text(localizations.cardSaveSuccess), findsOneWidget);
    },
  );
}
