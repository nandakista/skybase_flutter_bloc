/* Created by
   Varcant
   nanda.kista@gmail.com
*/

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/ui/widgets/platform_loading_indicator.dart';

import 'empty_view.dart';
import 'error_view.dart';

class BasePaginationView<ItemType> extends StatelessWidget {
  const BasePaginationView({
    super.key,
    required this.pagingController,
    required this.itemBuilder,
    this.onRefresh,
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
    this.imageSize,
    this.errorTitleStyle,
    this.errorSubtitleStyle,
    this.retryWidget,
    this.emptyImageWidget,
    this.emptyTitleStyle,
    this.emptySubtitleStyle,
    this.shrinkWrap = false,
    this.physics,
    this.separator,
    this.scrollDirection = Axis.vertical,
    this.padding,
    this.emptyEnabled = true,
    this.errorEnabled = true,
  });

  final PagingController<int, ItemType> pagingController;

  // final ItemWidgetBuilder
  final ItemWidgetBuilder<ItemType> itemBuilder;

  final bool emptyEnabled;

  final bool errorEnabled;

  final Widget? loadingView;

  /// ** Empty View **
  /// View when data list is empty
  final Widget? emptyView;

  /// ** Error View **
  /// View when all item already loaded
  final Widget? maxItemView;

  /// ** Max Item Indicator/View **
  /// View when initial/first load error
  final Widget? errorView;

  /// ** Error load  ** .
  /// View when load pagination error
  final Widget? errorLoadView;

  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final Widget? separator;

  final VoidCallback? onRefresh;
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
  final double? imageSize;
  final TextStyle? errorTitleStyle;
  final TextStyle? errorSubtitleStyle;
  final Widget? retryWidget;
  final Axis scrollDirection;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      if (enableIOSStyle) return _iosPaginationView();
      return _androidPaginationView();
    } else {
      return _androidPaginationView();
    }
  }

  Widget _androidPaginationView() {
    if (onRefresh != null) {
      return RefreshIndicator(
        onRefresh: () => Future.sync(onRefresh!),
        child: PagedListView.separated(
          scrollDirection: scrollDirection,
          padding: padding,
          pagingController: pagingController,
          builderDelegate: _builderDelete(),
          separatorBuilder: (BuildContext context, int index) {
            return separator ?? const SizedBox.shrink();
          },
        ),
      );
    } else {
      return PagedListView.separated(
        shrinkWrap: shrinkWrap,
        physics: physics,
        scrollDirection: scrollDirection,
        padding: padding,
        pagingController: pagingController,
        builderDelegate: _builderDelete(),
        separatorBuilder: (BuildContext context, int index) {
          return separator ?? const SizedBox.shrink();
        },
      );
    }
  }

  Widget _iosPaginationView() {
    if (onRefresh != null) {
      return Padding(
        padding: padding ?? EdgeInsets.zero,
        child: CustomScrollView(
          shrinkWrap: shrinkWrap,
          physics: physics,
          scrollDirection: scrollDirection,
          slivers: [
            CupertinoSliverRefreshControl(
              onRefresh: () => Future.sync(onRefresh!),
            ),
            PagedSliverList(
              pagingController: pagingController,
              builderDelegate: _builderDelete(),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: padding ?? EdgeInsets.zero,
        child: CustomScrollView(
          shrinkWrap: shrinkWrap,
          physics: physics,
          scrollDirection: scrollDirection,
          slivers: [
            PagedSliverList(
              pagingController: pagingController,
              builderDelegate: _builderDelete(),
            ),
          ],
        ),
      );
    }
  }

  PagedChildBuilderDelegate<ItemType> _builderDelete() {
    return PagedChildBuilderDelegate<ItemType>(
      animateTransitions: true,
      newPageProgressIndicatorBuilder: (ctx) =>
          const PlatformLoadingIndicator(),
      firstPageProgressIndicatorBuilder: (ctx) => Padding(
        padding: const EdgeInsets.all(24.0),
        child: loadingView ?? const PlatformLoadingIndicator(),
      ),
      noItemsFoundIndicatorBuilder: (ctx) => emptyEnabled
          ? emptyView ??
              EmptyView(
                emptyImage: emptyImage,
                emptyImageWidget: emptyImageWidget,
                emptyTitle: emptyTitle,
                emptySubtitle: emptySubtitle,
                titleStyle: emptyTitleStyle,
                subtitleStyle: emptySubtitleStyle,
                horizontalSpacing: horizontalSpacing ?? 24,
                verticalSpacing: verticalSpacing ?? 24,
                imageSize: imageSize,
                physics: const NeverScrollableScrollPhysics(),
              )
          : const SizedBox.shrink(),
      firstPageErrorIndicatorBuilder: (ctx) => errorEnabled
          ? errorView ??
              ErrorView(
                errorImage: errorImage,
                errorImageWidget: errorImageWidget,
                errorTitle:
                    '${errorTitle ?? pagingController.error ?? 'txt_err_general_formal'.tr()}',
                errorSubtitle: errorSubtitle,
                horizontalSpacing: horizontalSpacing ?? 24,
                verticalSpacing: verticalSpacing ?? 24,
                titleStyle: errorTitleStyle,
                subtitleStyle: errorSubtitleStyle,
                imageSize: imageSize,
                retryText: retryText,
                retryWidget: retryWidget,
                physics: const BouncingScrollPhysics(),
                onRetry: () => pagingController.retryLastFailedRequest(),
              )
          : const SizedBox.shrink(),
      // noMoreItemsIndicatorBuilder: (ctx) =>
      //     maxItemView ?? const PaginationMaxItemView(),
      newPageErrorIndicatorBuilder: (ctx) =>
          errorLoadView ??
          PaginationErrorLoadView(
            pagingController: pagingController,
          ),
      itemBuilder: itemBuilder,
    );
  }
}

class PaginationErrorLoadView<ItemType> extends StatelessWidget {
  const PaginationErrorLoadView({
    super.key,
    required this.pagingController,
  });

  final PagingController<int, ItemType> pagingController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Text(
          'txt_err_general_formal'.tr(),
          style: const TextStyle(color: Colors.grey),
        ),
        TextButton(
          onPressed: () => pagingController.retryLastFailedRequest(),
          child: Text(
            'txt_tap_retry'.tr(),
            style: const TextStyle(color: Colors.grey),
          ),
        ),
        const SizedBox(height: 4),
        const Icon(
          CupertinoIcons.refresh_thick,
          color: Colors.grey,
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class PaginationMaxItemView extends StatelessWidget {
  const PaginationMaxItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 12),
        Text(
          'txt_max_item'.tr(),
          style: AppStyle.subtitle4.copyWith(
            color: Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
