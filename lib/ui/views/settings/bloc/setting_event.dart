part of 'setting_bloc.dart';

sealed class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

class InitLocale extends SettingEvent {}

class UpdateLocale extends SettingEvent {
  final String value;

  const UpdateLocale(this.value);

  @override
  List<Object> get props => [value];
}
