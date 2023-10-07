import 'package:go_router/go_router.dart';
import 'package:skybase/ui/views/profile/profile_view.dart';

final profileRoute = [
  GoRoute(
    path: ProfileView.route,
    name: ProfileView.route,
    builder: (context, state) => const ProfileView(),
  ),
];