import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:skybase/ui/widgets/media/determine_media_widget.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_image.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class MediaListPreviewPage extends StatelessWidget {
  const MediaListPreviewPage({super.key, required this.mediaUrls});
  final List<String> mediaUrls;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    for (var item in mediaUrls) {
      children.add(
        DetermineMediaWidget(
          path: item,
          image: SkyImage(src: item, enablePreview: true),
        ),
      );
      children.add(const Divider());
    }
    return Scaffold(
      appBar: SkyAppBar.primary(
        title: '${'txt_preview'.tr()} ${'txt_media'.tr()}',
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}
