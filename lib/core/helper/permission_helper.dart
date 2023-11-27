import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skybase/config/base/main_navigation.dart';
import 'package:skybase/core/helper/dialog_helper.dart';

class PermissionHelper {
  static void openSettings(BuildContext context, String message) {
    DialogHelper.warning(
      context: context,
      title: 'txt_permission_warning'.tr(),
      message: message,
      confirmText: 'txt_open_setting'.tr(),
      cancelText: 'txt_back'.tr(),
      onConfirm: openAppSettings,
      onCancel: () {
        Navigation.instance.pop(context);
      },
    );
  }

  static void error(BuildContext context, String message) {
    DialogHelper.warning(
      context: context,
      title: 'txt_permission_warning'.tr(),
      message: message,
      confirmText: 'txt_back'.tr(),
      onConfirm: () {
        Navigation.instance.pop(context);
      },
    );
  }
}
