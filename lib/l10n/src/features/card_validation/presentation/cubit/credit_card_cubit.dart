import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/usecases.dart';

part 'credit_card_state.dart';

class CreditCardCubit extends Cubit<CreditCardState> {
  final SaveCreditCard saveCreditCard;

  CreditCardCubit({
    required this.saveCreditCard,
  }) : super(CreditCardInitial());

  Future<void> saveCreditCardData(CreditCard creditCard) async {
    emit(CreditCardSaveInProgress());
    final result = await saveCreditCard(SaveCreditCardParams(creditCard));
    result.fold(
      (failure) => emit(CreditCardSaveFailure(failure)),
      (_) => emit(CreditCardSaveSuccess()),
    );
  }
}
