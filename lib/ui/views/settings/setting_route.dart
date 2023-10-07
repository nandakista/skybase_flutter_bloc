import 'package:go_router/go_router.dart';
import 'package:skybase/ui/views/settings/setting_view.dart';

final settingRoute = [
  GoRoute(
    path: SettingView.route,
    name: SettingView.route,
    builder: (context, state) => const SettingView(),
  ),
];