import 'package:flutter/material.dart';

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
    this.sortBy = SortBy.asc,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
    this.separator,
    this.separatorHeader,
    this.groupFooterBuilder,
    this.separatorGroup,
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
  final Widget? separatorHeader;
  final Widget? separatorGroup;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: shrinkWrap,
      physics: physics,
      padding: padding ?? const EdgeInsets.all(0),
      itemCount: data.length,
      controller: controller,
      reverse: sortBy == SortBy.asc ? false : true,
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

        bool isFirstIndex = index == 0;
        bool isLastIndex = index + 1 == data.length;

        if (sortBy == SortBy.asc) {
          return Column(
            children: [
              if (isFirstIndex || !isSame) _buildHeaderWidget(item),
              if (!isFirstIndex && item == prevItem)
                _buildSeparatorWidget(separator),
              _buildItemWidget(context, index),
              if (groupFooterBuilder != null &&
                  (item != nextItem || isLastIndex))
                groupFooterBuilder!(item),
              if (separatorGroup != null &&
                  (item != nextItem || isLastIndex) &&
                  !isLastIndex)
                separatorGroup!,
            ],
          );
        } else {
          return Column(
            children: [
              if (isLastIndex) _buildHeaderWidget(item),
              _buildItemWidget(context, index),
              if (!isFirstIndex && item == prevItem)
                _buildSeparatorWidget(separator),
              if (groupFooterBuilder != null &&
                  (item != prevItem || isFirstIndex))
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
        _buildSeparatorWidget(separatorHeader),
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

class SliverGroupedListView<T, G> extends StatelessWidget {
  const SliverGroupedListView({
    super.key,
    required this.data,
    required this.groupBy,
    required this.groupHeaderBuilder,
    required this.itemBuilder,
    this.sortBy = SortBy.asc,
    this.separator,
    this.separatorHeader,
    this.groupFooterBuilder,
    this.separatorGroup,
    required this.separatorBuilder,
  });

  final List<T> data;
  final Widget Function(G element) groupHeaderBuilder;
  final Widget Function(BuildContext context, int index, T element) itemBuilder;
  final Widget Function(G element)? groupFooterBuilder;
  final SortBy sortBy;
  final G Function(T element) groupBy;
  final Widget? separator;
  final Widget? separatorHeader;
  final Widget? separatorGroup;

  final Widget? Function(BuildContext, int) separatorBuilder;

  @override
  Widget build(BuildContext context) {
    return SliverList.separated(
      itemCount: data.length,
      separatorBuilder: separatorBuilder,
      itemBuilder: (context, index) {

        bool isFirstIndex = index == 0;
        bool isLastIndex = index + 1 == data.length;

        (data).sort(
              (b, a) => (groupBy(b) as dynamic)!.compareTo(
            groupBy(a),
          ),
        );

        bool isSame = true;
        final G item = groupBy(data[index]);

        G prevItem;
        if (!isFirstIndex) {
          prevItem = groupBy(data[index - 1]);
          isSame = item == prevItem;
        } else {
          prevItem = item;
          isSame = item == prevItem;
        }

        G nextItem;
        if (isLastIndex) {
          nextItem = item;
        } else {
          nextItem = groupBy(data[index + 1]);
        }

        if (sortBy == SortBy.asc) {
          return Column(
            children: [
              if (isFirstIndex || !isSame) _buildHeaderWidget(item),
              if (!isFirstIndex && item == prevItem)
                _buildSeparatorWidget(separator),
              _buildItemWidget(context, index),
              if (groupFooterBuilder != null &&
                  (item != nextItem || isLastIndex))
                groupFooterBuilder!(item),
              if (separatorGroup != null &&
                  (item != nextItem || isLastIndex) &&
                  !isLastIndex)
                separatorGroup!,
            ],
          );
        } else {
          return Column(
            children: [
              if (isLastIndex) _buildHeaderWidget(item),
              _buildItemWidget(context, index),
              if (!isFirstIndex && item == prevItem)
                _buildSeparatorWidget(separator),
              if (groupFooterBuilder != null &&
                  (item != prevItem || isFirstIndex))
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
        _buildSeparatorWidget(separatorHeader),
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
