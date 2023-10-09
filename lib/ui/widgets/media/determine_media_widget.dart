import 'package:flutter/material.dart';
import 'package:skybase/core/helper/media_helper.dart';

class DetermineMediaWidget extends StatelessWidget {
  const DetermineMediaWidget({
    Key? key,
    required this.path,
    this.file,
    this.image,
    this.video,
    this.unknown,
  }) : super(key: key);

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
    return const Center(child: Text('txt_media_unsupported'));
  }
}
