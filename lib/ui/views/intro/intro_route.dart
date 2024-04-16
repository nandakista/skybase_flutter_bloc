import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skybase/ui/views/intro/bloc/intro_bloc.dart';
import 'package:skybase/ui/views/intro/intro_view.dart';

final introRoute = [
  GoRoute(
    path: IntroView.route,
    name: IntroView.route,
    builder: (context, state) => BlocProvider(
      create: (_) => IntroBloc(),
      child: const IntroView(),
    ),
  ),
];
