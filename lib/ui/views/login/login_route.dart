import 'package:go_router/go_router.dart';
import 'package:skybase/ui/views/login/login_view.dart';

final loginRoute = [
  GoRoute(
    path: LoginView.route,
    name: LoginView.route,
    builder: (context, state) => const LoginView(),
  ),
];
