import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_manager.dart';

/// Wrap your view with this for activate navigation from AuthManager
/// Common use in Login and Profile page for login and logout process
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key, required this.child}) : super(key: key);

  final Widget Function(AuthManager authManager, AuthState state) child;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthManager, AuthState>(
      listener: (context, state) => AuthManager.find.authChanged(context, state),
      builder: (context, state) {
        AuthManager bloc = context.read<AuthManager>();
        return child(bloc, state);
      },
    );
  }
}
