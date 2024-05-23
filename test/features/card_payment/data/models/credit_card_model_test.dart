import 'package:credit_card_validator/src/features/card_validation/data/models/credit_card_model.dart';
import 'package:credit_card_validator/src/features/card_validation/domain/entities/credit_card.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tCreditCardModel = CreditCardModel(
    cardNumber: '1234 1234 1234 1234',
    cardHolder: 'John Doe',
    expiryDate: DateTime(2024, 12),
    cvv: '123',
  );

  test(
    'should be a subclass of CreditCard entity',
    () async {
      // assert
      expect(tCreditCardModel, isA<CreditCard>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model when the JSON is properly formatted',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = {
          'cardNumber': '1234 1234 1234 1234',
          'cardHolder': 'John Doe',
          'expiryDate': '2024-12-01T00:00:00.000',
          'cvv': '123',
        };
        // act
        final result = CreditCardModel.fromJson(jsonMap);
        // assert
        expect(result, tCreditCardModel);
      },
    );
  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tCreditCardModel.toJson();
        // assert
        final expectedMap = {
          'cardNumber': '1234 1234 1234 1234',
          'cardHolder': 'John Doe',
          'expiryDate': '2024-12-01T00:00:00.000',
          'cvv': '123',
        };
        expect(result, expectedMap);
      },
    );
  });
}
