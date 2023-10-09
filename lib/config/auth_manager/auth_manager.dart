import 'dart:async';
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:skybase/core/database/storage/storage_key.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';
import 'package:skybase/core/database/secure_storage/secure_storage_manager.dart';
import 'package:skybase/config/themes/theme_manager/theme_manager.dart';
import 'package:skybase/data/models/user/user.dart';
import 'package:skybase/service_locator.dart';
import 'package:skybase/core/base/main_navigation.dart';
import 'package:skybase/ui/views/intro/intro_view.dart';
import 'package:skybase/ui/views/login/login_view.dart';
import 'package:skybase/ui/views/main_navigation/main_nav_view.dart';

part 'auth_state.dart';

/// This class will called first time before app go to pages.
///
/// This class help you to manage authentication process.
/// Contains auth general function such as [saveAuthData], [logout], and first install/[setup]
class AuthManager extends Cubit<AuthState> {
  static AuthManager get find => sl<AuthManager>();

  AuthManager() : super(const Initial());

  StorageManager storage = StorageManager.find;
  SecureStorageManager secureStorage = SecureStorageManager.find;
  ThemeManager themeManager = ThemeManager.find;

  /// This will work only if you called from context.read.
  /// Recommendation to use from View using AuthWrapper
  void setAuth() async {
    if (await secureStorage.isLoggedIn()) {
      emit(const Authenticated());
    }
  }

  /// This will work only if you called from context.read.
  /// Recommendation to use from View using AuthWrapper
  void setUnAuth() async {
    emit(const Unauthenticated());
  }

  void init() {
    setup();
  }

  void authChanged(AuthState state) async {
    return switch (state) {
      Initial() => await setup(),
      FirstInstall() =>
        MainNavigation.contextLessPopAllReplacement(IntroView.route),
      Unauthenticated() =>
        MainNavigation.contextLessPopAllReplacement(LoginView.route),
      Authenticated() =>
        MainNavigation.contextLessPopAllReplacement(MainNavView.route),
    };
  }

  Future<void> setup() async {
    checkFirstInstall();
    await checkAppTheme();
  }

  /// Check if app is first time installed. It will navigate to Introduction Page
  void checkFirstInstall() async {
    final bool isFirstInstall =
        await storage.get(StorageKey.FIRST_INSTALL) ?? true;
    if (isFirstInstall) {
      await secureStorage.setToken(value: '');
      emit(const FirstInstall());
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

  /// Just call this function to managed logout process.
  /// It will stream state and auto redirect your apps to page based on their state
  /// with [authChanged] function
  Future<void> logout() async {
    await clearData();
    setUnAuth();
  }

  Future<void> clearData() async {
    await secureStorage.logout();
    await storage.logout();
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
