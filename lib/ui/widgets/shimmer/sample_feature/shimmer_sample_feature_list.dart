import 'package:flutter/material.dart';
import 'package:skybase/ui/widgets/shimmer/sample_feature/shimmer_sample_feature_item.dart';
import 'package:skybase/ui/widgets/shimmer/shimmer_list_view.dart';

class ShimmerSampleFeatureList extends StatelessWidget {
  const ShimmerSampleFeatureList({super.key, this.itemHeight = 60});

  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    return ShimmerListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ShimmerSampleFeatureItem(height: itemHeight);
      },
    );
  }
}
