import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

enum SkySnackBarType { NORMAL, SUCCESS, ERROR, WARNING }

abstract class SnackBarHelper {
  static void custom ({
    required BuildContext context,
    required String? message,
    SnackBarBehavior? behavior,
    SnackBarAction? action,
    Color? backgroundColor,
    EdgeInsets? margin,
    EdgeInsets? padding,
    double? width,
    ShapeBorder? shape,
    double? elevation,
  }) {
    showDefaultSnackBar(
      context: context,
      message: message ?? 'txt_success'.tr(),
      type: SkySnackBarType.NORMAL,
      behavior: behavior,
      action: action,
      backgroundColor: backgroundColor,
      width: width,
      elevation: elevation,
      shape: shape,
      margin: margin,
      padding: padding,
    );
  }

  static void normal({
    required BuildContext context,
    required String? message,
    SnackBarBehavior? behavior,
    SnackBarAction? action,
  }) {
    showDefaultSnackBar(
      context: context,
      message: message ?? 'txt_success'.tr(),
      type: SkySnackBarType.NORMAL,
      behavior: behavior,
      action: action,
    );
  }

  static void success({
    required BuildContext context,
    required String? message,
    SnackBarBehavior? behavior,
    SnackBarAction? action,
  }) {
    showDefaultSnackBar(
      context: context,
      message: message ?? 'txt_success'.tr(),
      type: SkySnackBarType.SUCCESS,
      behavior: behavior,
      action: action,
    );
  }

  static void error({
    required BuildContext context,
    required String? message,
    SnackBarBehavior? behavior,
    SnackBarAction? action,
  }) {
    showDefaultSnackBar(
      context: context,
      message: message ?? 'txt_error'.tr(),
      type: SkySnackBarType.ERROR,
      behavior: behavior,
      action: action,
    );
  }

  static void warning({
    required BuildContext context,
    required String? message,
    SnackBarBehavior? behavior,
    SnackBarAction? action,
  }) {
    showDefaultSnackBar(
      context: context,
      message: message ?? 'txt_warning'.tr(),
      type: SkySnackBarType.WARNING,
      behavior: behavior,
      action: action,
    );
  }

  static void showDefaultSnackBar({
    required BuildContext context,
    required String message,
    SkySnackBarType type = SkySnackBarType.NORMAL,
    SnackBarBehavior? behavior,
    SnackBarAction? action,
    EdgeInsets? margin,
    EdgeInsets? padding,
    Color? backgroundColor,
    double? width,
    ShapeBorder? shape,
    double? elevation,
  }) {
    Color bgColor = backgroundColor ?? Theme.of(context).primaryColor;
    bgColor = switch (type) {
      SkySnackBarType.ERROR => bgColor = Colors.red,
      SkySnackBarType.SUCCESS => bgColor = Colors.green,
      SkySnackBarType.WARNING => bgColor = Colors.orange,
      SkySnackBarType.NORMAL => bgColor = Colors.black,
    };

    final snackBar = SnackBar(
      width: width,
      elevation: elevation,
      shape: shape,
      action: action,
      margin: margin,
      padding: padding,
      content: Text(message, style: const TextStyle(color: Colors.white)),
      behavior: behavior ?? SnackBarBehavior.floating,
      backgroundColor: bgColor,
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
