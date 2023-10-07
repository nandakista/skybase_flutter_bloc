import 'package:flutter/material.dart';
import 'package:skybase/config/themes/app_colors.dart';
import 'package:skybase/ui/widgets/sky_image.dart';

class IntroIndicator extends StatelessWidget {
  const IntroIndicator({
    Key? key,
    required this.itemCount,
    required this.currentIndex,
  }) : super(key: key);

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
                ? const SkyImage(
                    src: 'assets/images/oval_horizontal.svg',
                    color: AppColors.primary,
                  )
                : Icon(Icons.circle, size: 10, color: Colors.grey.shade400),
          );
        },
      ),
    );
  }
}
