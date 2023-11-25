import 'package:flutter/material.dart';
import 'package:skybase/ui/widgets/shimmer/shimmer_item_list.dart';

class ShimmerList extends StatelessWidget {
  const ShimmerList({super.key, this.itemHeight = 60});

  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var i = 0; i < 10; i++) ShimmerItemList(height: itemHeight),
        ],
      ),
    );
  }
}
