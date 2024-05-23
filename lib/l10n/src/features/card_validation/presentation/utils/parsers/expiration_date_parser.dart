import 'package:intl/intl.dart';

class ExpirationDateParser {
  /// Parses a string in the format MM/yy to a [DateTime] object.
  static DateTime parse(String expiryDate) {
    final dateFormat = DateFormat('MM/yy');
    try {
      final parsedDate = dateFormat.parse(expiryDate);
      return DateTime(parsedDate.year, parsedDate.month + 1, 0, 23, 59, 59);
    } catch (_) {
      throw Exception('Invalid date format. Please use MM/yy format.');
    }
  }
}
