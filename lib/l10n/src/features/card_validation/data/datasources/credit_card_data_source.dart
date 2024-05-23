import '../models/models.dart';

abstract class CreditCardDataSource {
  Future<void> saveCreditCard(CreditCardModel creditCardModel);
}
