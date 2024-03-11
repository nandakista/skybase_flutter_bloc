import 'package:flutter/material.dart';
import 'package:skybase/ui/widgets/shimmer/sample_feature/shimmer_sample_feature_item.dart';

class ShimmerSampleFeatureList extends StatelessWidget {
  const ShimmerSampleFeatureList({super.key, this.itemHeight = 60});

  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var i = 0; i < 10; i++) ShimmerSampleFeatureItem(height: itemHeight),
        ],
      ),
    );
  }
}
