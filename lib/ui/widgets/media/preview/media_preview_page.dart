import 'package:flutter/material.dart';
import 'package:skybase/core/helper/media_helper.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_image.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class MediaPreviewPage extends StatelessWidget {
  final String src;
  final bool isAsset;
  final String? title;
  final TextStyle? titleStyle;

  const MediaPreviewPage({
    Key? key,
    required this.src,
    this.isAsset = true,
    this.title,
    this.titleStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SkyAppBar.primary(
          title: title ?? 'Media Preview',
          titleStyle: titleStyle,
        ),
        body: _determineMedia(src));
  }

  Widget _determineMedia(String path) {
    final mediaType = MediaHelper.getMediaType(path);
    switch (mediaType.type) {
      case MediaType.FILE:
        return const Center(child: Text('Media Unsupported'));
      case MediaType.IMAGE:
        return Center(
          child: SkyImage(
            src: mediaType.path,
            isAsset: isAsset,
          ),
        );
      case MediaType.VIDEO:
        return const Center(child: Text('Media Unsupported'));
      case MediaType.UNKNOWN:
        return const Center(child: Text('Media Unsupported'));
    }
  }
}
