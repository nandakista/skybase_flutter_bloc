import 'dart:async';
import 'dart:convert';

import 'package:skybase/config/themes/theme_manager/theme_manager.dart';

import 'package:skybase/core/database/storage/storage_key.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';
import 'package:skybase/core/database/secure_storage/secure_storage_manager.dart';
import 'package:skybase/core/database/storage/cache_data.dart';
import 'package:skybase/data/models/user/user.dart';
import 'package:skybase/service_locator.dart';
import 'package:skybase/config/base/main_navigation.dart';
import 'package:skybase/ui/views/intro/intro_view.dart';
import 'package:skybase/ui/views/login/login_view.dart';
import 'package:skybase/ui/views/main_navigation/main_nav_view.dart';

enum AppType { INITIAL, FIRST_INSTALL, UNAUTHENTICATED, AUTHENTICATED }

/// This class will called first time before app go to pages.
///
/// This class help you to manage authentication process.
/// Contains auth general function such as [saveAuthData], [logout], and first install/[setup]
class AuthManager {
  static AuthManager get instance => sl<AuthManager>();

  StorageManager storage = StorageManager.instance;
  SecureStorageManager secureStorage = SecureStorageManager.instance;
  ThemeManager themeManager = ThemeManager.instance;

  AppType authState = AppType.INITIAL;

  AppType? get state => authState;

  StreamController<AppType> authStreamController = StreamController<AppType>();

  Stream<AppType?> get stream => authStreamController.stream;

  AuthManager() {
    authStreamController.add(authState);
    authStreamController.stream.distinct().listen((state) {
      authChanged(state);
    });
  }

  void authChanged(AppType state) async {
    return switch (state) {
      AppType.INITIAL => await setup(),
      AppType.FIRST_INSTALL =>
        Navigation.instance.pushAllReplacementNoContext(IntroView.route),
      AppType.UNAUTHENTICATED =>
        Navigation.instance.pushAllReplacementNoContext(LoginView.route),
      AppType.AUTHENTICATED =>
        Navigation.instance.pushAllReplacementNoContext(MainNavView.route),
    };
  }

  Future<void> setup() async {
    checkFirstInstall();
    await checkAppTheme();
    await clearExpiredCache();
  }

  Future<void> clearExpiredCache() async {
    await Future.wait(
      storage.sharedPreferences.getKeys().map((key) async {
        List<String> permanentKeys =
            StorageKey.permanentKeys + [StorageKey.USERS];

        if (!permanentKeys.contains(key)) {
          final now = DateTime.now();
          dynamic storageItem = await storage.get(key);
          CacheData cacheData = CacheData.fromJson(jsonDecode(storageItem));
          if (cacheData.expiredDate.isBefore(now)) await storage.delete(key);
        }
      }),
    );
  }

  /// Check if app is first time installed. It will navigate to Introduction Page
  void checkFirstInstall() async {
    final bool isFirstInstall =
        await storage.get(StorageKey.FIRST_INSTALL) ?? true;
    if (isFirstInstall) {
      await secureStorage.setToken(value: '');
      authState = AppType.FIRST_INSTALL;
      authStreamController.add(authState);
    } else {
      checkUser();
    }
  }

  /// Checking App Theme set it before app display
  Future<void> checkAppTheme() async {
    final bool isDarkTheme =
        await storage.get(StorageKey.IS_DARK_THEME) ?? false;
    if (isDarkTheme) {
      themeManager.toDarkMode();
    } else {
      themeManager.toLightMode();
    }
  }

  /// This function to used for checking is valid token to API Server use GET User Endpoint (token required).
  /// If response is Error it will passed to [logout] process.
  Future<void> checkUser() async {
    // TODO : Add your logic check user here
    final String? token = await secureStorage.getToken();
    if (token != null && token != '') {
      setAuth();
    } else {
      logout();
    }
  }

  /// Set auth state to AppType.AUTHENTICATED
  void setAuth() async {
    if (await secureStorage.isLoggedIn()) {
      authState = AppType.AUTHENTICATED;
      authStreamController.add(authState);
    }
  }

  /// Just call this function to managed logout process.
  /// It will stream state and auto redirect your apps to page based on their state
  /// with [authChanged] function
  Future<void> logout() async {
    await clearData();
    authState = AppType.UNAUTHENTICATED;
    authStreamController.add(authState);
  }

  Future<void> clearData() async {
    await secureStorage.logout();
    await storage.logout();
  }

  /// Just call this function to managed login process.
  /// It will stream state and auto redirect your apps to page based on their state
  /// with [authChanged] function
  /// * No need to navigate manually (Get.to or Get.off).
  Future<void> login({
    required User user,
    required String token,
    required String refreshToken,
  }) async {
    await saveAuthData(user: user, token: token, refreshToken: refreshToken);
    setAuth();
  }

  Future<void> saveAuthData({
    required User user,
    required String token,
    required String refreshToken,
  }) async {
    await saveUserData(user: user);
    await secureStorage.setToken(value: token);
    await secureStorage.setRefreshToken(value: refreshToken);
  }

  Future<void> saveUserData({required User user}) async {
    await storage.save<String>(StorageKey.USERS, jsonEncode(user.toJson()));
  }

  /// Get User data from Storage
  /// * No need to decode or call fromJson again when you used this helper
  User? get user {
    if (storage.has(StorageKey.USERS)) {
      return User.fromJson(
        jsonDecode(storage.get<String>(StorageKey.USERS)),
      );
    } else {
      return null;
    }
  }
}
