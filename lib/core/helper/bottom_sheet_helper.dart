import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class BottomSheetHelper {
  static basic({
    required Widget child,
    bool isDismissible = true,
    bool isScrollControlled = true,
    Color? backgroundColor = Colors.transparent,
    Color? barrierColor,
    bool enableDrag = true,
  }) async {
    return await showModalBottomSheet(
      context: Get.context!,
      isDismissible: isDismissible,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor,
      barrierColor: barrierColor,
      enableDrag: enableDrag,
      builder: (btmContext) => Container(
        color: Theme.of(Get.context!).scaffoldBackgroundColor,
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: Get.height - 50),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
            child: child,
          ),
        ),
      ),
    );
  }

  static rounded({
    required Widget child,
    bool isDismissible = true,
    bool isScrollControlled = true,
    Color? backgroundColor = Colors.transparent,
    Color? barrierColor,
    bool enableDrag = true,
    double? height,
    bool expand = false,
  }) async {
    return await showModalBottomSheet(
      context: Get.context!,
      isDismissible: isDismissible,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor,
      enableDrag: enableDrag,
      barrierColor: barrierColor,
      builder: (btmContext) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: Get.height - 50),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(Get.context!).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
              child: child,
            ),
          ),
        );
      },
    );
  }

  static bar({
    required Widget child,
    bool isDismissible = true,
    bool isScrollControlled = true,
    Color? backgroundColor,
    Color? barrierColor,
    bool expand = false,
  }) async {
    return await showBarModalBottomSheet(
      context: Get.context!,
      isDismissible: isDismissible,
      expand: expand,
      backgroundColor: backgroundColor,
      barrierColor: barrierColor ?? Colors.black54,
      builder: (btmContext) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        child: child,
      ),
    );
  }

  static Future cupertino({
    required Widget child,
    bool isDismissible = true,
    bool isScrollControlled = true,
    bool enableDrag = true,
    bool enableBack = true,
    bool expand = false,
    Color? barrierColor,
  }) async {
    return await showCupertinoModalBottomSheet(
      context: Get.context!,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      topRadius: const Radius.circular(24),
      duration: const Duration(milliseconds: 600),
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      barrierColor: barrierColor ?? Colors.black54,
      expand: expand,
      bounce: true,
      builder: (btmContext) => WillPopScope(
        onWillPop: () async {
          return enableBack;
        },
        child: Material(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 0,
                child: Container(
                  margin: const EdgeInsets.only(top: 12),
                  height: 6,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future material({
    required Widget child,
    bool isDismissible = true,
    bool isScrollControlled = true,
    bool enableDrag = true,
    bool enableBack = true,
    bool expand = false,
    Color? barrierColor,
  }) async {
    return await showMaterialModalBottomSheet(
      context: Get.context!,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      duration: const Duration(milliseconds: 600),
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      barrierColor: barrierColor ?? Colors.black54,
      expand: expand,
      bounce: true,
      builder: (btmContext) => WillPopScope(
        onWillPop: () async {
          return enableBack;
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          child: child,
        ),
      ),
    );
  }
}
