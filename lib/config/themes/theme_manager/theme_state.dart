part of 'theme_manager.dart';

sealed class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object?> get props => [];
}

class Initial extends ThemeState {}

class IsDarkMode extends ThemeState {
  const IsDarkMode();
}

class IsLightMode extends ThemeState {
  const IsLightMode();
}