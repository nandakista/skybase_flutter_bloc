import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerWrapper extends StatelessWidget {
  const ShimmerWrapper({
    super.key,
    required this.child,
    this.align,
    this.baseColor,
  });

  final Widget child;
  final AlignmentGeometry? align;
  final Color? baseColor;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: align ?? Alignment.topCenter,
      child: Shimmer.fromColors(
        baseColor: baseColor ?? Colors.grey.shade300,
        highlightColor: Colors.white,
        child: child,
      ),
    );
  }
}
