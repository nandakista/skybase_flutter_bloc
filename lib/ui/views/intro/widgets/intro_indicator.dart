import 'package:flutter/material.dart';
import 'package:skybase/config/themes/app_colors.dart';

class IntroIndicator extends StatelessWidget {
  const IntroIndicator({
    super.key,
    required this.itemCount,
    required this.currentIndex,
  });

  final int itemCount;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List<Widget>.generate(
        itemCount,
        (index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: (index == currentIndex)
                ? Container(
                    width: 30,
                    height: 10,
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(12)),
                  )
                : Icon(Icons.circle, size: 10, color: Colors.grey.shade400),
          );
        },
      ),
    );
  }
}
