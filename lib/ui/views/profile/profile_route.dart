import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skybase/data/repositories/auth/auth_repository.dart';
import 'package:skybase/service_locator.dart';
import 'package:skybase/ui/views/profile/bloc/profile_bloc.dart';
import 'package:skybase/ui/views/profile/component/repository/bloc/profile_repository_bloc.dart';
import 'package:skybase/ui/views/profile/profile_view.dart';

final profileRoute = [
  GoRoute(
    path: ProfileView.route,
    name: ProfileView.route,
    builder: (context, state) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => ProfileBloc(sl<AuthRepository>()),
          ),
          BlocProvider(
            create: (_) => ProfileRepositoryBloc(sl<AuthRepository>()),
          ),
        ],
        child: const ProfileView(),
      );
    },
  ),
];
