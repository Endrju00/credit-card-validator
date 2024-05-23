import 'package:equatable/equatable.dart';

class CreditCard extends Equatable {
  final String cardNumber;
  final String cardHolder;
  final DateTime expiryDate;
  final String cvv;

  const CreditCard({
    required this.cardNumber,
    required this.cardHolder,
    required this.expiryDate,
    required this.cvv,
  });

  @override
  List<Object?> get props => [cardNumber, cardHolder, expiryDate, cvv];
}
