import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skybase/data/repositories/auth/auth_repository.dart';
import 'package:skybase/service_locator.dart';
import 'package:skybase/ui/views/login/bloc/login_bloc.dart';
import 'package:skybase/ui/views/login/login_view.dart';

final loginRoute = [
  GoRoute(
    path: LoginView.route,
    name: LoginView.route,
    builder: (context, state) => BlocProvider(
      create: (context) => LoginBloc(sl<AuthRepository>()),
      child: const LoginView(),
    ),
  ),
];
