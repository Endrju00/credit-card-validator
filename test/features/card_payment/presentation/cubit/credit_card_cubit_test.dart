import 'package:dartz/dartz.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:credit_card_validator/src/core/errors/failures.dart';
import 'package:credit_card_validator/src/features/card_validation/domain/entities/entities.dart';
import 'package:credit_card_validator/src/features/card_validation/domain/usecases/usecases.dart';
import 'package:credit_card_validator/src/features/card_validation/presentation/cubit/credit_card_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'credit_card_cubit_test.mocks.dart';

@GenerateMocks([SaveCreditCard])
void main() {
  late CreditCardCubit cubit;
  late MockSaveCreditCard mockSaveCreditCard;

  setUp(() {
    mockSaveCreditCard = MockSaveCreditCard();
    cubit = CreditCardCubit(saveCreditCard: mockSaveCreditCard);
  });

  test('initial state should be CreditCardInitial', () {
    expect(cubit.state, CreditCardInitial());
  });

  final tCreditCard = CreditCard(
    cardNumber: '1234 1234 1234 1234',
    cardHolder: 'John Doe',
    expiryDate: DateTime(2024, 12),
    cvv: '123',
  );

  final tFailure = UnknownFailure();

  group('saveCreditCardData', () {
    blocTest<CreditCardCubit, CreditCardState>(
      'should emit [CreditCardSaveInProgress, CreditCardSaveSuccess] when SaveCreditCard returns Right',
      build: () {
        when(mockSaveCreditCard(SaveCreditCardParams(tCreditCard)))
            .thenAnswer((_) async => const Right(null));
        return cubit;
      },
      act: (cubit) => cubit.saveCreditCardData(tCreditCard),
      expect: () => [CreditCardSaveInProgress(), CreditCardSaveSuccess()],
    );

    blocTest<CreditCardCubit, CreditCardState>(
      'should emit [CreditCardSaveInProgress, CreditCardSaveFailure] when SaveCreditCard returns Left',
      build: () {
        when(mockSaveCreditCard(SaveCreditCardParams(tCreditCard)))
            .thenAnswer((_) async => Left(tFailure));
        return cubit;
      },
      act: (cubit) => cubit.saveCreditCardData(tCreditCard),
      expect: () =>
          [CreditCardSaveInProgress(), CreditCardSaveFailure(tFailure)],
    );
  });
}
