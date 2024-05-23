import 'dart:convert';

import 'package:credit_card_validator/src/features/card_validation/presentation/utils/validators/card_input_validator.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  group('validateCardNumber', () {
    const tIssuingNetworksNames = [
      'american_express',
      'discover',
      'jcb',
      'mastercard',
      'visa',
    ];

    const tInvalidNumbers = [
      '8569 6195 0383 3437',
      '1231 a123 n123 123s',
      '123',
      '1234 1234 1234 1234 1234',
    ];

    test('should return true when the card number is valid', () {
      // arrange
      for (final networkName in tIssuingNetworksNames) {
        // act
        final validCardNumbers = List.from(
            json.decode(fixture('credit_card_numbers/$networkName.json')));

        for (final data in validCardNumbers) {
          final cardNumber = data['CreditCard']['CardNumber'].toString();
          final result = CardInputValidator.validateCardNumber(cardNumber);
          // assert
          expect(result, true);
        }
      }
    });

    test('should return false when the card number is invalid', () {
      // arrange
      for (final cardNumber in tInvalidNumbers) {
        // act
        final result = CardInputValidator.validateCardNumber(cardNumber);
        // assert
        expect(result, false);
      }
    });
  });

  group('validateExpiryDate', () {
    const tNotExpiredDate = '12/99';
    const tExpiredDate = '12/21';
    const tInvalidFormatDates = [
      '13/99',
      '12/100',
      '12/9',
      '12/12/12',
      '12/00'
    ];

    test(
      'should return true when the expiry date is not expired and proper format',
      () {
        // act
        final result = CardInputValidator.validateExpiryDate(tNotExpiredDate);
        // assert
        expect(result, true);
      },
    );

    test('should return false when the expiry date is expired', () {
      // act
      final result = CardInputValidator.validateExpiryDate(tExpiredDate);
      // assert
      expect(result, false);
    });

    test('should return false when the expiry date is invalid', () {
      // arrange
      for (final expiryDate in tInvalidFormatDates) {
        // act
        final result = CardInputValidator.validateExpiryDate(expiryDate);
        // assert
        expect(result, false);
      }
    });
  });

  group('validateCvv', () {
    const tValidCvvs = [
      '123',
      '1234',
    ];

    const tInvalidCvvs = [
      '12',
      '12345',
      '123a',
      '1234a',
    ];

    test('should return true when the cvv is valid', () {
      // arrange
      for (final cvv in tValidCvvs) {
        // act
        final result = CardInputValidator.validateCvv(cvv);
        // assert
        expect(result, true);
      }
    });

    test('should return false when the cvv is invalid', () {
      // arrange
      for (final cvv in tInvalidCvvs) {
        // act
        final result = CardInputValidator.validateCvv(cvv);
        // assert
        expect(result, false);
      }
    });
  });

  group('validateCardHolderName', () {
    const tValidCardHolderNames = [
      'John Doe',
      'John-Doe',
      'John Doe-Smith',
      'John Doe-Smith Jr.',
      'John Doe-Smith Jr. III',
    ];

    const tInvalidCardHolderNames = [
      'J',
      'John Doe-Smith Jr. III Doe-Smith',
      'J0hn D03',
      'John Doe-\$mith',
    ];

    test('should return true when the card holder name is valid', () {
      // arrange
      for (final cardHolderName in tValidCardHolderNames) {
        // act
        final result =
            CardInputValidator.validateCardHolderName(cardHolderName);
        // assert
        expect(result, true);
      }
    });

    test('should return false when the card holder name is invalid', () {
      // arrange
      for (final cardHolderName in tInvalidCardHolderNames) {
        // act
        final result =
            CardInputValidator.validateCardHolderName(cardHolderName);
        // assert
        expect(result, false);
      }
    });
  });
}
