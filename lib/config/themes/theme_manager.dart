import 'package:get/get.dart';
import 'package:skybase/core/database/get_storage/storage_key.dart';
import 'package:skybase/core/database/get_storage/storage_manager.dart';
import 'package:skybase/service_locator.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class ThemeManager extends GetxService {
  static ThemeManager get find => sl<ThemeManager>();

  RxBool isDark = false.obs;
  void toDarkMode() => isDark.value = true;
  void toLightMode() => isDark.value = false;

  @override
  void onReady() {
    isDark.value = StorageManager.find.get<bool?>(StorageKey.IS_DARK_THEME) ?? false;
    super.onReady();
  }

  Future<Rx<bool>> changeTheme() async {
    if (isDark.isTrue) {
      StorageManager.find.save<bool>(StorageKey.IS_DARK_THEME, false);
    } else {
      StorageManager.find.save<bool>(StorageKey.IS_DARK_THEME, true);
    }
    return isDark.toggle();
  }
}