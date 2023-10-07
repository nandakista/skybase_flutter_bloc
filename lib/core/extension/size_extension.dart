import 'package:get/get.dart';

extension SizeIntExtension on int {
  double get w {
    if (this >= 100) return Get.width;
    return this / 100 * Get.width;
  }

  double get h {
    if (this >= 100) return Get.height;
    return this / 100 * Get.height;
  }
}

extension DoubleIntExtension on double {
  double get w {
    if (this >= 100) return Get.width;
    return this/100 * Get.width;
  }

  double get h {
    if (this >= 100) return Get.height;
    return this/100 * Get.height;
  }
}
