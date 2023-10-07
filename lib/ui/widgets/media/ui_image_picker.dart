import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skybase/core/helper/media_helper.dart';

class UiImagePicker extends StatelessWidget {
  final Function(File)? onSelected;
  final Widget child;
  final bool withCompression;
  final int sizeLimit;
  final ImageSource imageSource;

  const UiImagePicker({
    Key? key,
    this.onSelected,
    required this.child,
    this.withCompression = false,
    this.sizeLimit = 2000000,
    this.imageSource = ImageSource.gallery,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _pickImage(imageSource, (file) async {
          if (withCompression) {
            file = await MediaHelper.compressImage(
              file: file,
              limit: sizeLimit,
            );
          }
          onSelected!.call(file);
        });
      },
      child: child,
    );
  }

  Future _pickImage(ImageSource source, Function(File) onPick) async {
    final pickedFile = await MediaHelper.pickImage(
      source: source,
      withCompression: withCompression,
    );
    if (pickedFile == null) return;
    onPick(pickedFile);
  }
}
