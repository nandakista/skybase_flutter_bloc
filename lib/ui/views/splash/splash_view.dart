import 'package:flutter/material.dart';
import 'package:skybase/config/auth_manager/auth_wrapper.dart';
import 'package:skybase/config/themes/app_colors.dart';
import 'package:skybase/ui/widgets/platform_loading_indicator.dart';

class SplashView extends StatelessWidget {
  static const String route = '/splash';

  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: AuthWrapper(
        child: (authManager, state) {
          return const Center(
            child: PlatformLoadingIndicator(color: Colors.white),
          );
        },
      ),
    );
  }
}
