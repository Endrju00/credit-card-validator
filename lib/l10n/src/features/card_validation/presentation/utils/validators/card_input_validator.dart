class CardInputValidator {
  /// Validates the card number with the Luhn algorithm.
  static bool validateCardNumber(String cardNumber) {
    final sanitizedNumber = cardNumber.sanitize;

    if (sanitizedNumber.isEmpty) return false;

    return sanitizedNumber.containsOnlyDigits &&
        sanitizedNumber.hasAtLeast8Digits &&
        sanitizedNumber.hasAtMost19Digits &&
        sanitizedNumber
                    .toReversedIndexedMap()
                    .map(_doubleEvenDigit)
                    .map(_subtractDigitGreaterThan9)
                    .sum() % 10 == 0;
  }

  /// Validates the expiry date in the MM/yy format.
  static bool validateExpiryDate(String expiryDate) {
    if (expiryDate.isEmpty ||
        expiryDate.length != 5 ||
        !expiryDate.hasOneSlash) {
      return false;
    }

    final splitted = expiryDate.split('/');
    if (splitted.length != 2) return false;

    final month = int.parse(splitted[0]), year = int.parse(splitted[1]);

    return month > 0 &&
        month < 13 &&
        year > 0 &&
        !_hasDateExpired(month, 2000 + year);
  }

  /// Validates the CVV.
  static bool validateCvv(String cvv) =>
      cvv.isNotEmpty &&
      cvv.containsOnlyDigits &&
      cvv.length > 2 &&
      cvv.length < 5;

  /// Validates the card holder name.
  static bool validateCardHolderName(String cardHolderName) =>
      cardHolderName.isNotEmpty &&
      cardHolderName.length > 1 &&
      cardHolderName.length < 27 &&
      RegExp(r"^[a-zA-Z\s\.\-\'']+$").hasMatch(cardHolderName);

  static int _doubleEvenDigit(MapEntry<int, int> entry) =>
      entry.key.isEven ? entry.value : entry.value * 2;

  static int _subtractDigitGreaterThan9(int value) =>
      value > 9 ? value - 9 : value;

  static bool _hasDateExpired(int month, int year) {
    final now = DateTime.now();
    return year < now.year || (year == now.year && month < now.month);
  }
}

extension on String {
  bool get containsOnlyDigits => !contains(RegExp(r'[^0-9 ]'));

  String get sanitize => replaceAll(' ', '');

  bool get hasAtLeast8Digits => length > 7;

  bool get hasAtMost19Digits => length < 20;

  bool get hasOneSlash => split('').where((char) => char == '/').length == 1;

  List<MapEntry<int, int>> toReversedIndexedMap() =>
      _toDigits().reversed.toIndexedMap();

  List<int> _toDigits() => split('').map((char) => int.parse(char)).toList();
}

extension on Iterable<int> {
  List<MapEntry<int, int>> toIndexedMap() => toList().asMap().entries.toList();

  int sum() => fold(0, (prev, element) => prev + element);
}
