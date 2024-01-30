/* Created by
   30/01/2024
   nanda.kista@gmail.com
*/

import 'package:flutter/material.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skybase/ui/widgets/grouped_listview.dart';
import 'package:sliver_tools/sliver_tools.dart';

class PagedGroupedListView<PageKeyType, T, G> extends BoxScrollView {
  const PagedGroupedListView({
    super.key,
    required this.pagingController,
    required this.groupHeaderBuilder,
    this.groupFooterBuilder,
    required this.builderDelegate,
    required this.groupBy,
    this.shrinkWrapFirstPageIndicators = false,
    this.separator,
    this.separatorHeader,
    this.separatorGroup,
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding,
    super.cacheExtent,
    super.semanticChildCount,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
  });

  final PagingController<PageKeyType, T> pagingController;
  final PagedChildBuilderDelegate<T> builderDelegate;
  final bool shrinkWrapFirstPageIndicators;
  final Widget Function(G element) groupHeaderBuilder;
  final Widget Function(G element)? groupFooterBuilder;
  final G Function(T element) groupBy;
  final Widget? separator;
  final Widget? separatorHeader;
  final Widget? separatorGroup;

  @override
  Widget buildChildLayout(BuildContext context) {
    return PagedSliverGroupedListView(
      pagingController: pagingController,
      builderDelegate: builderDelegate,
      shrinkWrapFirstPageIndicators: shrinkWrapFirstPageIndicators,
      groupBy: groupBy,
      groupHeaderBuilder: groupHeaderBuilder,
      groupFooterBuilder: groupFooterBuilder,
      separator: separator,
      separatorHeader: separatorHeader,
      separatorGroup: separatorGroup,
    );
  }
}

class PagedSliverGroupedListView<PageKeyType, T, G> extends StatelessWidget {
  const PagedSliverGroupedListView({
    super.key,
    required this.pagingController,
    required this.builderDelegate,
    this.shrinkWrapFirstPageIndicators = false,
    required this.groupBy,
    required this.groupHeaderBuilder,
    this.separator = const SizedBox.shrink(),
    this.groupFooterBuilder,
    this.separatorHeader,
    this.separatorGroup,
    this.sortBy = SortBy.asc,
  });

  final PagingController<PageKeyType, T> pagingController;
  final PagedChildBuilderDelegate<T> builderDelegate;
  final bool shrinkWrapFirstPageIndicators;
  final Widget Function(G element) groupHeaderBuilder;
  final Widget Function(G element)? groupFooterBuilder;
  final G Function(T element) groupBy;
  final Widget? separator;
  final Widget? separatorHeader;
  final Widget? separatorGroup;
  final SortBy sortBy;

  @override
  Widget build(BuildContext context) {
    Widget buildLayout(
      IndexedWidgetBuilder itemBuilder,
      int itemCount, {
      WidgetBuilder? statusIndicatorBuilder,
    }) =>
        MultiSliver(
          children: [
            SliverGroupedListView(
              data: pagingController.itemList!,
              groupBy: groupBy,
              itemBuilder: (context, index, item) =>
                  itemBuilder(context, index),
              groupHeaderBuilder: groupHeaderBuilder,
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox.shrink();
              },
              groupFooterBuilder: groupFooterBuilder,
              separatorGroup: separatorGroup,
              separatorHeader: separatorHeader,
              separator: separator,
              sortBy: sortBy,
            ),
            if (statusIndicatorBuilder != null)
              SliverToBoxAdapter(
                child: statusIndicatorBuilder(context),
              )
          ],
        );

    return PagedLayoutBuilder<PageKeyType, T>(
      layoutProtocol: PagedLayoutProtocol.sliver,
      pagingController: pagingController,
      builderDelegate: builderDelegate,
      shrinkWrapFirstPageIndicators: shrinkWrapFirstPageIndicators,
      completedListingBuilder: (
        context,
        itemBuilder,
        itemCount,
        noMoreItemsIndicatorBuilder,
      ) =>
          buildLayout(
        itemBuilder,
        itemCount,
        statusIndicatorBuilder: noMoreItemsIndicatorBuilder,
      ),
      loadingListingBuilder: (
        context,
        itemBuilder,
        itemCount,
        progressIndicatorBuilder,
      ) =>
          buildLayout(
        itemBuilder,
        itemCount,
        statusIndicatorBuilder: progressIndicatorBuilder,
      ),
      errorListingBuilder: (
        context,
        itemBuilder,
        itemCount,
        errorIndicatorBuilder,
      ) =>
          buildLayout(
        itemBuilder,
        itemCount,
        statusIndicatorBuilder: errorIndicatorBuilder,
      ),
    );
  }
}
