import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:credit_card_validator/src/core/errors/exceptions.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/entities.dart';
import '../../domain/repositories/repositories.dart';
import '../datasources/datasources.dart';
import '../models/models.dart';

class CreditCardRepositoryImpl implements CreditCardRepository {
  final CreditCardDataSource dataSource;

  CreditCardRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, void>> saveCreditCard(CreditCard creditCard) async {
    try {
      final result = await dataSource
          .saveCreditCard(CreditCardModel.fromEntity(creditCard));
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    } on TimeoutException {
      return Left(TimeoutFailure());
    } catch (e) {
      log('Unknown failure: $e', name: 'CreditCardRepositoryImpl');
      return Left(UnknownFailure());
    }
  }
}
