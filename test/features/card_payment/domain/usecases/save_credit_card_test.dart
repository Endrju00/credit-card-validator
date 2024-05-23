import 'package:dartz/dartz.dart';
import 'package:credit_card_validator/src/features/card_validation/domain/domain.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'save_credit_card_test.mocks.dart';

@GenerateMocks([CreditCardRepository])
void main() {
  late SaveCreditCard usecase;
  late MockCreditCardRepository mockCreditCardRepository;

  setUp(() {
    mockCreditCardRepository = MockCreditCardRepository();
    usecase = SaveCreditCard(mockCreditCardRepository);
  });

  final tCreditCard = CreditCard(
    cardNumber: '1234 1234 1234 1234',
    cardHolder: 'John Doe',
    expiryDate: DateTime(2024, 12),
    cvv: '123',
  );

  test('should save credit card using repository', () async {
    // arrange
    when(mockCreditCardRepository.saveCreditCard(tCreditCard))
        .thenAnswer((_) async => const Right(null));
    // act
    final result = await usecase(SaveCreditCardParams(tCreditCard));
    // assert
    expect(result, const Right(null));
    verify(mockCreditCardRepository.saveCreditCard(tCreditCard));
    verifyNoMoreInteractions(mockCreditCardRepository);
  });
}
