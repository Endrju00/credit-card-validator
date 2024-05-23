import 'package:dartz/dartz.dart';
import 'package:credit_card_validator/src/core/errors/exceptions.dart';
import 'package:credit_card_validator/src/core/errors/failures.dart';
import 'package:credit_card_validator/src/features/card_validation/data/data.dart';
import 'package:credit_card_validator/src/features/card_validation/domain/entities/entities.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'credit_card_repository_impl_test.mocks.dart';

@GenerateMocks([CreditCardDataSource])
void main() {
  late CreditCardRepositoryImpl repository;
  late MockCreditCardDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockCreditCardDataSource();
    repository = CreditCardRepositoryImpl(mockDataSource);
  });

  final tCreditCardModel = CreditCardModel(
    cardNumber: '1234 1234 1234 1234',
    cardHolder: 'John Doe',
    expiryDate: DateTime(2024, 12),
    cvv: '123',
  );

  final CreditCard tCreditCard = tCreditCardModel;

  group('saveCreditCard', () {
    test(
      'should return void when the call to data source is successful',
      () async {
        // arrange
        when(mockDataSource.saveCreditCard(tCreditCardModel))
            .thenAnswer((_) async {});
        // act
        final result = await repository.saveCreditCard(tCreditCard);
        // assert
        expect(result, const Right(null));
      },
    );

    test(
      'should return ServerFailure when the call to data source is unsuccessful',
      () async {
        // arrange
        when(mockDataSource.saveCreditCard(tCreditCardModel))
            .thenThrow(ServerException());
        // act
        final result = await repository.saveCreditCard(tCreditCard);
        // assert
        expect(result, Left(ServerFailure()));
      },
    );

    test(
      'should return TimeoutFailure when the call to data source times out',
      () async {
        // arrange
        when(mockDataSource.saveCreditCard(tCreditCardModel))
            .thenThrow(TimeoutException());
        // act
        final result = await repository.saveCreditCard(tCreditCard);
        // assert
        expect(result, Left(TimeoutFailure()));
      },
    );

    test(
        'should return UnknownFailure when the call to data source throws an exception',
        () async {
      // arrange
      when(mockDataSource.saveCreditCard(tCreditCardModel))
          .thenThrow(Exception());
      // act
      final result = await repository.saveCreditCard(tCreditCard);
      // assert
      expect(result, Left(UnknownFailure()));
    });
  });
}
