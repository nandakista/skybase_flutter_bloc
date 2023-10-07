part of 'auth_manager.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class Initial extends AuthState {
  const Initial();
}

class FirstInstall extends AuthState {
  const FirstInstall();
}

class Authenticated extends AuthState {
  const Authenticated();
}

class Unauthenticated extends AuthState {
  const Unauthenticated();
}