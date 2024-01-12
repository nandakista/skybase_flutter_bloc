import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skybase/service_locator.dart';
import 'package:skybase/ui/views/main_navigation/main_nav_view.dart';
import 'package:skybase/ui/views/profile/bloc/profile_bloc.dart';
import 'package:skybase/ui/views/profile/component/repository/bloc/profile_repository_bloc.dart';
import 'package:skybase/ui/views/sample_feature/list/bloc/sample_feature_list_bloc.dart';

final mainNavRoute = [
  GoRoute(
    path: MainNavView.route,
    name: MainNavView.route,
    builder: (context, state) => MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<SampleFeatureListBloc>()),
        BlocProvider(create: (_) => sl<ProfileBloc>()),
        BlocProvider(create: (_) => sl<ProfileRepositoryBloc>()),
      ],
      child: const MainNavView(),
    ),
  ),
];
