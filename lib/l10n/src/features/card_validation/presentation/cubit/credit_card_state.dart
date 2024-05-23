part of 'credit_card_cubit.dart';

sealed class CreditCardState extends Equatable {
  const CreditCardState();

  @override
  List<Object> get props => [];
}

final class CreditCardInitial extends CreditCardState {}

final class CreditCardSaveInProgress extends CreditCardState {}

final class CreditCardSaveSuccess extends CreditCardState {}

final class CreditCardSaveFailure extends CreditCardState {
  final Failure failure;

  const CreditCardSaveFailure(this.failure);

  @override
  List<Object> get props => [failure];
}
