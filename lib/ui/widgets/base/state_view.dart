import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skybase/ui/widgets/platform_loading_indicator.dart';

import 'empty_view.dart';
import 'error_view.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class StateView extends StatelessWidget {
  /// Can override setting Visibility emptyView even if [emptyEnabled] is true
  final bool visibleOnEmpty;

  /// Can override setting Visibility emptyView even if [errorEnabled] is true
  final bool visibleOnError;

  /// Show [loadingView] when set to *true*
  final bool loadingEnabled;

  /// Show [emptyView] when set to *true*
  final bool emptyEnabled;

  /// Show [errorView] when set to *true*
  final bool errorEnabled;

  /// Loading view that will show if [loadingEnabled] is true
  final Widget? loadingView;

  /// Image that will show if [emptyEnabled] is true
  final Widget? emptyImageWidget;

  final String? emptyImage;

  /// Title that will show if [emptyEnabled] is true
  final String? emptyTitle;

  /// Subtitle that will show if [emptyEnabled] is true
  final String? emptySubtitle;

  /// Image that will show if [errorEnabled] is true
  final Widget? errorImageWidget;

  final String? errorImage;

  /// Title that will show if [errorEnabled] is true
  final String? errorTitle;

  /// Subtitle that will show if [errorEnabled] is true
  final String? errorSubtitle;

  /// Set this to true if your widget is component (not page)
  final bool isComponent;

  final String? retryText;

  final Widget? retryWidget;

  /// Function to control onPress 'retry' if [errorEnabled] is true
  final void Function()? onRetry;

  final Widget? emptyView;

  final Widget child;

  final VoidCallback? onRefresh;

  final double? imageHeight;

  final double? imageWidth;

  final double? verticalSpacing;

  final double? horizontalSpacing;

  final TextStyle? titleStyle;

  final TextStyle? subtitleStyle;

  final Widget? errorView;

  final bool emptyRetryEnabled;

  const StateView.page({
    super.key,
    required this.loadingEnabled,
    required this.errorEnabled,
    required this.emptyEnabled,
    required this.onRetry,
    required this.child,
    this.emptyRetryEnabled = false,
    this.emptyImage,
    this.emptyTitle,
    this.emptySubtitle,
    this.loadingView,
    this.visibleOnEmpty = true,
    this.visibleOnError = true,
    this.errorImageWidget,
    this.errorSubtitle,
    this.errorTitle,
    this.errorView,
    this.isComponent = false,
    this.emptyView,
    this.retryText,
    this.onRefresh,
    this.imageHeight,
    this.imageWidth,
    this.verticalSpacing,
    this.horizontalSpacing,
    this.titleStyle,
    this.subtitleStyle,
    this.errorImage,
    this.retryWidget,
    this.emptyImageWidget,
  });

  const StateView.component({
    super.key,
    required this.loadingEnabled,
    required this.errorEnabled,
    required this.emptyEnabled,
    required this.onRetry,
    required this.child,
    this.emptyRetryEnabled = false,
    this.emptyTitle,
    this.emptyImage,
    this.emptySubtitle,
    this.loadingView,
    this.visibleOnEmpty = true,
    this.visibleOnError = true,
    this.errorImageWidget,
    this.errorSubtitle,
    this.errorTitle,
    this.errorView,
    this.isComponent = true,
    this.emptyView,
    this.retryText,
    this.imageHeight,
    this.imageWidth,
    this.verticalSpacing,
    this.horizontalSpacing,
    this.titleStyle,
    this.subtitleStyle,
    this.errorImage,
    this.retryWidget,
    this.emptyImageWidget,
  }) : onRefresh = null;

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (visibleOnError && errorEnabled) {
      body = getErrorView(context);
    } else if (visibleOnEmpty && emptyEnabled) {
      body = getEmptyView(context);
    } else if (!emptyEnabled && !errorEnabled) {
      body = getLoadingAndBodyView(context);
    } else {
      body = const SizedBox.shrink();
    }

    return body;
  }

  Widget getLoadingAndBodyView(BuildContext context) {
    if (isComponent) {
      return loadingEnabled
          ? loadingView ?? const PlatformLoadingIndicator()
          : child;
    }
    if (onRefresh != null) {
      return Platform.isIOS
          ? _iosObjectView(onRefresh: onRefresh!)
          : _androidObjectView(onRefresh: onRefresh!);
    } else {
      return child;
    }
  }

  Widget _androidObjectView({required VoidCallback onRefresh}) {
    return RefreshIndicator(
      onRefresh: () => Future.sync(onRefresh),
      child: CustomScrollView(
        slivers: [
          (!loadingEnabled)
              ? SliverToBoxAdapter(child: child)
              : SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: loadingView ?? const CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _iosObjectView({required VoidCallback onRefresh}) {
    return CustomScrollView(
      slivers: [
        CupertinoSliverRefreshControl(
          onRefresh: () => Future.sync(onRefresh),
        ),
        (!loadingEnabled)
            ? SliverToBoxAdapter(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: child,
          ),
        )
            : SliverFillRemaining(
          child: loadingView ?? const PlatformLoadingIndicator(),
        ),
      ],
    );
  }

  Widget getLoadingView(Widget loadingWidget) {
    return Center(
      child: AnimatedOpacity(
        opacity: loadingEnabled ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 200),
        child: loadingWidget,
      ),
    );
  }

  Widget getEmptyView(BuildContext context) {
    return emptyView ??
        EmptyView(
          emptyImage: emptyImage,
          emptyImageWidget: emptyImageWidget,
          emptyTitle: emptyTitle,
          emptySubtitle: emptySubtitle,
          imageHeight: imageHeight,
          imageWidth: imageWidth,
          horizontalSpacing: horizontalSpacing ?? 24,
          verticalSpacing: verticalSpacing ?? 24,
          titleStyle: titleStyle,
          subtitleStyle: subtitleStyle,
          retryWidget: retryWidget,
          onRetry: onRetry,
          retryText: retryText,
          emptyRetryEnabled: emptyRetryEnabled,
        );
  }

  Widget getErrorView(BuildContext context) {
    return errorView ??
        ErrorView(
          errorImage: errorImage,
          errorImageWidget: errorImageWidget,
          errorTitle: errorTitle,
          errorSubtitle: errorSubtitle,
          onRetry: onRetry,
          retryText: retryText,
          imageHeight: imageHeight,
          imageWidth: imageWidth,
          horizontalSpacing: horizontalSpacing ?? 24,
          verticalSpacing: verticalSpacing ?? 24,
          titleStyle: titleStyle,
          subtitleStyle: subtitleStyle,
          retryWidget: retryWidget,
        );
  }
}
