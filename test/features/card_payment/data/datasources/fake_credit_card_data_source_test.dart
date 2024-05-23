import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:credit_card_validator/src/core/errors/exceptions.dart';
import 'package:credit_card_validator/src/features/card_validation/data/datasources/fake_credit_card_data_source.dart';
import 'package:credit_card_validator/src/features/card_validation/data/models/models.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fake_credit_card_data_source_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late FakeCreditCardDataSource dataSource;
  late MockDio mockClient;

  setUp(() {
    mockClient = MockDio();
    dataSource = FakeCreditCardDataSource(client: mockClient);
  });

  final tCreditCardModel = CreditCardModel(
    cardNumber: '1234 1234 1234 1234',
    cardHolder: 'John Doe',
    expiryDate: DateTime(2024, 12),
    cvv: '123',
  );

  void arrangePost201StatusCode() {
    when(mockClient.post(
      any,
      options: anyNamed('options'),
      data: anyNamed('data'),
    )).thenAnswer((_) async => Response(
          statusCode: 201,
          requestOptions: RequestOptions(path: 'credit-card'),
        ));
  }

  group('saveCreditCard', () {
    test(
      'should perform POST request on a proper URL with body',
      () async {
        // arrange
        arrangePost201StatusCode();
        // act
        dataSource.saveCreditCard(tCreditCardModel);
        // assert
        verify(mockClient.post(
          'credit-card',
          options: anyNamed('options'),
          data: json.encode(tCreditCardModel.toJson()),
        ));
      },
    );
    test(
      'should return void when the response is 201 (created)',
      () async {
        // arrange
        arrangePost201StatusCode();
        // act
        final call = dataSource.saveCreditCard;
        // assert
        expect(() => call(tCreditCardModel), isA<void>());
      },
    );

    test(
      'should throw ServerException when the response is not 201 (created)',
      () async {
        // arrange
        when(mockClient.post(
          any,
          options: anyNamed('options'),
          data: anyNamed('data'),
        )).thenAnswer((_) async => Response(
              statusCode: 400,
              requestOptions: RequestOptions(path: 'credit-card'),
            ));
        // act
        final call = dataSource.saveCreditCard;
        // assert
        expect(() => call(tCreditCardModel), throwsA(isA<ServerException>()));
      },
    );

    test('should throw Exception when something goes wrong', () async {
      // arrange
      when(mockClient.post(
        any,
        options: anyNamed('options'),
        data: anyNamed('data'),
      )).thenThrow(Exception());
      // act
      final call = dataSource.saveCreditCard;
      // assert
      expect(() => call(tCreditCardModel), throwsA(isA<Exception>()));
    });
  });
}
