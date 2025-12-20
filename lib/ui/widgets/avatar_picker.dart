import 'dart:io';

import 'package:flutter/material.dart';
import 'package:skybase/core/helper/bottom_sheet_helper.dart';
import 'package:skybase/core/helper/media_helper.dart';
import 'package:skybase/ui/widgets/sky_image.dart';

import 'media/attachments_source_bottom_sheet.dart';

class AvatarPicker extends StatelessWidget {
  const AvatarPicker({
    super.key,
    this.imagePath,
    this.editWidget,
    this.hideRemove = false,
    this.enabled = true,
    this.namePlaceholder,
    required this.onAvatarSelected,
    this.onRemoveImage,
    this.editIcon,
    this.editBackgroundColor,
  });

  final String? imagePath;
  final String? namePlaceholder;
  final Widget? editWidget;
  final Widget? editIcon;
  final Color? editBackgroundColor;
  final bool hideRemove;
  final bool enabled;
  final void Function(File) onAvatarSelected;
  final VoidCallback? onRemoveImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 80,
      child: Stack(
        children: [
          GestureDetector(
            onTap: enabled ? () => _onPickAvatar(context) : null,
            child: SkyImage(
              width: 80.0,
              height: 80.0,
              shapeImage: ShapeImage.oval,
              src: imagePath ??
                  (namePlaceholder != null
                      ? MediaHelper.generateAvatarByName(
                          namePlaceholder.toString())
                      : 'assets/images/img_placeholder_user.png'),
              fit: BoxFit.cover,
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: enabled ? () => _onPickAvatar(context) : null,
              child: editWidget ??
                  Container(
                    width: 24,
                    height: 24,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: editBackgroundColor ?? Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.2),
                          spreadRadius: 2,
                          blurRadius: 1,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: editIcon ?? const Icon(
                      Icons.mode_edit,
                      size: 15.9,
                      color: Colors.black,
                    ),
                  ),
            ),
          ),
          if (imagePath != null && !hideRemove)
            GestureDetector(
              onTap: onRemoveImage,
              child: Container(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 24,
                  height: 24,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.2),
                        spreadRadius: 2,
                        blurRadius: 1,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.close_rounded,
                    size: 15.9,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _onPickAvatar(BuildContext context) async {
    BottomSheetHelper.bar(
      context: context,
      child: AttachmentsSourceBottomSheet(
        pageContext: context,
        allowMultiple: false,
        enabledFileSource: true,
        withImageCompression: true,
        onAttachmentsSelected: onAvatarSelected,
        onMultipleAttachmentsSelected: (List<File> results) {},
      ),
    );
  }
}
