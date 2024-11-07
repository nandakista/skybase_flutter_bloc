import 'package:flutter/material.dart';
import 'package:collection/collection.dart' as c;

/* Created by
   Varcant
   05/11/2022
   nanda.kista@gmail.com
*/

enum SortBy {
  asc,
  desc,
}

class GroupedListView<T, G> extends StatelessWidget {
  const GroupedListView({
    super.key,
    required this.data,
    required this.groupBy,
    required this.groupHeaderBuilder,
    required this.itemBuilder,
    this.controller,
    this.sortGroupBy = SortBy.asc,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
    this.separator,
    this.groupFooterBuilder,
    this.separatorGroup,
    this.reverse = false,
    this.sortGroupItems,
  });

  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final List<T> data;
  final Widget Function(G element) groupHeaderBuilder;
  final Widget Function(BuildContext context, int index, T element) itemBuilder;
  final Widget Function(G element)? groupFooterBuilder;
  final ScrollController? controller;
  final SortBy sortGroupBy;
  final G Function(T element) groupBy;
  final EdgeInsetsGeometry? padding;
  final Widget? separator;
  final Widget? separatorGroup;
  final bool reverse;
  final int Function(T, T)? sortGroupItems;

  @override
  Widget build(BuildContext context) {
    switch (sortGroupBy) {
      case SortBy.asc:
        (data).sort((b, a) => (groupBy(b) as dynamic)!.compareTo(groupBy(a)));
        break;
      case SortBy.desc:
        (data).sort((b, a) => (groupBy(a) as dynamic)!.compareTo(groupBy(b)));
        break;
    }

    Map<G, List<T>> groupedData =
        c.groupBy<T, G>((data).where((_) => true), groupBy);

    List<G> groupList = groupedData.keys.toList();

    return ListView.separated(
      shrinkWrap: shrinkWrap,
      physics: physics,
      padding: padding ?? const EdgeInsets.all(0),
      itemCount: groupList.length,
      controller: controller,
      reverse: reverse,
      itemBuilder: (_, indexGroup) {
        G group = groupList[indexGroup];
        List<T> groupItems = groupedData.values.toList()[indexGroup];
        if (sortGroupItems != null) {
          groupItems.sort(sortGroupItems);
        }

        return Column(
          children: [
            groupHeaderBuilder(group),
            ListView.separated(
              itemCount: groupItems.length,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return itemBuilder(context, index, groupItems[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return separator ?? const SizedBox.shrink();
              },
            ),
            if (groupFooterBuilder != null) groupFooterBuilder!(group),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return separatorGroup ?? const SizedBox.shrink();
      },
    );
  }
}

class SliverGroupedListView<T, G> extends StatelessWidget {
  const SliverGroupedListView({
    super.key,
    required this.data,
    required this.groupBy,
    required this.groupHeaderBuilder,
    required this.itemBuilder,
    this.sortGroupBy = SortBy.asc,
    this.separator,
    this.separatorHeader,
    this.groupFooterBuilder,
    required this.separatorGroupBuilder,
    this.sortGroupItems,
  });

  final List<T> data;
  final Widget Function(G element) groupHeaderBuilder;
  final Widget Function(BuildContext context, int index, T element) itemBuilder;
  final Widget Function(G element)? groupFooterBuilder;
  final SortBy sortGroupBy;
  final G Function(T element) groupBy;
  final Widget? separator;
  final Widget? separatorHeader;
  final NullableIndexedWidgetBuilder separatorGroupBuilder;
  final int Function(T, T)? sortGroupItems;

  @override
  Widget build(BuildContext context) {
    switch (sortGroupBy) {
      case SortBy.asc:
        (data).sort((b, a) => (groupBy(b) as dynamic)!.compareTo(groupBy(a)));
        break;
      case SortBy.desc:
        (data).sort((b, a) => (groupBy(a) as dynamic)!.compareTo(groupBy(b)));
        break;
    }

    Map<G, List<T>> groupedData =
        c.groupBy<T, G>((data).where((_) => true), groupBy);

    List<G> groupList = groupedData.keys.toList();

    return SliverList.separated(
      itemCount: groupList.length,
      separatorBuilder: separatorGroupBuilder,
      itemBuilder: (context, indexGroup) {
        G group = groupList[indexGroup];
        List<T> groupItems = groupedData.values.toList()[indexGroup];
        if (sortGroupItems != null) {
          groupItems.sort(sortGroupItems);
        }

        return Column(
          children: [
            groupHeaderBuilder(group),
            ListView.separated(
              itemCount: groupItems.length,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return itemBuilder(context, index, groupItems[index]);
              },
              separatorBuilder: (BuildContext context, int index) {
                return separator ?? const SizedBox.shrink();
              },
            ),
            if (groupFooterBuilder != null) groupFooterBuilder!(group),
          ],
        );
      },
    );
  }
}
