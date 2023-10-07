part of 'intro_bloc.dart';

sealed class IntroEvent extends Equatable {
  const IntroEvent();

  @override
  List<Object> get props => [];
}

class PreviousPage extends IntroEvent {}

class SkipPage extends IntroEvent {}

class ChangePage extends IntroEvent {
  final int page;

  const ChangePage(this.page);

  @override
  List<Object> get props => [page];
}

class DonePage extends IntroEvent {
  final BuildContext context;

  const DonePage(this.context);

  @override
  List<Object> get props => [context];
}
