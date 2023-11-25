import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skybase/config/auth_manager/auth_manager.dart';
import 'package:skybase/core/localization/locale_manager.dart';
import 'package:skybase/data/repositories/auth/auth_repository.dart';
import 'package:skybase/data/repositories/auth/auth_repository_impl.dart';
import 'package:skybase/data/repositories/sample_feature/sample_feature_repository_impl.dart';
import 'package:skybase/data/sources/server/auth/auth_sources.dart';
import 'package:skybase/data/sources/server/auth/auth_sources_impl.dart';
import 'package:skybase/data/sources/server/sample_feature/sample_feature_sources.dart';
import 'package:skybase/ui/views/intro/bloc/intro_bloc.dart';
import 'package:skybase/ui/views/login/bloc/login_bloc.dart';
import 'package:skybase/ui/views/profile/bloc/profile_bloc.dart';
import 'package:skybase/ui/views/sample_feature/list/bloc/sample_feature_list_bloc.dart';
import 'package:skybase/ui/views/settings/bloc/setting_bloc.dart';

import 'config/network/api_config.dart';
import 'config/themes/app_theme.dart';
import 'config/themes/theme_manager/theme_manager.dart';
import 'config/app/app_info.dart';
import 'core/database/storage/storage_manager.dart';
import 'core/database/secure_storage/secure_storage_manager.dart';
import 'data/repositories/sample_feature/sample_feature_repository.dart';
import 'data/sources/server/sample_feature/sample_feature_sources_impl.dart';
import 'ui/views/profile/component/repository/bloc/profile_repository_bloc.dart';
import 'ui/views/sample_feature/detail/bloc/sample_feature_detail_bloc.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/

final sl = GetIt.instance;

class ServiceLocator {
  static Future<void> init() async {
    if (kReleaseMode) debugPrint = (String? message, {int? wrapWidth}) {};
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    AppInfo.setInfo(await PackageInfo.fromPlatform());

    // _initConfig
    sl.registerSingleton(const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    ));
    sl.registerLazySingleton(() => Dio());
    sl.registerLazySingleton(() => DioClient()..init());
    sl.registerSingleton<SharedPreferences>(sharedPreferences);

    // _initService
    sl.registerLazySingleton(() => SecureStorageManager());
    sl.registerSingleton(StorageManager());
    sl.registerSingleton(LocaleManager());
    sl.registerFactory(() => ThemeManager());
    sl.registerSingleton(AuthManager());

    // Repository
    sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(apiService: sl<AuthSources>()),
    );
    sl.registerLazySingleton<SampleFeatureRepository>(
      () => SampleFeatureRepositoryImpl(apiService: sl<SampleFeatureSources>()),
    );

    // Sources
    sl.registerLazySingleton<AuthSources>(() => AuthSourcesImpl());
    sl.registerLazySingleton<SampleFeatureSources>(
      () => SampleFeatureSourcesImpl(),
    );

    // Bloc
    sl.registerFactory(() => IntroBloc());
    sl.registerFactory(() => LoginBloc(sl<AuthRepository>()));
    sl.registerFactory(() => ProfileBloc(sl<AuthRepository>()));
    sl.registerFactory(() => SettingBloc());
    sl.registerFactory(() => ProfileRepositoryBloc(sl<AuthRepository>()));
    sl.registerFactory(
      () => SampleFeatureListBloc(sl<SampleFeatureRepository>()),
    );
    sl.registerFactory(
          () => SampleFeatureDetailBloc(sl<SampleFeatureRepository>()),
    );
  }
}
