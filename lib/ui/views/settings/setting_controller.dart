// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:skybase/core/database/get_storage/storage_key.dart';
// import 'package:skybase/core/database/get_storage/storage_manager.dart';
// import 'package:skybase/core/helper/dialog_helper.dart';
// import 'package:skybase/config/localization/locale_helper.dart';
//
// class SettingController extends GetxController {
//   final language = Rxn<Map<String, dynamic>>();
//
//   @override
//   void onInit() {
//     Locale currentLocale = LocaleHelper().getCurrentLocale();
//     if (currentLocale == const Locale('en')) {
//       language.value = {
//         'name': 'English',
//         'locale': 'en',
//       };
//     } else {
//       language.value = {
//         'name': 'Indonesia',
//         'locale': 'id',
//       };
//     }
//     super.onInit();
//   }
//
//   void onUpdateLocale(String value) {
//     Map<String, dynamic> lang = jsonDecode(value.toString());
//     language.value = lang;
//     if (lang['name'].toString() == "English") {
//       StorageManager.find.save<String>(StorageKey.CURRENT_LOCALE, "en");
//     } else {
//       StorageManager.find.save<String>(StorageKey.CURRENT_LOCALE, "in");
//     }
//     Get.updateLocale(Locale(lang['locale']));
//   }
//
//   void onLogout() async {
//     LoadingDialog.show(Get.context!);
//     // AuthManager.find.logout();
//   }
// }
