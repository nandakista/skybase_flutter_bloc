import 'package:go_router/go_router.dart';
import 'package:skybase/ui/views/splash/splash_view.dart';

final splashRoute = [
  GoRoute(
    path: SplashView.route,
    name: SplashView.route,
    builder: (context, state) => const SplashView(),
  ),
];
