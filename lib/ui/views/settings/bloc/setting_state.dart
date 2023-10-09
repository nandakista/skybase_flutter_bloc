part of 'setting_bloc.dart';

@immutable
class SettingState extends Equatable {
  final String languageCode;

  const SettingState(this.languageCode);

  @override
  List<Object> get props => [languageCode];
}
