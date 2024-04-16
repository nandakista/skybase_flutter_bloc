import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skybase/ui/views/settings/bloc/setting_bloc.dart';
import 'package:skybase/ui/views/settings/setting_view.dart';

final settingRoute = [
  GoRoute(
    path: SettingView.route,
    name: SettingView.route,
    builder: (context, state) => BlocProvider(
      create: (_) => SettingBloc(),
      child: const SettingView(),
    ),
  ),
];