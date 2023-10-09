part of 'setting_bloc.dart';

@immutable
class SettingState extends Equatable {
  final Map<String, dynamic> language;

  const SettingState(this.language);

  @override
  List<Object> get props => [language];
}
