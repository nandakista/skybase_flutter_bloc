import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skybase/config/auth_manager/auth_manager.dart';
import 'package:skybase/data/repositories/auth/auth_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  String tag = 'LoginBloc::->';

  final AuthRepository repository;

  LoginBloc(this.repository) : super(LoginInitial()) {
    on<SubmitLogin>(_onSubmit);
    on<BypassLogin>(_onBypass);
  }

  void _onSubmit(
    SubmitLogin event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(LoginLoading());
      await repository.login(
        phoneNumber: event.phone,
        email: event.email,
        password: event.password,
      );
      emit(const LoginSuccess());
    } catch (e) {
      emit(LoginFailed(e.toString()));
    }
  }

  void _onBypass(
    BypassLogin event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      final response = await repository.getProfile(username: 'nandakista');
      await AuthManager.find.saveAuthData(
        user: response,
        token: 'dummy',
        refreshToken: 'dummyRefresh',
      );
      emit(const LoginSuccess());
    } catch (e) {
      emit(LoginFailed(e.toString()));
    }
  }
}
