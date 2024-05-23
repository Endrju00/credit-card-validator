import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/credit_card.dart';

abstract class CreditCardRepository {
  Future<Either<Failure, void>> saveCreditCard(CreditCard creditCard);
}
