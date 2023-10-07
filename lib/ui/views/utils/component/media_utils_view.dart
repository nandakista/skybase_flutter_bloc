import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/helper/bottom_sheet_helper.dart';
import 'package:skybase/ui/views/utils/utils_controller.dart';
import 'package:skybase/ui/widgets/media/attachments_source_bottom_sheet.dart';
import 'package:skybase/ui/widgets/media/media_items.dart';
import 'package:skybase/ui/widgets/media/ui_image_picker.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_box.dart';
import 'package:skybase/ui/widgets/sky_button.dart';
import 'package:skybase/ui/widgets/sky_image.dart';

class MediaUtilsView extends GetView<UtilsController> {
  const MediaUtilsView({Key? key}) : super(key: key);

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
                'assets/images/img_sample.jpeg',
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
                'assets/images/img_sample.jpeg',
                'https://picsum.photos/200/200.jpg',
                'https://picsum.photos/200/200.jpg',
                'https://picsum.photos/200/200.jpg',
                'assets/images/img_sample.jpeg',
                'https://picsum.photos/200/200.jpg',
              ],
            ),
            const SizedBox(height: 24),
            const SkyImage(src: 'assets/images/img_sample.jpeg'),
          ],
        ),
      ),
    );
  }

  _buildImagePicker(BuildContext context) {
    return [
      const Text('Preview File'),
      const SizedBox(height: 4),
      Obx(
        () => Container(
          child: controller.imageFile.value != null
              ? SkyImage(
                  src: controller.imageFile.value!.path,
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
                      child: SkyImage(src: 'assets/images/img_man.png'),
                    ),
                  ),
                ),
        ),
      ),
      const SizedBox(height: 12),
      UiImagePicker(
        onSelected: (file) {
          debugPrint('file = $file');
          controller.imageFile.value = file;
        },
        child: const SkyBox(
          margin: EdgeInsets.all(4),
          child: Text('UI Image Picker'),
        ),
      ),
      const SizedBox(height: 16),
      SkyButton(
        text: 'Image BottomSheet',
        onPressed: () {
          BottomSheetHelper.material(
            child: AttachmentsSourceBottomSheet(
              enabledFileSource: false,
              onAttachmentsSelected: (file) {
                controller.imageFile.value = file;
                Get.back();
              },
              onMultipleAttachmentsSelected: (List<File> files) {},
            ),
          );
        },
      ),
      const SizedBox(height: 24),
      Obx(
        () => Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            ...controller.pickedImages
                .map(
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
                            controller.pickedImages.remove(e);
                            controller.update();
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
                )
                .toList(),
          ],
        ),
      ),
    ];
  }
}
