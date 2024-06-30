import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skybase/data/repositories/auth/auth_repository.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository.dart';
import 'package:skybase/service_locator.dart';
import 'package:skybase/ui/views/main_navigation/main_nav_view.dart';
import 'package:skybase/ui/views/profile/bloc/profile_bloc.dart';
import 'package:skybase/ui/views/profile/component/repository/bloc/profile_repository_bloc.dart';
import 'package:skybase/ui/views/sample_feature/list/bloc/sample_feature_list_tab_bloc.dart';

final mainNavRoute = [
  GoRoute(
    path: MainNavView.route,
    name: MainNavView.route,
    builder: (context, state) => MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => NandaBloc(
            sl<SampleFeatureRepository>(),
            'nanda',
          ),
        ),
        BlocProvider(
          create: (_) => PermanaBloc(
            sl<SampleFeatureRepository>(),
            'permana',
          ),
        ),
        BlocProvider(
          create: (_) => ProfileBloc(sl<AuthRepository>()),
        ),
        BlocProvider(
          create: (_) => ProfileRepositoryBloc(sl<AuthRepository>()),
        ),
      ],
      child: const MainNavView(),
    ),
  ),
];
