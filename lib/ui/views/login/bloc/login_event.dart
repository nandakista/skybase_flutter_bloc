part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class SubmitLogin extends LoginEvent {
  final String phone;
  final String email;
  final String password;

  const SubmitLogin(this.phone, this.email, this.password);

  @override
  List<Object> get props => [phone, email, password];
}


class BypassLogin extends LoginEvent {}