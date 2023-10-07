import 'package:intl/intl.dart';

extension IntNullExtension on double? {
  String currencyFormat({
    String symbol = '',
    int decimalDigit = 0,
    String locale = 'id',
  }) {
    double? number = this ?? 0;
    return NumberFormat.currency(
      locale: locale,
      decimalDigits: decimalDigit,
      symbol: symbol,
    ).format(number);
  }
}

extension IntExtension on double {
  String currencyFormat({
    String symbol = '',
    int decimalDigit = 0,
    String locale = 'id',
  }) {
    return NumberFormat.currency(
      locale: locale,
      decimalDigits: decimalDigit,
      symbol: symbol,
    ).format(this);
  }
}