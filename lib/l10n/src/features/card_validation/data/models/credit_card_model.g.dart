// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditCardModel _$CreditCardModelFromJson(Map<String, dynamic> json) =>
    CreditCardModel(
      cardNumber: json['cardNumber'] as String,
      cardHolder: json['cardHolder'] as String,
      expiryDate: DateTime.parse(json['expiryDate'] as String),
      cvv: json['cvv'] as String,
    );

Map<String, dynamic> _$CreditCardModelToJson(CreditCardModel instance) =>
    <String, dynamic>{
      'cardNumber': instance.cardNumber,
      'cardHolder': instance.cardHolder,
      'expiryDate': instance.expiryDate.toIso8601String(),
      'cvv': instance.cvv,
    };
