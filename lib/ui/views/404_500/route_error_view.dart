import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RouteErrorView extends StatelessWidget {
  static const String tag = 'AppRoutes::->';

  const RouteErrorView({Key? key, required this.state}) : super(key: key);

  final GoRouterState state;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Something went wrong, message ${state.error?.message}'),
      ),
    );
  }
}
