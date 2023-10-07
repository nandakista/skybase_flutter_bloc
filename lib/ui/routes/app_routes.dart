import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:skybase/core/observer/app_navigator_observer.dart';
import 'package:skybase/ui/views/intro/intro_route.dart';
import 'package:skybase/ui/views/login/login_route.dart';
import 'package:skybase/ui/views/profile/profile_route.dart';
import 'package:skybase/ui/views/settings/setting_route.dart';
import 'package:skybase/ui/views/splash/splash_route.dart';
import 'package:skybase/ui/views/splash/splash_view.dart';
import 'package:skybase/ui/views/main_navigation/main_nav_route.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_route.dart';
import 'package:skybase/ui/views/sample_feature/list/sample_feature_list_route.dart';
import 'package:skybase/ui/views/utils/component/timer/timer_utils_route.dart';
import 'package:skybase/ui/views/utils/utils_route.dart';

abstract class AppRoutes {
  static GlobalKey<NavigatorState> routeKey = GlobalKey<NavigatorState>();

  static GoRouter router = GoRouter(
    initialLocation: SplashView.route,
    navigatorKey: routeKey,
    observers: [
      AppNavigatorObserver(),
    ],
    errorBuilder: (context, state) {
      log('Error = ${state.error?.message}');
      return Scaffold(
        body: Center(
          child: Text('Route error $state'),
        ),
      );
    },
    debugLogDiagnostics: false,
    routes: [
      ...splashRoute,
      ...introRoute,
      ...loginRoute,
      ...mainNavRoute,
      ...sampleFeatureRoute,
      ...sampleFeatureDetailPage,
      ...timerUtilsRoute,
      ...profileRoute,
      ...settingRoute,
      ...utilsRoute,
    ],
  );
}
