import 'package:intl/intl.dart';

extension NumExtension on num {
  String currencyFormat({
    String symbol = '',
    int decimalDigit = 0,
    String locale = 'id',
  }) {
    num number = this;
    return NumberFormat.currency(
      locale: locale,
      decimalDigits: decimalDigit,
      symbol: symbol,
    ).format(number);
  }
}
