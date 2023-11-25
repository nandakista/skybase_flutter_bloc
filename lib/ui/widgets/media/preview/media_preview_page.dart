import 'package:flutter/material.dart';
import 'package:skybase/ui/widgets/media/determine_media_widget.dart';
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
    super.key,
    required this.src,
    this.isAsset = true,
    this.title,
    this.titleStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkyAppBar.primary(
        title: title ?? 'Media Preview',
        titleStyle: titleStyle,
      ),
      body: DetermineMediaWidget(
        path: src,
        image: Center(child: SkyImage(src: src, isAsset: isAsset)),
      ),
    );
  }
}
