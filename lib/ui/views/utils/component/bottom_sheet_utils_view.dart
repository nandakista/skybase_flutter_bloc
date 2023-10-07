import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/helper/bottom_sheet_helper.dart';
import 'package:skybase/ui/widgets/media/attachments_source_bottom_sheet.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_button.dart';

class BottomSheetUtilsView extends StatelessWidget {
  const BottomSheetUtilsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkyAppBar.primary(title: 'Bottom Sheet Utility'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 12),
            const Text(
              'This page is helper to show all of bottomsheet from BottomSheetHelper',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            SkyButton(
              text: 'Basic',
              onPressed: () {
                BottomSheetHelper.basic(child: _imageSource());
              },
            ),
            const SizedBox(height: 12),
            SkyButton(
              text: 'Rounded',
              onPressed: () {
                BottomSheetHelper.rounded(child: _imageSource());
              },
            ),
            const SizedBox(height: 12),
            SkyButton(
              text: 'Bar',
              onPressed: () {
                BottomSheetHelper.bar(child: _imageSource());
              },
            ),
            const SizedBox(height: 12),
            SkyButton(
              text: 'Cupertino',
              onPressed: () {
                BottomSheetHelper.cupertino(child: _imageSource());
              },
            ),
            const SizedBox(height: 12),
            SkyButton(
              text: 'Material',
              onPressed: () {
                BottomSheetHelper.material(child: _imageSource());
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageSource() {
    return AttachmentsSourceBottomSheet(
      enabledFileSource: false,
      onAttachmentsSelected: (file) {
        // controller.selectedProof.value = image;
        Get.back();
      },
      onMultipleAttachmentsSelected: (List<File> files) {},
    );
  }
}
