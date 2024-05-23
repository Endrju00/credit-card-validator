import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:credit_card_validator/src/core/debug/interceptors/mock_interceptor.dart';
import 'package:get_it/get_it.dart';

import 'features/card_validation/data/data.dart';
import 'features/card_validation/domain/domain.dart';

/// Service locator
final sl = GetIt.instance;

/// Registers all dependencies.
void setUp() {
  _core();
  if (kReleaseMode) {
    _commonProduction();
  } else {
    _commonDevelopment();
  }
}

/// Registers core dependencies.
void _core() {
  _setUpCardPaymentFeature();
}

/// Registers dependencies for development environment.
void _commonDevelopment() {
  sl.registerLazySingleton(() =>
      Dio(BaseOptions(baseUrl: const String.fromEnvironment('baseUrl')))
        ..interceptors.add(MockInterceptor()));
}

/// Registers dependencies for production environment.
void _commonProduction() {
  sl.registerLazySingleton(
      () => Dio(BaseOptions(baseUrl: const String.fromEnvironment('baseUrl'))));
}

/// Registers all dependencies for the card payment feature.
void _setUpCardPaymentFeature() {
  // Use cases
  sl.registerLazySingleton(() => SaveCreditCard(sl()));

  // Repositories
  sl.registerLazySingleton<CreditCardRepository>(
      () => CreditCardRepositoryImpl(sl()));

  // Data sources
  sl.registerLazySingleton<CreditCardDataSource>(
      () => FakeCreditCardDataSource(client: sl()));
}
