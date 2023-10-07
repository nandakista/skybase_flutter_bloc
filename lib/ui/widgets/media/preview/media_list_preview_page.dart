import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/helper/media_helper.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_image.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class MediaListPreviewPage extends StatelessWidget {
  const MediaListPreviewPage({Key? key, required this.mediaUrls})
      : super(key: key);
  final List<String> mediaUrls;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    for (var item in mediaUrls) {
      children.add(_determineMedia(item));
      children.add(const Divider());
    }
    return Scaffold(
      appBar: SkyAppBar.primary(
        title: '${'txt_preview'.tr} ${'txt_media'.tr}',
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget _determineMedia(String path) {
    final mediaType = MediaHelper.getMediaType(path);
    switch (mediaType.type) {
      case MediaType.FILE:
        return const Center(child: Text('Media Unsupported'));
      case MediaType.IMAGE:
        return SkyImage(src: mediaType.path, enablePreview: true);
      case MediaType.VIDEO:
        return const Center(child: Text('Media Unsupported'));
      case MediaType.UNKNOWN:
        return const Center(child: Text('Media Unsupported'));
    }
  }
}
