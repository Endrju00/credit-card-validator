import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Falure raised when the server returns an error response.
class ServerFailure extends Failure {}

/// Failure raised when timeout occurs.
class TimeoutFailure extends Failure {}

/// Failure raised when unexpected error occurs.
class UnknownFailure extends Failure {}
