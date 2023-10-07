import 'package:go_router/go_router.dart';

import 'utils_view.dart';

final utilsRoute = [
  GoRoute(
    path: UtilsView.route,
    name: UtilsView.route,
    builder: (context, state) => const UtilsView(),
  ),
];