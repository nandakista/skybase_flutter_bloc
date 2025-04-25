/* Created by
   30/01/2024
   nanda.kista@gmail.com
*/

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'pagination/pagination_delegate.dart';

enum PaginationType {
  list,
  grid,
}

class PaginationStateView<T> extends StatelessWidget {
  const PaginationStateView.list({
    super.key,
    required this.pagingController,
    required this.itemBuilder,
    required this.onRetry,
    this.onRefresh,
    this.loadingView,
    this.emptyView,
    this.maxItemView,
    this.errorView,
    this.errorLoadMoreView,
    this.shrinkWrap = false,
    this.shrinkWrapFirstPageIndicators = false,
    this.physics,
    this.separator,
    this.emptyImageWidget,
    this.emptyImage,
    this.errorTitle,
    this.errorSubtitle,
    this.emptyTitle,
    this.emptySubtitle,
    this.emptyTitleStyle,
    this.emptySubtitleStyle,
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
    this.scrollDirection = Axis.vertical,
    this.padding,
    this.emptyRetryEnabled = false,
    this.addAutomaticKeepAlives,
    this.addRepaintBoundaries,
    this.addSemanticIndexes,
    this.cacheExtent,
    this.clipBehavior,
    this.dragStartBehavior,
    this.itemExtent,
    this.keyboardDismissBehavior,
    this.primary,
    this.reverse,
    this.scrollController,
    this.restorationId,
    this.prototypeItem,
    this.semanticIndexCallback,
    this.scrollBehavior,
    this.semanticChildCount,
    this.anchor,
    this.center,
  })  : type = PaginationType.list,
        gridDelegate = null,
        showNewPageErrorIndicatorAsGridChild = null,
        showNewPageProgressIndicatorAsGridChild = null,
        showNoMoreItemsIndicatorAsGridChild = null;

  const PaginationStateView.grid({
    super.key,
    required this.pagingController,
    required this.itemBuilder,
    required this.gridDelegate,
    required this.onRetry,
    this.onRefresh,
    this.showNewPageErrorIndicatorAsGridChild,
    this.showNewPageProgressIndicatorAsGridChild,
    this.showNoMoreItemsIndicatorAsGridChild,
    this.scrollDirection = Axis.vertical,
    this.padding,
    this.emptyRetryEnabled = false,
    this.addAutomaticKeepAlives,
    this.addRepaintBoundaries,
    this.addSemanticIndexes,
    this.cacheExtent,
    this.clipBehavior,
    this.dragStartBehavior,
    this.itemExtent,
    this.keyboardDismissBehavior,
    this.primary,
    this.reverse,
    this.scrollController,
    this.restorationId,
    this.loadingView,
    this.emptyView,
    this.maxItemView,
    this.errorView,
    this.errorLoadMoreView,
    this.shrinkWrap = false,
    this.shrinkWrapFirstPageIndicators = false,
    this.physics,
    this.emptyImageWidget,
    this.emptyImage,
    this.errorTitle,
    this.errorSubtitle,
    this.emptyTitle,
    this.emptySubtitle,
    this.emptyTitleStyle,
    this.emptySubtitleStyle,
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
  })  : type = PaginationType.grid,
        separator = null,
        prototypeItem = null,
        semanticIndexCallback = null,
        scrollBehavior = null,
        semanticChildCount = null,
        anchor = null,
        center = null;

  // Pagination properties
  final PaginationType type;
  final PagingController<int, T> pagingController;
  final ItemWidgetBuilder<T> itemBuilder;

  // Widget properties
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final Widget? separator;
  final EdgeInsetsGeometry? padding;
  final Axis scrollDirection;
  final bool? addAutomaticKeepAlives;
  final bool? addRepaintBoundaries;
  final bool? addSemanticIndexes;
  final double? cacheExtent;
  final Clip? clipBehavior;
  final DragStartBehavior? dragStartBehavior;
  final double? itemExtent;
  final ScrollViewKeyboardDismissBehavior? keyboardDismissBehavior;
  final bool? primary;
  final bool? reverse;
  final ScrollController? scrollController;
  final String? restorationId;

  // Grid
  final SliverGridDelegate? gridDelegate;
  final bool? showNewPageErrorIndicatorAsGridChild;
  final bool? showNewPageProgressIndicatorAsGridChild;
  final bool? showNoMoreItemsIndicatorAsGridChild;

  // Slivers list
  final Widget? prototypeItem;
  final int? Function(Widget, int)? semanticIndexCallback;
  final ScrollBehavior? scrollBehavior;
  final int? semanticChildCount;
  final double? anchor;
  final Key? center;

