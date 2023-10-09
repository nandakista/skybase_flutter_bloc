import 'package:flutter/material.dart';

extension SizeIntExtension on int {
  double w(context) {
    if (this >= 100) return MediaQuery.sizeOf(context).width;
    return this / 100 * MediaQuery.sizeOf(context).width;
  }

  double h(context) {
    if (this >= 100) return MediaQuery.sizeOf(context).height;
    return this / 100 * MediaQuery.sizeOf(context).height;
  }
}

extension DoubleIntExtension on double {
  double w(context) {
    if (this >= 100) return MediaQuery.sizeOf(context).width;
    return this / 100 * MediaQuery.sizeOf(context).width;
  }

  double h(context) {
    if (this >= 100) return MediaQuery.sizeOf(context).height;
    return this / 100 * MediaQuery.sizeOf(context).height;
  }
}
