import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:skybase/core/helper/media_helper.dart';

class DetermineMediaWidget extends StatelessWidget {
  const DetermineMediaWidget({
    super.key,
    required this.path,
    this.file,
    this.image,
    this.video,
    this.unknown,
    this.forceImage = false,
    this.forceVideo = false,
    this.forceFile = false,
  });

  final String path;
  final Widget? file;
  final Widget? image;
  final Widget? video;
  final Widget? unknown;
  final bool forceImage;
  final bool forceVideo;
  final bool forceFile;

  @override
  Widget build(BuildContext context) {
    if (forceImage) return image ?? _unsupportedMediaWidget();
    if (forceVideo) return video ?? _unsupportedMediaWidget();
    if (forceFile) return file ?? _unsupportedMediaWidget();

    final media = MediaHelper.getMediaType(path);
    return switch (media.type) {
      MediaType.FILE => file ?? _unsupportedMediaWidget(),
      MediaType.IMAGE => image ?? _unsupportedMediaWidget(),
      MediaType.VIDEO => video ?? _unsupportedMediaWidget(),
      MediaType.UNKNOWN => unknown ?? _unsupportedMediaWidget(),
    };
  }

  Widget _unsupportedMediaWidget() {
    String message = 'txt_media_unsupported'.tr();
    if (kDebugMode) message += '\n$path';
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
