import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skybase/config/localization/locale_manager.dart';
import 'package:skybase/core/database/storage/storage_key.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';

part 'setting_event.dart';

part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  String tag = 'SettingBloc::->';

  SettingBloc() : super(const SettingState({})) {
    on<InitLocale>(_setLocale);
    on<UpdateLocale>(_onUpdateLocaleID);
  }

  void _setLocale(
    InitLocale event,
    Emitter<SettingState> emit,
  ) {
    Locale currentLocale = LocaleManager.find.getCurrentLocale();
    Map<String, dynamic> language = {};
    if (currentLocale == const Locale('en')) {
      language = {
        'name': 'English',
        'locale': 'en',
      };
    } else {
      language = {
        'name': 'Indonesia',
        'locale': 'id',
      };
    }
    emit(SettingState(language));
  }

  void _onUpdateLocaleID(
    UpdateLocale event,
    Emitter<SettingState> emit,
  ) async {
    Map<String, dynamic> lang = jsonDecode(event.value.toString());
    if (lang['name'].toString() == 'English') {
      StorageManager.find.save<String>(StorageKey.CURRENT_LOCALE, 'en');
    } else {
      StorageManager.find.save<String>(StorageKey.CURRENT_LOCALE, 'in');
    }
    // TODO: Update Localization
    emit(SettingState(lang));
  }
}
