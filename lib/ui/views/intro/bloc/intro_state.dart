part of 'intro_bloc.dart';

@immutable
sealed class IntroState extends Equatable {
  const IntroState();

  @override
  List<Object?> get props => [];
}

class IntroFirstPage extends IntroState {
  const IntroFirstPage();
}

class IntroLastPage extends IntroState {
  const IntroLastPage();
}

class IntroLoaded extends IntroState {
  const IntroLoaded();
}