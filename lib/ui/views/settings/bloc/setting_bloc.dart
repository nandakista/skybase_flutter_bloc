import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skybase/core/localization/locale_manager.dart';
import 'package:skybase/core/database/storage/storage_key.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';

part 'setting_event.dart';

part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  String tag = 'SettingBloc::->';

  SettingBloc()
      : super(SettingState(LocaleManager.find.getCurrentLocale.languageCode)) {
    on<InitLocale>(_setLocale);
    on<UpdateLocale>(_onUpdateLocaleID);
  }

  void _setLocale(
    InitLocale event,
    Emitter<SettingState> emit,
  ) {
    Locale currentLocale = LocaleManager.find.getCurrentLocale;
    emit(SettingState(currentLocale.languageCode));
  }

  void _onUpdateLocaleID(
    UpdateLocale event,
    Emitter<SettingState> emit,
  ) async {
    StorageManager.find
        .save<String>(StorageKey.CURRENT_LOCALE, event.languageCode);
    LocaleManager.find.updateLocale(event.context, Locale(event.languageCode));
    emit(SettingState(event.languageCode));
  }
}
