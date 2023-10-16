import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:go_router/go_router.dart';
import 'package:skybase/core/database/storage/storage_key.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';
import 'package:skybase/ui/views/intro/intro_data.dart';
import 'package:skybase/ui/views/login/login_view.dart';

part 'intro_event.dart';

part 'intro_state.dart';

class IntroBloc extends Bloc<IntroEvent, IntroState> {
  String tag = 'IntroBloc::->';

  int currentIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  bool get isFirstPage => currentIndex == 0;

  bool get isLastPage => currentIndex == introItem.length - 1;

  IntroBloc() : super(IntroFirstPage()) {
    on<DonePage>(_onDonePage);
    on<PreviousPage>(_onPreviousPage);
    on<ChangePage>(_onChangePage);
    on<SkipPage>(_onSkipPage);
  }

  void _onSkipPage(
    SkipPage event,
    Emitter<IntroState> emit,
  ) {
    pageController.jumpToPage(2);
    emit(IntroLastPage());
  }

  void _onChangePage(
    ChangePage event,
    Emitter<IntroState> emit,
  ) {
    currentIndex = event.page;
    if (isFirstPage) {
      emit(IntroFirstPage());
    } else if (isLastPage) {
      emit(IntroLastPage());
    } else {
      emit(IntroLoaded());
    }
  }

  void _onPreviousPage(
    PreviousPage event,
    Emitter<IntroState> emit,
  ) {
    pageController.previousPage(
      curve: Curves.easeIn,
      duration: const Duration(milliseconds: 260),
    );
    if (isFirstPage) {
      emit(IntroFirstPage());
    } else if (isLastPage) {
      emit(IntroLastPage());
    } else {
      emit(IntroLoaded());
    }
  }

  void _onDonePage(
    DonePage event,
    Emitter<IntroState> emit,
  ) {
    StorageManager.instance.save<bool>(StorageKey.FIRST_INSTALL, false);
    event.context.pushReplacementNamed(LoginView.route);
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
