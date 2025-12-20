import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:skybase/config/base/main_navigation.dart';
import 'package:skybase/ui/widgets/platform_loading_indicator.dart';
import 'package:skybase/ui/widgets/sky_dialog.dart';

class LoadingDialog {
  static show(BuildContext context, {bool? dismissible}) {
    return showGeneralDialog(
      context: context,
      barrierLabel: 'Barrier',
      barrierDismissible: dismissible ?? false,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            height: 80,
            width: 80,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(16),
            child: const PlatformLoadingIndicator(),
          ),
        );
      },
    );
  }

  static dismiss(BuildContext context) => Navigation.instance.pop(context);
}

class DialogHelper {
  static failed({
    required BuildContext context,
    required String message,
    VoidCallback? onConfirm,
    Widget? header,
    bool? isDismissible,
    String? title,
  }) {
    return showDialog(
      barrierDismissible: isDismissible ?? true,
      context: context,
      builder: (context) => DialogAlert.error(
        header: header,
        title: title ?? 'txt_failed'.tr(),
        description: message,
        onConfirm: onConfirm ?? () => dismiss(context),
        isDismissible: isDismissible ?? true,
      ),
    );
  }

  static success({
    required BuildContext context,
    required String message,
    required VoidCallback onConfirm,
    Widget? header,
    bool? isDismissible,
    String? title,
  }) {
    return showDialog(
      barrierDismissible: isDismissible ?? false,
      context: context,
      builder: (context) => DialogAlert.success(
        header: header,
        title: title ?? 'txt_success'.tr(),
        description: message,
        onConfirm: onConfirm,
        isDismissible: isDismissible ?? false,
      ),
    );
  }

  static warning({
    required BuildContext context,
    required String message,
    required VoidCallback onConfirm,
    Widget? header,
    bool? isDismissible,
    String? title,
    String? confirmText,
    String? cancelText,
    VoidCallback? onCancel,
}) {
    return showDialog(
      barrierDismissible: isDismissible ?? true,
      context: context,
      builder: (context) => DialogAlert.warning(
        header: header,
        isDismissible: isDismissible ?? false,
        title: title ?? 'txt_warning'.tr(),
        description: message,
        onConfirm: onConfirm,
        confirmText: confirmText,
        onCancel: onCancel ?? () => dismiss(context),
        cancelText: cancelText,
      ),
    );
  }

  static retry({
    required BuildContext context,
    required String message,
    required VoidCallback onConfirm,
    bool? isDismissible,
    Widget? header,
    String? title,
    String? confirmText,
    String? cancelText,
    VoidCallback? onCancel,
}) {
    return showDialog(
      barrierDismissible: isDismissible ?? true,
      context: context,
      builder: (context) => DialogAlert.retry(
        header: header,
        title: title ?? 'txt_failed'.tr(),
        description: message,
        confirmText: confirmText,
        cancelText: cancelText,
        onConfirm: onConfirm,
        onCancel: onCancel ?? () => dismiss(context),
        isDismissible: isDismissible ?? true,
      ),
    );
  }

  static force({
    required BuildContext context,
    required String message,
    required VoidCallback onConfirm,
    bool? isDismissible,
    Widget? header,
    String? title,
    VoidCallback? onCancel,
    String? confirmText,
  }) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => DialogAlert.force(
        header: header,
        title: title ?? 'txt_warning'.tr(),
        description: message,
        onConfirm: onConfirm,
        onCancel: onCancel ?? () => dismiss(context),
        confirmText: confirmText ?? 'OK',
        isDismissible: isDismissible ?? false,
      ),
    );
  }

  static dismiss(BuildContext context) => Navigation.instance.pop(context);
}
