import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'failures.dart';

/// Class responsible for mapping a [Failure] to a human-readable message.
class FailureToMessageMapper {
  /// Maps a [Failure] to a human-readable message.
  static String map(BuildContext context, {required Failure failure}) {
    if (failure is ServerFailure) {
      return AppLocalizations.of(context)!.serverFailureMessage;
    } else if (failure is TimeoutFailure) {
      return AppLocalizations.of(context)!.timeoutFailureMessage;
    }

    return AppLocalizations.of(context)!.unknownFailureMessage;
  }
}
