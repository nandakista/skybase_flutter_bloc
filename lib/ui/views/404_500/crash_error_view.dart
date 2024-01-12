import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:skybase/core/extension/context_extension.dart';
import 'package:skybase/ui/widgets/sky_image.dart';

class CrashErrorView extends StatelessWidget {
  final FlutterErrorDetails errorDetails;

  const CrashErrorView({
    super.key,
    required this.errorDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colorScheme.surface,
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SkyImage(
              src: 'assets/images/img_error.png',
              height: 144,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 16),
            Text(
              kDebugMode
                  ? errorDetails.summary.toString()
                  : "txt_crash_error_title".tr(),
              textAlign: TextAlign.center,
              style: context.textTheme.bodyLarge?.copyWith(
                color: kDebugMode
                    ? context.colorScheme.error
                    : context.colorScheme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              kDebugMode
                  ? errorDetails.exceptionAsString()
                  : "txt_crash_error_message".tr(),
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
