import 'package:intl/intl.dart';

extension IntExtension on int {
  String currencyFormat({
    String symbol = '',
    int decimalDigit = 0,
    String locale = 'id',
  }) {
    int number = this;
    return NumberFormat.currency(
      locale: locale,
      decimalDigits: decimalDigit,
      symbol: symbol,
    ).format(number);
  }
}

extension IntNullExtension on int? {
  String currencyFormat({
    String symbol = 'Rp. ',
    int decimalDigit = 0,
    String locale = 'id',
  }) {
    int number = this ?? 0;
    return NumberFormat.currency(
      locale: locale,
      decimalDigits: decimalDigit,
      symbol: symbol,
    ).format(number);
  }
}
