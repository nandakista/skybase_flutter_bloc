import 'package:flutter/material.dart';

import 'shimmer_box.dart';

class ShimmerButton extends StatelessWidget {
  const ShimmerButton({super.key, this.height, this.width});

  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ShimmerBox(
      height: height ?? 40,
      width: width ?? double.infinity,
    );
  }
}
