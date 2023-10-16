import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skybase/core/database/storage/storage_key.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';
import 'package:skybase/service_locator.dart';

part 'theme_state.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class ThemeManager extends Cubit<ThemeState> {
  ThemeManager() : super(Initial());

  static ThemeManager get instance => sl<ThemeManager>();

  bool isDark = false;

  void toDarkMode() => isDark = true;

  void toLightMode() => isDark = false;

  bool get isDarkTheme => isDark;

  void init() {
    isDark = StorageManager.instance.get<bool?>(StorageKey.IS_DARK_THEME) ?? false;
    if (isDark) {
      emit(const IsDarkMode());
    } else {
      emit(const IsLightMode());
    }
  }

  Future<bool> changeTheme() async {
    isDark = !isDark;
    StorageManager.instance.save<bool>(StorageKey.IS_DARK_THEME, isDark);
    if (isDark) {
      emit(const IsDarkMode());
    } else {
      emit(const IsLightMode());
    }
    return isDark;
  }
}
