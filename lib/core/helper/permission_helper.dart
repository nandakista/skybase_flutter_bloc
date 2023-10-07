import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:skybase/core/helper/dialog_helper.dart';
import 'package:skybase/core/helper/snackbar_helper.dart';
import 'package:skybase/config/themes/app_colors.dart';

class PermissionHelper {
  static void openSettings(String message) {
    Get.snackbar(
      "txt_permission_warning".tr,
      message,
      duration: const Duration(seconds: 5),
      mainButton: TextButton(
        onPressed: openAppSettings,
        child: Text(
          "Open Setting",
          style: Get.textTheme.bodySmall?.copyWith(
            color: AppColors.secondary,
          ),
        ),
      ),
    );
  }

  static void error(String message) {
    Get.snackbar(
      "txt_permission_warning".tr,
      message,
      duration: const Duration(seconds: 5),
    );
  }

  /// This permission to open folder downloaded
  /// But it's very sensitive
  /// As much as posible avoid request this permission
  static Future<bool> manageExternalStorage() async {
    if (Platform.isAndroid) {
      final mPermission = await Permission.manageExternalStorage.request();
      if (mPermission.isPermanentlyDenied) {
        // LoadingDialog.dismiss();
        PermissionHelper.openSettings("txt_need_permission_storage".tr);
        return false;
      } else if (mPermission.isGranted) {
        return true;
      } else {
        // SnackBarHelper.warning(message: 'txt_need_permission_storage'.tr);
        return false;
      }
    } else {
      return true;
    }
  }
}
