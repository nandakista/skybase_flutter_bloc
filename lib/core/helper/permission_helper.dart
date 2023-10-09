import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skybase/core/base/main_navigation.dart';
import 'package:skybase/core/helper/dialog_helper.dart';

class PermissionHelper {
  static void openSettings(BuildContext context, String message) {
    DialogHelper.warning(
      context: context,
      title: 'txt_permission_warning',
      message: message,
      confirmText: 'Open Settings',
      cancelText: 'Back',
      onConfirm: openAppSettings,
      onCancel: () {
        MainNavigation.pop(context);
      },
    );
  }

  static void error(BuildContext context, String message) {
    DialogHelper.warning(
      context: context,
      title: 'txt_permission_warning',
      message: message,
      confirmText: 'Back',
      onConfirm: () {
        MainNavigation.pop(context);
      },
    );
  }
}
