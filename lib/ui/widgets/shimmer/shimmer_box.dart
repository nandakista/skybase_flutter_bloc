import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skybase/ui/widgets/sky_box.dart';

class ShimmerBox extends StatelessWidget {
  const ShimmerBox({
    super.key,
    this.height,
    this.width,
    this.borderRadius,
    this.margin,
    this.baseColor,
  });

  final double? height;
  final double? width;
  final double? borderRadius;
  final EdgeInsets? margin;
  final Color? baseColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey.shade300,
      highlightColor: Colors.white,
      child: SkyBox(
        margin: margin,
        height: height,
        width: width,
        borderRadius: borderRadius ?? 6,
        child: const SizedBox.shrink(),
      ),
    );
  }
}
