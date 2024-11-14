import 'package:flutter/material.dart';

extension SizeExtension on num {
  double w(BuildContext context) {
    if (this >= 100) return MediaQuery.sizeOf(context).width;
    return this / 100 * MediaQuery.sizeOf(context).width;
  }

  double h(BuildContext context) {
    if (this >= 100) return MediaQuery.sizeOf(context).height;
    return this / 100 * MediaQuery.sizeOf(context).height;
  }
}
