import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/errors/exceptions.dart';
import '../models/models.dart';
import 'credit_card_data_source.dart';

class FakeCreditCardDataSource implements CreditCardDataSource {
  final Dio client;

  FakeCreditCardDataSource({required this.client});

  @override
  Future<void> saveCreditCard(CreditCardModel creditCardModel) async {
    final response = await client
        .post(
          'credit-card',
          options: Options(
            headers: {
              'Content-Type': 'application/json',
            },
          ),
          data: json.encode(creditCardModel.toJson()),
        )
        .timeout(
          const Duration(seconds: 2),
          onTimeout: () => throw TimeoutException(),
        );

    if (response.statusCode != 201) {
      throw ServerException();
    }
  }
}
