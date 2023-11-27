import 'dart:io';

import 'package:flutter/material.dart';
import 'package:skybase/config/base/main_navigation.dart';
import 'package:skybase/core/helper/bottom_sheet_helper.dart';
import 'package:skybase/ui/widgets/media/attachments_source_bottom_sheet.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_button.dart';

class BottomSheetUtilsView extends StatelessWidget {
  static const String route = 'bottom-sheet';

  const BottomSheetUtilsView({super.key});

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
                BottomSheetHelper.basic(
                  context: context,
                  child: _imageSource(context),
                );
              },
            ),
            const SizedBox(height: 12),
            SkyButton(
              text: 'Rounded',
              onPressed: () {
                BottomSheetHelper.rounded(
                  context: context,
                  child: _imageSource(context),
                );
              },
            ),
            const SizedBox(height: 12),
            SkyButton(
              text: 'Bar',
              onPressed: () {
                BottomSheetHelper.bar(
                  context: context,
                  child: _imageSource(context),
                );
              },
            ),
            const SizedBox(height: 12),
            SkyButton(
              text: 'Cupertino',
              onPressed: () {
                BottomSheetHelper.cupertino(
                  context: context,
                  child: _imageSource(context),
                );
              },
            ),
            const SizedBox(height: 12),
            SkyButton(
              text: 'Material',
              onPressed: () {
                BottomSheetHelper.material(
                  context: context,
                  child: _imageSource(context),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageSource(BuildContext context) {
    return AttachmentsSourceBottomSheet(
      pageContext: context,
      enabledFileSource: false,
      onAttachmentsSelected: (file) {
        // controller.selectedProof.value = image;
        Navigation.instance.pop(context);
      },
      onMultipleAttachmentsSelected: (List<File> files) {},
    );
  }
}
