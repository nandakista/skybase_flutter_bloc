/* Created by
   30/01/2024
   nanda.kista@gmail.com
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skybase/ui/widgets/base/pagination/pagination_delegate.dart';
import 'package:skybase/ui/widgets/grouped_listview.dart';

/// Helper Widget that combine [PagedSliverList] and [PaginationDelegate].
///
/// useful to quickly build a SliverListComponent in one widget.
class PaginationSliverList<T> extends StatelessWidget {
  const PaginationSliverList({
    super.key,
    required this.pagingController,
    required this.itemBuilder,
    this.loadingView,
    this.emptyView,
    this.errorView,
    this.errorLoadView,
    this.maxItemView,
    this.emptyImage,
    this.emptyTitle,
    this.emptySubtitle,
    this.enableIOSStyle = true,
    this.errorTitle,
    this.errorSubtitle,
    this.errorImage,
    this.errorImageWidget,
    this.retryText,
    this.verticalSpacing,
    this.horizontalSpacing,
    this.imageHeight,
    this.imageWidth,
    this.errorTitleStyle,
    this.errorSubtitleStyle,
    this.retryWidget,
    this.emptyImageWidget,
    this.emptyTitleStyle,
    this.emptySubtitleStyle,
    this.shrinkWrapFirstPageIndicators = false,
    this.separator,
    this.padding,
    this.emptyRetryEnabled = false,
    this.itemExtent,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.semanticIndexCallback,
  });

  final PagingController<int, T> pagingController;
  final ItemWidgetBuilder<T> itemBuilder;
  final bool emptyRetryEnabled;
  final Widget? loadingView;
  final Widget? emptyView;
  final Widget? maxItemView;
  final Widget? errorView;
  final Widget? errorLoadView;
  final bool shrinkWrapFirstPageIndicators;
  final Widget? separator;
  final Widget? emptyImageWidget;
  final String? emptyImage;
  final String? errorTitle;
  final String? errorSubtitle;
  final String? emptyTitle;
  final String? emptySubtitle;
  final TextStyle? emptyTitleStyle;
  final TextStyle? emptySubtitleStyle;
  final bool enableIOSStyle;
  final String? errorImage;
  final Widget? errorImageWidget;
  final String? retryText;
  final double? verticalSpacing;
  final double? horizontalSpacing;
  final double? imageHeight;
  final double? imageWidth;
  final TextStyle? errorTitleStyle;
  final TextStyle? errorSubtitleStyle;
  final Widget? retryWidget;
  final EdgeInsetsGeometry? padding;
  final double? itemExtent;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final int? Function(Widget, int)? semanticIndexCallback;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: padding ?? EdgeInsets.zero,
      sliver: PagedSliverList.separated(
        shrinkWrapFirstPageIndicators: shrinkWrapFirstPageIndicators,
        pagingController: pagingController,
        semanticIndexCallback: semanticIndexCallback,
        itemExtent: itemExtent,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addSemanticIndexes: addSemanticIndexes,
        addRepaintBoundaries: addRepaintBoundaries,
        builderDelegate: PaginationDelegate<T>(
          pagingController: pagingController,
          loadingView: loadingView,
          emptyView: emptyView,
          emptyRetryEnabled: emptyRetryEnabled,
          emptyTitle: emptyTitle,
          emptyTitleStyle: emptyTitleStyle,
          errorTitleStyle: errorTitleStyle,
          errorTitle: errorTitle,
          errorSubtitle: errorSubtitle,
          errorSubtitleStyle: errorSubtitleStyle,
          errorImage: errorImage,
          errorImageWidget: errorImageWidget,
          retryText: retryText,
          retryWidget: retryWidget,
          maxItemView: maxItemView,
          emptyImage: emptyImage,
          emptyImageWidget: emptyImageWidget,
          emptySubtitle: emptySubtitle,
          emptySubtitleStyle: emptySubtitleStyle,
          verticalSpacing: verticalSpacing,
          horizontalSpacing: horizontalSpacing,
          imageHeight: imageHeight,
          imageWidth: imageWidth,
          itemBuilder: itemBuilder,
          errorLoadView: errorLoadView,
          errorView: errorView,
        ),
        separatorBuilder: (BuildContext context, int index) {
          return separator ?? const SizedBox.shrink();
        },
      ),
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
