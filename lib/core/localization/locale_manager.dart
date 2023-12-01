import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:skybase/config/themes/app_colors.dart';
import 'package:skybase/config/themes/app_style.dart';
import 'package:skybase/config/base/main_navigation.dart';
import 'package:skybase/core/database/storage/storage_key.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';
import 'package:skybase/service_locator.dart';
import 'package:skybase/ui/widgets/sky_dialog.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
class LocaleManager {
  static LocaleManager get instance => sl<LocaleManager>();

  final Map<String, Locale> locales = {
    'English': const Locale('en'),
    'Indonesia': const Locale('id'),
  };

  final fallbackLocale = const Locale('en');

  void showLocaleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SkyDialog(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'txt_choose_language'.tr(),
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
                    updateLocale(context, locale);
                    Navigation.instance.pop(context);
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

  Future<void> updateLocale(BuildContext context, Locale locale) async {
    StorageManager.instance.save<String>(
      StorageKey.CURRENT_LOCALE,
      locale.languageCode,
    );
    context.setLocale(locale);
    await WidgetsBinding.instance.performReassemble();
  }

  Locale get getCurrentLocale {
    String? currentLanguageCode =
        StorageManager.instance.get(StorageKey.CURRENT_LOCALE);
    if (currentLanguageCode != null) {
      return currentLanguageCode.toLocale();
    } else {
      return fallbackLocale;
    }
  }
}
