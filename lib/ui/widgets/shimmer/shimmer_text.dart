import 'package:flutter/material.dart';
import 'package:skybase/config/themes/app_theme.dart';

class ShimmerText extends StatelessWidget {
  const ShimmerText({super.key, this.width});

  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: 10,
      color: context.isDarkMode ? Colors.black54 : Colors.white,
    );
  }
}
