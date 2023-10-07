import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skybase/ui/widgets/shimmer/shimmer_text.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class ShimmerItemList extends StatelessWidget {
  const ShimmerItemList({Key? key, required this.height}) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    Color shimmerColor =  Get.isDarkMode ? Colors.black54 : Colors.white;
    Color baseDark = Colors.grey[700]?? Colors.grey;
    Color baseLight = Colors.grey[300] ?? Colors.grey;
    return SizedBox(
      height: height * 1.5,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Shimmer.fromColors(
          baseColor: Get.isDarkMode ?  baseDark : baseLight,
          highlightColor: shimmerColor,
          child: Column(
            children: [
              Row(
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
            ],
          ),
        ),
      ),
    );
  }
}
