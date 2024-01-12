import 'package:go_router/go_router.dart';
import 'package:skybase/config/observer/app_routes_observer.dart';
import 'package:skybase/ui/views/404_500/route_error_view.dart';
import 'package:skybase/ui/views/intro/intro_route.dart';
import 'package:skybase/ui/views/login/login_route.dart';
import 'package:skybase/ui/views/profile/profile_route.dart';
import 'package:skybase/ui/views/settings/setting_route.dart';
import 'package:skybase/ui/views/splash/splash_route.dart';
import 'package:skybase/ui/views/splash/splash_view.dart';
import 'package:skybase/ui/views/main_navigation/main_nav_route.dart';
import 'package:skybase/ui/views/sample_feature/detail/sample_feature_detail_route.dart';
import 'package:skybase/ui/views/sample_feature/list/sample_feature_list_route.dart';
import 'package:skybase/ui/views/utils/utils_route.dart';

abstract class AppRoutes {
  static GoRouter router = GoRouter(
    initialLocation: SplashView.route,
    debugLogDiagnostics: true,
    routerNeglect: true,
    observers: [AppRoutesObserver()],
    errorBuilder: (context, state) => RouteErrorView(state: state),
    routes: [
      ...splashRoute,
      ...introRoute,
      ...loginRoute,
      ...mainNavRoute,
      ...sampleFeatureRoute,
      ...sampleFeatureDetailPage,
      ...profileRoute,
      ...settingRoute,
      ...utilsRoute,
    ],
  );
}
