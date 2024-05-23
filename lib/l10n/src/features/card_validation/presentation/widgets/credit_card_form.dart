import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/errors/errors.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../../domain/domain.dart';
import '../cubit/credit_card_cubit.dart';
import '../utils/formatters/formatters.dart';
import '../utils/parsers/expiration_date_parser.dart';
import '../utils/validators/validators.dart';

class CreditCardForm extends StatefulWidget {
  const CreditCardForm({super.key});

  @override
  State<CreditCardForm> createState() => _CreditCardFormState();
}

class _CreditCardFormState extends State<CreditCardForm> {
  final _formKey = GlobalKey<FormState>();

  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();
  final _cardHolderNameController = TextEditingController();

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      await context.read<CreditCardCubit>().saveCreditCardData(
            CreditCard(
              cardNumber: _cardNumberController.text,
              expiryDate:
                  ExpirationDateParser.parse(_expiryDateController.text),
              cvv: _cvvController.text,
              cardHolder: _cardHolderNameController.text,
            ),
          );

      if (!mounted) return;
      Navigator.of(context).pop();
    }
  }

  void _messageOnStateChange(BuildContext context, CreditCardState state) {
    if (state is CreditCardSaveSuccess) {
      FrtSnackBar.show(
        context: context,
        message: AppLocalizations.of(context)!.cardSaveSuccess,
        type: FrtSnackBarType.success,
      );
    } else if (state is CreditCardSaveFailure) {
      FrtSnackBar.show(
        context: context,
        message: FailureToMessageMapper.map(context, failure: state.failure),
        type: FrtSnackBarType.error,
      );
    }
  }

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    _cardHolderNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: BlocConsumer<CreditCardCubit, CreditCardState>(
            listener: _messageOnStateChange,
            builder: (context, state) {
              final isFormBlocked = state is CreditCardSaveInProgress;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Text(
                      AppLocalizations.of(context)!.enterCardDetails,
                      style: const TextStyle(
                        fontSize: 28,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  FrtTextFormField(
                    key: const ValueKey('card-number-field'),
                    controller: _cardNumberController,
                    icon: const Icon(Icons.credit_card),
                    labelText: AppLocalizations.of(context)!.cardNumber,
                    readOnly: isFormBlocked,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(19),
                      CardNumberInputFormatter(),
                    ],
                    validator: (cardNumber) =>
                        CardInputValidator.validateCardNumber(cardNumber!)
                            ? null
                            : AppLocalizations.of(context)!.invalidCardNumber,
                  ),
                  FrtTextFormField(
                    key: const ValueKey('expiry-date-field'),
                    controller: _expiryDateController,
                    icon: const Icon(Icons.calendar_today),
                    labelText: AppLocalizations.of(context)!.expiryDate,
                    readOnly: isFormBlocked,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                      CardExpiryDateInputFormatter()
                    ],
                    validator: (date) =>
                        CardInputValidator.validateExpiryDate(date!)
                            ? null
                            : AppLocalizations.of(context)!.invalidExpiryDate,
                  ),
                  FrtTextFormField(
                    key: const ValueKey('cvv-field'),
                    controller: _cvvController,
                    icon: const Icon(Icons.lock),
                    labelText: AppLocalizations.of(context)!.cvv,
                    readOnly: isFormBlocked,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                    ],
                    validator: (cvv) => CardInputValidator.validateCvv(cvv!)
                        ? null
                        : AppLocalizations.of(context)!.invalidCvv,
                  ),
                  FrtTextFormField(
                    key: const ValueKey('card-holder-name-field'),
                    controller: _cardHolderNameController,
                    icon: const Icon(Icons.person),
                    labelText: AppLocalizations.of(context)!.cardHolderName,
                    keyboardType: TextInputType.name,
                    errorMaxLines: 5,
                    readOnly: isFormBlocked,
                    inputFormatters: [
                      UpperCaseTextFormatter(),
                    ],
                    validator: (name) =>
                        CardInputValidator.validateCardHolderName(name!)
                            ? null
                            : AppLocalizations.of(context)!
                                .invalidCardHolderName,
                  ),
                  const SizedBox(height: 32),
                  FrtTextButton(
                    key: const ValueKey('save-button'),
                    labelText: AppLocalizations.of(context)!.save,
                    onPressed: isFormBlocked ? null : _submitForm,
                  ),
                  const SizedBox(height: 16),
                  FrtSecondaryTextButton(
                    key: const ValueKey('cancel-button'),
                    labelText: AppLocalizations.of(context)!.cancel,
                    onPressed: isFormBlocked
                        ? null
                        : () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(height: 16),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
