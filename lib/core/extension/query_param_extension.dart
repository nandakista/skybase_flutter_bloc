extension BoolNullQueryExtension on bool? {
  int? get toIntCode {
    return switch (this) {
      true => 1,
      false => 0,
      _ => null,
    };
  }
}

extension BoolQueryExtension on bool {
  int get toIntCode => this ? 1 : 0;
}

extension IntQueryExtension on int {
  bool get isTrue => this == 1;

  bool get isFalse => this == 0;
}

extension IntNullQueryExtension on int? {
  bool get isTrue => this == 1;

  bool get isFalse => this == 0;
}
