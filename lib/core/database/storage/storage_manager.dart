import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skybase/core/database/storage/storage_key.dart';
import 'package:skybase/service_locator.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/

class StorageManager {
  SharedPreferences sharedPreferences = sl<SharedPreferences>();
  static StorageManager get instance => sl<StorageManager>();

  /// If you want to save Object/Model don't forget to encode toJson
  Future<void> save<T>(String name, T value) async {
    if (value is String) {
      await sharedPreferences.setString(name, value);
    } else if (value is bool) {
      await sharedPreferences.setBool(name, value);
    } else if (value is int) {
      await sharedPreferences.setInt(name, value);
    } else if (value is double) {
      await sharedPreferences.setDouble(name, value);
    } else if (value is List<String>) {
      await sharedPreferences.setStringList(name, value);
    }
  }

  Future<void> delete(String name) async {
    await sharedPreferences.remove(name);
  }

  /// If you want to get Object/Model don't forget to decode fromJson
  T get<T>(String name) {
    return sharedPreferences.get(name) as T;
  }

  bool has(String name) {
    return sharedPreferences.containsKey(name);
  }

  Future<void> logout() async {
    try {
      List<String> permanentKeys = StorageKey.permanentKeys;
      List<String> deleteKeys = (sharedPreferences.getKeys()).where((key) {
        return !permanentKeys.contains(key);
      }).toList();

      for (var key in deleteKeys) {
        await sharedPreferences.remove(key);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
