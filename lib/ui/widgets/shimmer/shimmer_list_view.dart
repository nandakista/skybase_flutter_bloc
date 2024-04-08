import 'package:flutter/material.dart';

class ShimmerListView extends StatelessWidget {
  const ShimmerListView({
    super.key,
    required this.children,
    this.physics,
    this.padding,
    this.scrollDirection,
  })  : itemBuilder = null,
        itemCount = null,
        separatorBuilder = null;

  const ShimmerListView.separated({
    super.key,
    required this.itemCount,
    required this.separatorBuilder,
    required this.itemBuilder,
    this.physics,
    this.padding,
    this.scrollDirection,
  }) : children = null;

  const ShimmerListView.builder({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.physics,
    this.padding,
    this.scrollDirection,
  })  : separatorBuilder = null,
        children = null;

  final int? itemCount;
  final IndexedWidgetBuilder? itemBuilder;
  final IndexedWidgetBuilder? separatorBuilder;
  final List<Widget>? children;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final Axis? scrollDirection;

  @override
  Widget build(BuildContext context) {
    if (children != null) {
      return SingleChildScrollView(
        padding: padding,
        physics: physics,
        scrollDirection: scrollDirection ?? Axis.vertical,
        child: Column(
          children: children!,
        ),
      );
    } else if (separatorBuilder != null) {
      return SingleChildScrollView(
        padding: padding,
        physics: physics,
        scrollDirection: scrollDirection ?? Axis.vertical,
        child: Column(
          children: List.generate(
            itemCount! * 2,
            (index) => index.isOdd
                ? separatorBuilder!(context, (index - 1) ~/ 2)
                : itemBuilder!(context, index ~/ 2),
          ),
        ),
      );
    } else {
      return SingleChildScrollView(
        padding: padding,
        physics: physics,
        scrollDirection: scrollDirection ?? Axis.vertical,
        child: Column(
          children: List.generate(
            itemCount!,
            (index) => itemBuilder!(context, index),
          ),
        ),
      );
    }
  }
}
