import 'package:credit_card_validator/src/features/card_validation/presentation/utils/parsers/parsers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('parse', () {
    test('should return a DateTime when the date is valid', () {
      // arrange
      const expiryDate = '12/24';
      // act
      final result = ExpirationDateParser.parse(expiryDate);
      // assert
      expect(result, DateTime(2024, 12, 31, 23, 59, 59));
    });

    test('should throw an exception when the date is in wrong format', () {
      // arrange
      const expiryDate = '12-24';
      // act
      const call = ExpirationDateParser.parse;
      // assert
      expect(() => call(expiryDate), throwsException);
    });
  });
}
