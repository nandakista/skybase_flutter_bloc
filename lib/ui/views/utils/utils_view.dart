import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/ui/views/utils/component/bottom_sheet_utils_view.dart';
import 'package:skybase/ui/views/utils/component/dialog_utils_view.dart';
import 'package:skybase/ui/views/utils/component/list_utils_view.dart';
import 'package:skybase/ui/views/utils/component/media_utils_view.dart';
import 'package:skybase/ui/views/utils/component/snackbar_utils_view.dart';
import 'package:skybase/ui/views/utils/component/theme_component_utils_view.dart';
import 'package:skybase/ui/views/utils/component/timer/timer_utils_view.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_button.dart';

import 'component/other_utils_view.dart';

class UtilsView extends StatelessWidget {
  static const String route = '/utils';

  const UtilsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SkyAppBar.secondary(title: 'Utility'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 12),
              SkyButton(
                text: 'Media Utility',
                icon: Icons.photo_library_outlined,
                outlineMode: true,
                onPressed: () => Get.to(() => const MediaUtilsView()),
              ),
              const SizedBox(height: 12),
              SkyButton(
                text: 'BottomSheet Utility',
                icon: Icons.account_tree_outlined,
                outlineMode: true,
                onPressed: () => Get.to(() => const BottomSheetUtilsView()),
              ),
              const SizedBox(height: 12),
              SkyButton(
                text: 'List Utility',
                icon: Icons.list,
                outlineMode: true,
                onPressed: () => Get.to(() => const ListUtilsView()),
              ),
              const SizedBox(height: 12),
              SkyButton(
                text: 'Dialog Utility',
                icon: CupertinoIcons.conversation_bubble,
                outlineMode: true,
                onPressed: () => Get.to(() => const DialogUtilsView()),
              ),
              const SizedBox(height: 12),
              SkyButton(
                text: 'SnackBar Utility',
                icon: Icons.table_rows_outlined,
                outlineMode: true,
                onPressed: () => Get.to(() => const SnackBarUtilsView()),
              ),
              const SizedBox(height: 12),
              SkyButton(
                text: 'Timer Utility',
                icon: Icons.timer_outlined,
                outlineMode: true,
                onPressed: () => Get.toNamed(TimerUtilsView.route),
              ),
              const SizedBox(height: 12),
              SkyButton(
                text: 'Other',
                icon: Icons.add,
                outlineMode: true,
                onPressed: () => Get.to(() => const OtherUtilsView()),
              ),
              const SizedBox(height: 12),
              SkyButton(
                text: 'Theme Component',
                icon: CupertinoIcons.paintbrush,
                gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xff003EA1), Color(0xff9F0077)]
                ),
                onPressed: () => Get.to(() => const ThemeComponentUtilsView()),
              ),
              const SizedBox(height: 28),
            ],
          ),
        ),
      ),
    );
  }
}
