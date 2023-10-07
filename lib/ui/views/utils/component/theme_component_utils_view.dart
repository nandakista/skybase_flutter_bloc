import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/config/themes/theme_manager.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';

class ThemeComponentUtilsView extends StatelessWidget {
  const ThemeComponentUtilsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RxBool switchValue = false.obs;

    return Scaffold(
      appBar: SkyAppBar.secondary(title: 'Theme Component'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Is Dark Mode'),
                GetX<ThemeManager>(
                  builder: (controller) => Switch(
                    value: controller.isDark.value,
                    onChanged: (value) {
                      controller.changeTheme();
                    },
                  ),
                ),
              ],
            ),
            Obx(
              () => Radio(
                value: switchValue.value,
                groupValue: true,
                onChanged: (value) => switchValue.toggle(),
              ),
            ),
            Obx(
              () => Switch(
                value: switchValue.value,
                onChanged: (value) => switchValue.toggle(),
              ),
            ),
            Obx(
              () => Checkbox(
                value: switchValue.value,
                onChanged: (value) => switchValue.toggle(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
