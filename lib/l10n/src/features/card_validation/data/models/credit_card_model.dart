import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/credit_card.dart';

part 'credit_card_model.g.dart';

@JsonSerializable()
class CreditCardModel extends CreditCard {
  const CreditCardModel({
    required super.cardNumber,
    required super.cardHolder,
    required super.expiryDate,
    required super.cvv,
  });

  factory CreditCardModel.fromJson(Map<String, dynamic> json) =>
      _$CreditCardModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreditCardModelToJson(this);

  factory CreditCardModel.fromEntity(CreditCard creditCard) => CreditCardModel(
        cardNumber: creditCard.cardNumber,
        cardHolder: creditCard.cardHolder,
        expiryDate: creditCard.expiryDate,
        cvv: creditCard.cvv,
      );
}
