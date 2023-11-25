import 'package:easy_localization/easy_localization.dart';
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
  });

  final String path;
  final Widget? file;
  final Widget? image;
  final Widget? video;
  final Widget? unknown;

  @override
  Widget build(BuildContext context) {
    final media = MediaHelper.getMediaType(path);
    return switch (media.type) {
      MediaType.FILE => file ?? _unsupportedMediaWidget(),
      MediaType.IMAGE => image ?? _unsupportedMediaWidget(),
      MediaType.VIDEO => video ?? _unsupportedMediaWidget(),
      MediaType.UNKNOWN => unknown ?? _unsupportedMediaWidget(),
    };
  }

  Widget _unsupportedMediaWidget() {
    return Center(child: Text('txt_media_unsupported'.tr()));
  }
}
