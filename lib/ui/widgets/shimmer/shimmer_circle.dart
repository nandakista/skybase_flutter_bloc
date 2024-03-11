import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skybase/ui/widgets/sky_box.dart';

class ShimmerCircle extends StatelessWidget {
  const ShimmerCircle({
    super.key,
    this.height,
    this.width,
    this.margin,
    this.padding,
    this.baseColor,
  });

  final double? height;
  final double? width;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? baseColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey.shade300,
      highlightColor: Colors.white,
      child: SkyBox(
        margin: margin,
        padding: padding,
        height: height,
        width: width,
        borderRadius: height,
        elevation: 0,
        child: const SizedBox.shrink(),
      ),
    );
  }
}
