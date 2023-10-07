import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skybase/core/database/get_storage/storage_key.dart';
import 'package:skybase/core/database/get_storage/storage_manager.dart';
import 'package:skybase/config/themes/app_colors.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/ui/widgets/sky_dialog.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class LocaleHelper {
  final Map<String, Locale> locales = {
    'English': const Locale('en'),
    'Indonesia': const Locale('id'),
  };

  final fallbackLocale = const Locale('en');

  static T builder<T>({
    required T en,
    required T id,
  }) {
    if (LocaleHelper().getCurrentLocale() == const Locale('en')) {
      return en;
    } else {
      return id;
    }
  }

  void showLocaleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SkyDialog(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'txt_choose_language'.tr,
                style: AppStyle.subtitle2.copyWith(color: AppColors.primary),
              ),
              const SizedBox(height: 16),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: locales.length,
                separatorBuilder: (context, index) =>
                    const Divider(thickness: 1.5),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    final locale = locales.entries.toList()[index].value;
                    updateLocale(locale);
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      locales.entries.toList()[index].key,
                      style: AppStyle.body1,
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void updateLocale(Locale locale) {
    StorageManager.find.save<String>(
      StorageKey.CURRENT_LOCALE,
      locale.languageCode,
    );
    Get.updateLocale(locale);
  }

  Locale getCurrentLocale() {
    String? currentLanguageCode =
        StorageManager.find.get(StorageKey.CURRENT_LOCALE);
    if (currentLanguageCode != null) {
      if (currentLanguageCode == 'en') {
        return const Locale('en');
      } else {
        return const Locale('id');
      }
    } else {
      StorageManager.find.save<String>(StorageKey.CURRENT_LOCALE, "en");
      return const Locale('en');
    }
  }
}
