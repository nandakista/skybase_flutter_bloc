import 'package:flutter/material.dart';
import 'package:skybase/ui/widgets/media/determine_media_widget.dart';
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
  final bool forceImage;
  final bool forceVideo;
  final bool forceFile;

  const MediaPreviewPage({
    super.key,
    required this.src,
    this.isAsset = true,
    this.title,
    this.titleStyle,
    this.forceImage = false,
    this.forceVideo = false,
    this.forceFile = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          title ?? '',
          style: titleStyle,
        ),
      ),
      backgroundColor: Colors.black,
      body: DetermineMediaWidget(
        path: src,
        forceFile: forceFile,
        forceImage: forceImage,
        forceVideo: forceVideo,
        image: Center(
          child: SkyImage(
            src: src,
            isAsset: isAsset,
          ),
        ),
        // Set this widget if want to show file preview
        file: const SizedBox.shrink(),
        // Set this widget if want to show video preview
        video: const SizedBox.shrink(),
        // Set this widget if want to show custom unknown preview
        unknown: const SizedBox.shrink(),
      ),
    );
  }
}
