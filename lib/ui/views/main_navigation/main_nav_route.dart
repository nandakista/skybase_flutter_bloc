import 'package:go_router/go_router.dart';
import 'package:skybase/ui/views/main_navigation/main_nav_view.dart';

final mainNavRoute = [
  GoRoute(
    path: MainNavView.route,
    name: MainNavView.route,
    builder: (context, state) => const MainNavView(),
  ),
];
