import 'package:go_router/go_router.dart';
import 'package:skybase/ui/views/intro/intro_view.dart';

final introRoute = [
  GoRoute(
    path: IntroView.route,
    name: IntroView.route,
    builder: (context, state) => const IntroView(),
  ),
];

