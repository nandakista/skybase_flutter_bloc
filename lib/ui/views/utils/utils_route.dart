import 'package:go_router/go_router.dart';
import 'package:skybase/ui/views/utils/component/bottom_sheet_utils_view.dart';
import 'package:skybase/ui/views/utils/component/dialog_utils_view.dart';
import 'package:skybase/ui/views/utils/component/list_utils_view.dart';
import 'package:skybase/ui/views/utils/component/media_utils_view.dart';
import 'package:skybase/ui/views/utils/component/other_utils_view.dart';
import 'package:skybase/ui/views/utils/component/snackbar_utils_view.dart';
import 'package:skybase/ui/views/utils/component/theme_component_utils_view.dart';

import 'utils_view.dart';

final utilsRoute = [
  GoRoute(
    path: UtilsView.route,
    name: UtilsView.route,
    builder: (context, state) => const UtilsView(),
    routes: [
      GoRoute(
        path: BottomSheetUtilsView.route,
        name: BottomSheetUtilsView.route,
        builder: (context, state) => const BottomSheetUtilsView(),
      ),
      GoRoute(
        path: DialogUtilsView.route,
        name: DialogUtilsView.route,
        builder: (context, state) => const DialogUtilsView(),
      ),
      GoRoute(
        path: ListUtilsView.route,
        name: ListUtilsView.route,
        builder: (context, state) => const ListUtilsView(),
      ),
      GoRoute(
        path: MediaUtilsView.route,
        name: MediaUtilsView.route,
        builder: (context, state) => const MediaUtilsView(),
      ),
      GoRoute(
        path: OtherUtilsView.route,
        name: OtherUtilsView.route,
        builder: (context, state) => const OtherUtilsView(),
      ),
      GoRoute(
        path: SnackBarUtilsView.route,
        name: SnackBarUtilsView.route,
        builder: (context, state) => const SnackBarUtilsView(),
      ),
      GoRoute(
        path: ThemeComponentUtilsView.route,
        name: ThemeComponentUtilsView.route,
        builder: (context, state) => const ThemeComponentUtilsView(),
      ),
    ],
  ),
];
