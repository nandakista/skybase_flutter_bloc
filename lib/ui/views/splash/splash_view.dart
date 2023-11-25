import 'package:flutter/material.dart';
import 'package:skybase/config/themes/app_colors.dart';
import 'package:skybase/ui/widgets/platform_loading_indicator.dart';

class SplashView extends StatelessWidget {
  static const String route = '/splash';

  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: PlatformLoadingIndicator(color: Colors.white),
      ),
    );
  }
}
