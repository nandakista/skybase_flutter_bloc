/* Created by
   30/01/2024
   nanda.kista@gmail.com
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skybase/ui/widgets/base/pagination/pagination_delegate.dart';

/// Helper Widget that combine [PagedSliverGrid] and [PaginationDelegate].
///
/// useful to quickly build a SliverGridComponent in one widget.
class PaginationSliverGrid<T> extends StatelessWidget {
  const PaginationSliverGrid({
    super.key,
    required this.pagingController,
    required this.itemBuilder,
    required this.gridDelegate,
    this.padding,
    this.showNewPageErrorIndicatorAsGridChild = false,
    this.showNewPageProgressIndicatorAsGridChild = false,
    this.showNoMoreItemsIndicatorAsGridChild = false,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.loadingView,
    this.emptyView,
    this.errorView,
    this.errorLoadView,
    this.maxItemView,
    this.emptyImage,
    this.emptyTitle,
    this.emptySubtitle,
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
    this.onRefresh,
  });

  final PagingController<int, T> pagingController;
  final ItemWidgetBuilder<T> itemBuilder;
  final SliverGridDelegate gridDelegate;
  final bool showNewPageErrorIndicatorAsGridChild;
  final bool showNewPageProgressIndicatorAsGridChild;
  final bool showNoMoreItemsIndicatorAsGridChild;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final bool shrinkWrapFirstPageIndicators = false;
  final Widget? loadingView;
  final Widget? emptyView;
  final Widget? maxItemView;
  final Widget? errorView;
  final Widget? errorLoadView;
  final VoidCallback? onRefresh;
  final Widget? emptyImageWidget;
  final String? emptyImage;
  final String? errorTitle;
  final String? errorSubtitle;
  final String? emptyTitle;
  final String? emptySubtitle;
  final TextStyle? emptyTitleStyle;
  final TextStyle? emptySubtitleStyle;
  final bool enableIOSStyle = true;
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
  final Axis scrollDirection = Axis.vertical;
  final bool emptyRetryEnabled = false;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: padding ?? EdgeInsets.zero,
      sliver: PagedSliverGrid(
        gridDelegate: gridDelegate,
        pagingController: pagingController,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        showNoMoreItemsIndicatorAsGridChild:
            showNoMoreItemsIndicatorAsGridChild,
        showNewPageErrorIndicatorAsGridChild:
            showNewPageErrorIndicatorAsGridChild,
        showNewPageProgressIndicatorAsGridChild:
            showNewPageProgressIndicatorAsGridChild,
        shrinkWrapFirstPageIndicators: shrinkWrapFirstPageIndicators,
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
      ),
    );
  }
}