  // State properties
  final bool emptyRetryEnabled;
  final Widget? loadingView;
  final Widget? emptyView;
  final Widget? maxItemView;
  final Widget? errorView;
  final Widget? errorLoadMoreView;
  final bool shrinkWrapFirstPageIndicators;
  final VoidCallback? onRefresh;
  final VoidCallback onRetry;
  final Widget? emptyImageWidget;
  final String? emptyImage;
  final String? errorTitle;
  final String? errorSubtitle;
  final String? emptyTitle;
  final String? emptySubtitle;
  final TextStyle? emptyTitleStyle;
  final TextStyle? emptySubtitleStyle;
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

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return _iosPaginationView();
    } else {
      return _androidPaginationView();
    }
  }

  Widget _buildChildByType({bool isSliver = false}) {
    if (isSliver) {
      return switch (type) {
        PaginationType.list => _buildPagedSliverList(),
        PaginationType.grid => _buildPagedSliverGrid(),
      };
    } else {
      return switch (type) {
        PaginationType.list => _buildPagedList(),
        PaginationType.grid => _buildPagedGrid(),
      };
    }
  }

  Widget _androidPaginationView() {
    if (onRefresh != null) {
      return RefreshIndicator(
        onRefresh: () => Future.sync(onRefresh!),
        child: _buildChildByType(),
      );
    } else {
      return _buildChildByType();
    }
  }

  Widget _iosPaginationView() {
    if (onRefresh != null && scrollDirection == Axis.vertical) {
      return Padding(
        key: key,
        padding: padding ?? EdgeInsets.zero,
        child: CustomScrollView(
          shrinkWrap: shrinkWrap,
          physics: physics,
          scrollDirection: scrollDirection,
          scrollBehavior: scrollBehavior,
          controller: scrollController,
          keyboardDismissBehavior: keyboardDismissBehavior ??
              ScrollViewKeyboardDismissBehavior.manual,
          cacheExtent: cacheExtent,
          clipBehavior: clipBehavior ?? Clip.hardEdge,
          dragStartBehavior: dragStartBehavior ?? DragStartBehavior.start,
          primary: primary,
          restorationId: restorationId,
          reverse: reverse ?? false,
          semanticChildCount: semanticChildCount,
          anchor: anchor ?? 0.0,
          center: center,
          slivers: [
            CupertinoSliverRefreshControl(
              onRefresh: () => Future.sync(onRefresh!),
            ),
            _buildChildByType(isSliver: true),
          ],
        ),
      );
    } else {
      return _buildChildByType();
    }
  }

  Widget _buildPagedList() {
    return PagedListView.separated(
      key: key,
      pagingController: pagingController,
      builderDelegate: _builderDelete(),
      addAutomaticKeepAlives: addAutomaticKeepAlives ?? true,
      addRepaintBoundaries: addRepaintBoundaries ?? true,
      addSemanticIndexes: addSemanticIndexes ?? true,
      cacheExtent: cacheExtent,
      clipBehavior: clipBehavior ?? Clip.hardEdge,
      dragStartBehavior: dragStartBehavior ?? DragStartBehavior.start,
      itemExtent: itemExtent,
      keyboardDismissBehavior:
          keyboardDismissBehavior ?? ScrollViewKeyboardDismissBehavior.manual,
      primary: primary,
      restorationId: restorationId,
      reverse: reverse ?? false,
      scrollController: scrollController,
      shrinkWrap: shrinkWrap,
      physics: physics,
      scrollDirection: scrollDirection,
      padding: padding,
      separatorBuilder: (BuildContext context, int index) {
        return separator ?? const SizedBox.shrink();
      },
    );
  }

  Widget _buildPagedSliverList() {
    return PagedSliverList(
      key: key,
      pagingController: pagingController,
      builderDelegate: _builderDelete(),
      addAutomaticKeepAlives: addAutomaticKeepAlives ?? true,
      addRepaintBoundaries: addRepaintBoundaries ?? true,
      addSemanticIndexes: addSemanticIndexes ?? true,
      itemExtent: itemExtent,
      prototypeItem: prototypeItem,
      semanticIndexCallback: semanticIndexCallback,
      shrinkWrapFirstPageIndicators: shrinkWrapFirstPageIndicators,
    );
  }

  Widget _buildPagedGrid() {
    return PagedGridView(
      key: key,
      pagingController: pagingController,
      builderDelegate: _builderDelete(),
      gridDelegate: gridDelegate!,
      addAutomaticKeepAlives: addAutomaticKeepAlives ?? true,
      addRepaintBoundaries: addRepaintBoundaries ?? true,
      addSemanticIndexes: addSemanticIndexes ?? true,
      cacheExtent: cacheExtent,
      clipBehavior: clipBehavior ?? Clip.hardEdge,
      dragStartBehavior: dragStartBehavior ?? DragStartBehavior.start,
      keyboardDismissBehavior:
          keyboardDismissBehavior ?? ScrollViewKeyboardDismissBehavior.manual,
      primary: primary,
      restorationId: restorationId,
      reverse: reverse ?? false,
      scrollController: scrollController,
      shrinkWrap: shrinkWrap,
      physics: physics,
      scrollDirection: scrollDirection,
      padding: padding,
      showNewPageErrorIndicatorAsGridChild:
          showNewPageErrorIndicatorAsGridChild ?? false,
      showNewPageProgressIndicatorAsGridChild:
          showNewPageProgressIndicatorAsGridChild ?? false,
      showNoMoreItemsIndicatorAsGridChild:
          showNoMoreItemsIndicatorAsGridChild ?? false,
    );
  }

  Widget _buildPagedSliverGrid() {
    return PagedSliverGrid(
      key: key,
      pagingController: pagingController,
      builderDelegate: _builderDelete(),
      gridDelegate: gridDelegate!,
      addAutomaticKeepAlives: addAutomaticKeepAlives ?? true,
      addRepaintBoundaries: addRepaintBoundaries ?? true,
      addSemanticIndexes: addSemanticIndexes ?? true,
      showNewPageErrorIndicatorAsGridChild:
          showNewPageErrorIndicatorAsGridChild ?? false,
      showNewPageProgressIndicatorAsGridChild:
          showNewPageProgressIndicatorAsGridChild ?? false,
      showNoMoreItemsIndicatorAsGridChild:
          showNoMoreItemsIndicatorAsGridChild ?? false,
      shrinkWrapFirstPageIndicators: shrinkWrapFirstPageIndicators,
    );
  }

  PagedChildBuilderDelegate<T> _builderDelete() {
    return PaginationDelegate<T>(
      pagingController: pagingController,
      onRetry: onRetry,
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
      errorLoadMoreView: errorLoadMoreView,
      errorView: errorView,
    );
  }
}
