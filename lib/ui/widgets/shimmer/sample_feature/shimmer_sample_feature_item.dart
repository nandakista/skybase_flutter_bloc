import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skybase/config/themes/app_theme.dart';
import 'package:skybase/ui/widgets/shimmer/shimmer_text.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class ShimmerSampleFeatureItem extends StatelessWidget {
  const ShimmerSampleFeatureItem({super.key, required this.height});

  final double height;

  @override
  Widget build(BuildContext context) {
    Color shimmerColor =  context.isDarkMode ? Colors.black54 : Colors.white;
    Color baseDark = Colors.grey[700]?? Colors.grey;
    Color baseLight = Colors.grey[300] ?? Colors.grey;
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Shimmer.fromColors(
        baseColor: context.isDarkMode ?  baseDark : baseLight,
        highlightColor: shimmerColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              radius: 30,
              backgroundColor: shimmerColor,
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ShimmerText(),
                  SizedBox(height: 4),
                  ShimmerText(),
                  SizedBox(height: 4),
                  ShimmerText(width: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
