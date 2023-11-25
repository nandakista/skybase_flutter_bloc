import 'package:flutter/material.dart';
import 'package:skybase/core/helper/snackbar_helper.dart';
import 'package:skybase/ui/widgets/colored_status_bar.dart';
import 'package:skybase/ui/widgets/sky_appbar.dart';
import 'package:skybase/ui/widgets/sky_button.dart';

class SnackBarUtilsView extends StatelessWidget {
  static const String route = 'snackbar';

  const SnackBarUtilsView({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredStatusBar.primary(
      child: Scaffold(
        appBar: SkyAppBar.secondary(title: 'SnackBar Utility'),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Text('Sample SnackBar Usage'),
              const SizedBox(height: 12),
              SkyButton(
                text: 'Normal',
                onPressed: () => SnackBarHelper.normal(context: context, message: 'Normal'),
              ),
              const SizedBox(height: 12),
              SkyButton(
                text: 'Error',
                onPressed: () =>
                    SnackBarHelper.error(context: context, message: 'Some Error Message'),
              ),
              const SizedBox(height: 12),
              SkyButton(
                text: 'Warning',
                onPressed: () =>
                    SnackBarHelper.warning(context: context, message: 'Some Warning Message'),
              ),
              const SizedBox(height: 12),
              SkyButton(
                text: 'Success',
                onPressed: () =>
                    SnackBarHelper.success(context: context, message: 'Some Success Message'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
