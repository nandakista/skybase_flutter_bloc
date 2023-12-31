import 'package:flutter/material.dart';
import 'package:skybase/ui/widgets/base/base_view.dart';

abstract class SkyView {
  static Widget page({
    required bool loadingEnabled,
    required bool errorEnabled,
    required bool emptyEnabled,
    required onRetry,
    required Widget child,
    bool emptyRetryEnabled = false,
    String? emptyTitle,
    String? emptyImage,
    String? emptySubtitle,
    Widget? loadingView,
    bool visibleOnEmpty = true,
    bool visibleOnError = true,
    Widget? errorImageWidget,
    String? errorSubtitle,
    String? errorTitle,
    Widget? errorView,
    Widget? emptyView,
    String? retryText,
    VoidCallback? onRefresh,
    double? imageSize,
    double? verticalSpacing,
    double? horizontalSpacing,
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    String? errorImage,
    Widget? retryWidget,
    Widget? emptyImageWidget,
  }) {
    return BaseView(
      isComponent: false,
      loadingEnabled: loadingEnabled,
      errorEnabled: errorEnabled,
      emptyRetryEnabled: emptyRetryEnabled,
      emptyEnabled: emptyEnabled,
      onRetry: onRetry,
      onRefresh: onRefresh,
      loadingView: loadingView,
      visibleOnEmpty: visibleOnEmpty,
      imageSize: imageSize,
      horizontalSpacing: imageSize,
      verticalSpacing: verticalSpacing,
      subtitleStyle: subtitleStyle,
      titleStyle: titleStyle,
      emptyImageWidget: emptyImageWidget,
      retryWidget: retryWidget,
      retryText: retryText,
      errorImageWidget: errorImageWidget,
      errorImage: errorImage,
      errorTitle: errorTitle,
      errorSubtitle: errorSubtitle,
      emptyTitle: emptyTitle,
      emptyView: emptyView,
      emptyImage: emptyImage,
      emptySubtitle: emptySubtitle,
      errorView: errorView,
      visibleOnError: visibleOnError,
      child: child,
    );
  }

  static Widget component({
    required bool loadingEnabled,
    required bool errorEnabled,
    required bool emptyEnabled,
    required onRetry,
    required Widget child,
    String? emptyTitle,
    String? emptyImage,
    String? emptySubtitle,
    Widget? loadingView,
    bool visibleOnEmpty = true,
    bool visibleOnError = true,
    Widget? errorImageWidget,
    String? errorSubtitle,
    String? errorTitle,
    Widget? errorView,
    Widget? emptyView,
    String? retryText,
    double? imageSize,
    double? verticalSpacing,
    double? horizontalSpacing,
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    String? errorImage,
    Widget? retryWidget,
    Widget? emptyImageWidget,
  }) {
    return BaseView(
      isComponent: true,
      loadingEnabled: loadingEnabled,
      errorEnabled: errorEnabled,
      emptyEnabled: emptyEnabled,
      onRetry: onRetry,
      loadingView: loadingView,
      visibleOnEmpty: visibleOnEmpty,
      imageSize: imageSize,
      horizontalSpacing: imageSize,
      verticalSpacing: verticalSpacing,
      subtitleStyle: subtitleStyle,
      titleStyle: titleStyle,
      emptyImageWidget: emptyImageWidget,
      retryWidget: retryWidget,
      retryText: retryText,
      errorImageWidget: errorImageWidget,
      errorImage: errorImage,
      errorTitle: errorTitle,
      errorSubtitle: errorSubtitle,
      emptyTitle: emptyTitle,
      emptyView: emptyView,
      emptyImage: emptyImage,
      emptySubtitle: emptySubtitle,
      errorView: errorView,
      visibleOnError: visibleOnError,
      child: child,
    );
  }
}
