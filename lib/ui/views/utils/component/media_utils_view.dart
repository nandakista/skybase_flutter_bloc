import 'dart:io';

import 'package:flutter/material.dart';
import 'package:skybase/core/helper/bottom_sheet_helper.dart';
import 'package:skybase/config/base/main_navigation.dart';
import 'package:skybase/ui/widgets/media/attachments_source_bottom_sheet.dart';
import 'package:skybase/ui/widgets/media/media_items.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_button.dart';
import 'package:skybase/ui/widgets/sky_image.dart';

class MediaUtilsView extends StatefulWidget {
  static const String route = 'media';

  const MediaUtilsView({super.key});

  @override
  State<MediaUtilsView> createState() => _MediaUtilsViewState();
}

class _MediaUtilsViewState extends State<MediaUtilsView> {
  File? imageFile;
  List<File> pickedImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkyAppBar.primary(title: 'Media Utility'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ..._buildImagePicker(context),
            const Divider(thickness: 1, height: 36),
            const SkyImage(),
            const Divider(thickness: 1, height: 36),
            const MediaItems(
              isGrid: true,
              mediaUrls: [
                'https://picsum.photos/200/200.jpg',
                'https://picsum.photos/200/200.jpg',
                'assets/images/img_error.png',
                'https://picsum.photos/200/200.jpg',
                'https://picsum.photos/200/200.jpg',
              ],
            ),
            const Divider(thickness: 1, height: 36),
            const MediaItems(
              size: 100,
              maxItem: 3,
              mediaUrls: [
                'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
                'assets/images/img_pv_1.png',
                'https://picsum.photos/200/200.jpg',
                'https://picsum.photos/200/200.jpg',
                'https://picsum.photos/200/200.jpg',
                'assets/images/img_error.png',
                'https://picsum.photos/200/200.jpg',
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  _buildImagePicker(BuildContext context) {
    return [
      const Text('Preview File'),
      const SizedBox(height: 4),
      Container(
        child: imageFile != null
            ? SkyImage(
                src: imageFile!.path,
                height: MediaQuery.of(context).size.width * 1 / 2,
                width: MediaQuery.of(context).size.width * 2 / 3,
              )
            : SizedBox(
                height: MediaQuery.of(context).size.width * 1 / 2,
                width: MediaQuery.of(context).size.width * 1 / 2,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(40.0),
                    child:
                        SkyImage(src: 'assets/images/img_placeholder_user.png'),
                  ),
                ),
              ),
      ),
      const SizedBox(height: 16),
      SkyButton(
        text: 'Image BottomSheet',
        onPressed: () {
          BottomSheetHelper.material(
            context: context,
            child: AttachmentsSourceBottomSheet(
              pageContext: context,
              enabledFileSource: false,
              onAttachmentsSelected: (file) {
                setState(() {
                  imageFile = file;
                });
                Navigation.instance.pop(context);
              },
              onMultipleAttachmentsSelected: (List<File> files) {},
            ),
          );
        },
      ),
      const SizedBox(height: 24),
      Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
          ...pickedImages.map(
            (e) => Stack(
              children: [
                SkyImage(
                  src: e.path,
                  height: 100,
                  width: 100,
                  enablePreview: true,
                  borderRadius: BorderRadius.circular(4),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        pickedImages.remove(e);
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomLeft: Radius.circular(5),
                        ),
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ];
  }
}
