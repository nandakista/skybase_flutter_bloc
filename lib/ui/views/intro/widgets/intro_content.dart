import 'package:flutter/material.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/ui/widgets/sky_image.dart';

class IntroContent extends StatelessWidget {
  const IntroContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  final String image;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SkyImage(
          src: image,
          height: 270,
          fit: BoxFit.cover,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppStyle.subtitle2.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                textAlign: TextAlign.center,
                style: AppStyle.subtitle4.copyWith(fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
