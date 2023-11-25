import 'package:flutter/material.dart';

/* Created by
   Varcant
   05/11/2022
   nanda.kista@gmail.com
*/

enum SortBy {
  ASC,
  DESC,
}

class SkyGroupedListView<T, G> extends StatelessWidget {
  const SkyGroupedListView({
    super.key,
    required this.data,
    required this.groupBy,
    required this.groupHeaderBuilder,
    required this.itemBuilder,
    this.controller,
    this.sortBy = SortBy.ASC,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
    this.separator,
    this.separatorGroup,
    this.groupFooterBuilder,
  });

  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final List<T> data;
  final Widget Function(G element) groupHeaderBuilder;
  final Widget Function(BuildContext context, int index, T element) itemBuilder;
  final Widget Function(G element)? groupFooterBuilder;
  final ScrollController? controller;
  final SortBy sortBy;
  final G Function(T element) groupBy;
  final EdgeInsetsGeometry? padding;
  final Widget? separator;
  final Widget? separatorGroup;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: shrinkWrap,
      physics: physics,
      padding: padding ?? const EdgeInsets.all(0),
      itemCount: data.length,
      controller: controller,
      reverse: sortBy == SortBy.ASC ? false : true,
      itemBuilder: (_, index) {
        (data).sort(
          (b, a) => (groupBy(b) as dynamic)!.compareTo(
            groupBy(a),
          ),
        );

        bool isSame = true;
        final G item = groupBy(data[index]);

        G prevItem;
        if (index != 0) {
          prevItem = groupBy(data[index - 1]);
          isSame = item == prevItem;
        } else {
          prevItem = item;
          isSame = item == prevItem;
        }

        G nextItem;
        if (index == data.length - 1) {
          nextItem = item;
        } else {
          nextItem = groupBy(data[index + 1]);
        }

        if (sortBy == SortBy.ASC) {
          return Column(
            children: [
              if (index == 0 || !isSame) _buildHeaderWidget(item),
              if (index != 0 && item == prevItem)
                _buildSeparatorWidget(separator),
              _buildItemWidget(context, index),
              if (groupFooterBuilder != null &&
                  (item != nextItem || index + 1 == data.length))
                groupFooterBuilder!(item),
            ],
          );
        } else {
          return Column(
            children: [
              // Last Index
              if (index + 1 == data.length) _buildHeaderWidget(item),
              // Content
              _buildItemWidget(context, index),
              if (index != 0 && item == prevItem)
                _buildSeparatorWidget(separator),
              if (groupFooterBuilder != null &&
                  (item != prevItem || index == 0))
                groupFooterBuilder!(item),
              if (!isSame) _buildHeaderWidget(prevItem),
            ],
          );
        }
      },
    );
  }

  _buildHeaderWidget(G item) {
    return Column(
      children: [
        SizedBox(width: double.infinity, child: groupHeaderBuilder(item)),
        _buildSeparatorWidget(separatorGroup),
      ],
    );
  }

  _buildItemWidget(BuildContext context, int index) {
    return SizedBox(
      width: double.infinity,
      child: itemBuilder(context, index, data[index]),
    );
  }

  _buildSeparatorWidget(Widget? item) {
    return SizedBox(
      width: double.infinity,
      child: item ?? const SizedBox.shrink(),
    );
  }
}
