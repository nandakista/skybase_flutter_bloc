extension StringNullExtension on String? {
  bool get isZeroOrEmpty {
    return this == null || this == '0';
  }

  bool get isNullOrEmpty {
    return this == null || this == '' || this == 'null';
  }

  bool get isNotNullAndNotEmpty {
    return this != null && this != '' && this != 'null';
  }

  String get to08Phone {
    if (toString().startsWith('62')) {
      return toString().replaceRange(0, 2, '0');
    } else if (toString().startsWith('+62')) {
      return toString().replaceRange(0, 3, '0');
    } else {
      return toString();
    }
  }

  String get to62Phone {
    if (toString().startsWith('08')) {
      return toString().replaceRange(0, 1, '62');
    } else if (toString().startsWith('+628')) {
      return toString().replaceRange(0, 2, '');
    } else {
      return toString();
    }
  }
}