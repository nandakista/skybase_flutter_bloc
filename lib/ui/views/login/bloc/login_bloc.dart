import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skybase/config/auth_manager/auth_manager.dart';
import 'package:skybase/data/repositories/auth/auth_repository.dart';
import 'package:skybase/ui/routes/app_routes.dart';
import 'package:skybase/ui/views/login/login_view.dart';
import 'package:skybase/ui/views/main_navigation/main_nav_view.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  String tag = 'IntroBloc : ';

  final AuthRepository repository;

  LoginBloc(this.repository) : super(const LoginInitial()) {
    on<SubmitLogin>(_onSubmit);
    on<BypassLogin>(_onBypass);
  }

  void _onSubmit(
    SubmitLogin event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(const LoginLoading());
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
    emit(const LoginLoading());
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
