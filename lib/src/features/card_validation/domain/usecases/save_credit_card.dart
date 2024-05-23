import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/credit_card.dart';
import '../repositories/credit_card_repository.dart';

class SaveCreditCard implements UseCase<void, SaveCreditCardParams> {
  final CreditCardRepository repository;

  SaveCreditCard(this.repository);

  @override
  Future<Either<Failure, void>> call(SaveCreditCardParams params) async {
    return await repository.saveCreditCard(params.creditCard);
  }
}

class SaveCreditCardParams extends Equatable {
  final CreditCard creditCard;

  const SaveCreditCardParams(this.creditCard);

  @override
  List<Object?> get props => [creditCard];
}
