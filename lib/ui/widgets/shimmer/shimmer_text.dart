import 'package:flutter/material.dart';
import 'package:skybase/ui/widgets/shimmer/shimmer_box.dart';

class ShimmerText extends StatelessWidget {
  factory ShimmerText.displayLarge({double? width}) =>
      ShimmerText(height: 24, width: width);

  factory ShimmerText.displaySmall({double? width}) =>
      ShimmerText(height: 18, width: width);

  factory ShimmerText.headlineLarge({double? width}) =>
      ShimmerText(height: 16, width: width);

  factory ShimmerText.headlineMedium({double? width}) =>
      ShimmerText(height: 16, width: width);

  factory ShimmerText.headlineSmall({double? width}) =>
      ShimmerText(height: 14, width: width);

  factory ShimmerText.bodyLarge({double? width}) =>
      ShimmerText(height: 16, width: width);

  factory ShimmerText.bodyMedium({double? width}) =>
      ShimmerText(height: 14, width: width);

  factory ShimmerText.bodySmall({double? width}) =>
      ShimmerText(height: 12, width: width);

  const ShimmerText({
    super.key,
    this.height,
    this.width,
    this.radius,
    this.margin,
    this.padding,
    this.baseColor,
  });

  final double? height;
  final double? width;
  final double? radius;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? baseColor;

  @override
  Widget build(BuildContext context) {
    return ShimmerBox(
      borderRadius: 4,
      height: height ?? 14,
      width: width ?? double.infinity,
    );
  }
}
