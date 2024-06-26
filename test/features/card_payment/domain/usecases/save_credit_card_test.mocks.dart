// Mocks generated by Mockito 5.4.4 from annotations
// in credit_card_validator/test/features/card_payment/domain/usecases/save_credit_card_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:credit_card_validator/src/core/errors/failures.dart' as _i5;
import 'package:credit_card_validator/src/features/card_validation/domain/entities/credit_card.dart'
    as _i6;
import 'package:credit_card_validator/src/features/card_validation/domain/repositories/credit_card_repository.dart'
    as _i3;
import 'package:dartz/dartz.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEither_0<L, R> extends _i1.SmartFake implements _i2.Either<L, R> {
  _FakeEither_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [CreditCardRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockCreditCardRepository extends _i1.Mock
    implements _i3.CreditCardRepository {
  MockCreditCardRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.Either<_i5.Failure, void>> saveCreditCard(
          _i6.CreditCard? creditCard) =>
      (super.noSuchMethod(
        Invocation.method(
          #saveCreditCard,
          [creditCard],
        ),
        returnValue: _i4.Future<_i2.Either<_i5.Failure, void>>.value(
            _FakeEither_0<_i5.Failure, void>(
          this,
          Invocation.method(
            #saveCreditCard,
            [creditCard],
          ),
        )),
      ) as _i4.Future<_i2.Either<_i5.Failure, void>>);
}
