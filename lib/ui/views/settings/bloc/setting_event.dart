part of 'setting_bloc.dart';

sealed class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object> get props => [];
}

class InitLocale extends SettingEvent {}

class UpdateLocale extends SettingEvent {
  final BuildContext context;
  final String languageCode;

  const UpdateLocale(this.context, this.languageCode);

  @override
  List<Object> get props => [context, languageCode];
}
